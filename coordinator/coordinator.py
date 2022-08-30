from signal import signal, SIGINT
from python_udp_helper import UdpSenderThread, UdpReceiverThread
from python_binary_udp_helper import UdpBinarySenderThread, UdpBinaryReceiverThread

import sys
import socket
import time
import logging
from threading import Thread
import Colorer
import pandas as pd
import abh_constants as abh
from enum import Enum





class Status(Enum):
    FORWARD   =  1
    BACKWARD  = -1
    STOP      =  0
    UNDEFINED =  2

stop=False
def handler(signal_received, frame):
    global stop
    stop=True



def exercise_thread():
    global stop
    logging.debug("starting")



    df = pd.read_excel (r'/home/abhorizon/Scrivania/esercizi.xlsx', sheet_name='ParameteriForza')
    logging.debug("creating client from gui")
    itrial=0

    exercise_client=-1
    startstop_client=-1
    exercise_name_eval=-1
    motor_target=-1
    repetition_udp=-1
    repetition_udp_repetiter=-1



    while (not stop):
        try:
            exercise_client = UdpReceiverThread("exercise_name_d",abh.ABH_CONTROL,abh.EXERCISE_NAME_DM_PORT)
            exercise_client.start()
            startstop_client = UdpReceiverThread("startstop_client_d",abh.ABH_CONTROL,abh.START_EXERCISE_PORT)
            startstop_client.start()
            repetition_udp = UdpBinaryReceiverThread("repetition_udp",abh.ABH_VISION,abh.REP_COUNT_PORT)
            repetition_udp.start()
            repetition_udp.bufferLength(2)


            motor_fb_udp = UdpBinaryReceiverThread("motor_feedback",abh.ABH_CONTROL,abh.MOTOR_FEEDBACK_PORT)
            motor_fb_udp.start()
            motor_fb_udp.bufferLength(2)

            logging.debug("connected with gui")
            break
        except:
            if itrial % 60==0:
                logging.debug("waiting for connection with Display manager.")
            itrial+=1
            time.sleep(1)
    if (stop):
        logging.info("stopped before connecting with Display manager, tried %d times", itrial)
        del exercise_name_eval
        return


    logging.debug("connected with Display manager")
    logging.debug("create server for vision")

    try:
        exercise_name_eval = UdpSenderThread("exercise_name_eval",abh.ABH_VISION,abh.EXERCISE_NAME_PORT)
        repetition_udp_repetiter = UdpBinarySenderThread("repetition_udp_repetiter",abh.ABH_VISION,abh.REP_COUNT_PORT_DM)
    except Exception as e:
        #stop=True
        logging.error("unable to connect with Evaluator")
        logging.critical(str(e), exc_info=True)  # log exception info at CRITICAL log level

    logging.debug("connected with Evaluator")
    logging.debug("create server for motor control")

    try:
        motor_target = UdpBinarySenderThread("motor_target",abh.ABH_CONTROL,abh.MOTOR_TARGET_PORT)
        motor_target.start()
    except Exception as e:
        stop=True
        logging.error("unable to connect with motor control")
        logging.critical(str(e), exc_info=True)  # log exception info at CRITICAL log level


    logging.debug("connected with motor control")

    exercise=dict.fromkeys(['name','level','difficulty','force','velocity'])

    exercise["name"]=""
    exercise["level"]="1"
    exercise["difficulty"]="0"
    exercise["force"]=0.0
    exercise["force_return"]=0.0
    exercise["velocity"]=0.0


    motor_speed_threshold=1.0
    motor_speed_threshold_return=-1.0
    torque_change_time=0.5

    state=Status.STOP
    last_state=Status.UNDEFINED
    repetition_count=0.0
    direction=0.0

    motor_speed=0.0



    while (not stop):
        time.sleep(0.001)

        if (exercise_client.isNewStringAvailable()):
            stringa=exercise_client.getLastStringAndClearQueue()
            print(stringa)
            esercizio=stringa.split(";")
            if len(esercizio)!=3:
                print("partial string: ",stringa)
                continue
            if esercizio[0]=="stop":
                esercizio[0]="stop"
            try:
                es_data=df[(df.Name==esercizio[0])&(df.Level==int(esercizio[1]))&(df.Difficulty==esercizio[2])]
            except:
                print("invalid exercise = ", stringa)
                continue
            if (len(es_data)==0):
                logging.warning("exercise not found: %s", esercizio)
                continue
            exercise["name"]=esercizio[0]
            exercise["level"]=int(esercizio[1])
            exercise["difficulty"]=esercizio[2]
            exercise["force"]=es_data.Force.iloc[0]
            exercise["force_return"]=es_data.ForceReturn.iloc[0]
            exercise["velocity"]=es_data.Velocity.iloc[0]
            torque_change_time=es_data.TimeFrom0To100.iloc[0]
            motor_speed_threshold=es_data.PositiveVelocityThreshold.iloc[0]
            motor_speed_threshold_return=es_data.NegativeVelocityThreshold.iloc[0]

            if not isinstance(exercise_name_eval,int):
                exercise_name_eval.sendString(esercizio[0])
        if (startstop_client.isNewStringAvailable()):
            stringa=startstop_client.getLastStringAndClearQueue()
            if stringa[0:5]=="start" :
                state=Status.FORWARD
                change_direction=True
                motor_target_data=[0,exercise["force"]/100,exercise["velocity"]/100,torque_change_time]
                if not isinstance(exercise_name_eval,int):
                    exercise_name_eval.sendString("start")

            elif stringa=="stop":
                state=Status.STOP
                motor_target_data=[1,0,0,0.5]

                if not isinstance(exercise_name_eval,type):
                    exercise_name_eval.sendString("stop")
            else:
                logging.warning("startstop_client_d should receive start or stop. received: "+stringa)


        if (motor_fb_udp.isNewDataAvailable()):
            motor_fb=motor_fb_udp.getLastDataAndClearQueue()
            if len(motor_fb)==2:
                motor_speed=motor_fb[1]
        if (repetition_udp.isNewDataAvailable()):
            repetition_state=repetition_udp.getData()
            if len(repetition_state)==2:
                repetition_count=float(repetition_state[0])
                direction=float(repetition_state[1])

                if (motor_speed<motor_speed_threshold and state == Status.FORWARD and direction==-1):
                    state=Status.BACKWARD
                    #print(motor_speed)
                elif (motor_speed>motor_speed_threshold_return and state == Status.BACKWARD and direction==1):
                    state=Status.FORWARD
                    #print(motor_speed)
                elif (state == Status.UNDEFINED and direction==1):
                    state=Status.FORWARD
                elif (state == Status.UNDEFINED and direction==-1):
                    state=Status.BACKWARD
                elif (direction==5):
                    state=Status.UNDEFINED
                    print("non c'è nessuno")
                    #print(motor_speed)
    
        if (state == Status.STOP):
            repetition_count=0.0
            direction=0.0
        repetition_udp_repetiter.sendData([repetition_count,direction,motor_speed])

        if (last_state != state):
            if (state == Status.FORWARD):
                motor_target_data=[0,exercise["force"]/100,exercise["velocity"]/100,torque_change_time]
                logging.debug("Forward")
            elif (state == Status.BACKWARD):
                motor_target_data=[0,exercise["force_return"]/100,exercise["velocity"]/100,torque_change_time]
                logging.debug("Backward")
            elif (state == Status.STOP):
                motor_target_data=[1,0,0,1]
                logging.debug("Stop")
            elif (state == Status.UNDEFINED):
                motor_target_data=[1,0,0,1]
                logging.debug("undefined")
            motor_target.sendData(motor_target_data)
            last_state=state

    print(isinstance(exercise_client,int))
    if not isinstance(exercise_client,type):
        exercise_client.stopThread()
        exercise_client.join()
    else:
        logging.debug("exercise client is off")

    if not isinstance(startstop_client,int):
        startstop_client.stopThread()
        startstop_client.join()
    else:
        logging.debug("startstop_client is off")

    if not isinstance(repetition_udp,int):
        repetition_udp.stopThread()
        repetition_udp.join()
    else:
        logging.debug("repetition_udp is off")

    if not isinstance(motor_fb_udp,int):
        motor_fb_udp.stopThread()
        motor_fb_udp.join()
    else:
        logging.debug("motor_fb_udp is off")


    logging.debug("return clean")


if __name__ == '__main__':
    # %% initialization
    signal(SIGINT, handler)
    logging.basicConfig(filename='coordinator.log', level=logging.DEBUG, format=' [%(asctime)s,%(filename)s:%(lineno)-4s - %(funcName)20s()] %(levelname)-8s :: %(message)s', filemode='w')
    logger = logging.getLogger(__name__)
    console = logging.StreamHandler()
    console.setFormatter(logging.Formatter(logging.BASIC_FORMAT))
    console.setLevel(logging.INFO)
    logging.getLogger('').addHandler(console)
    # %%
    ex_thread = Thread(target=exercise_thread, args=())
    ex_thread.start()
    while (not stop):
        time.sleep(0.1)

    ex_thread.join()
    logging.info("return clean")
