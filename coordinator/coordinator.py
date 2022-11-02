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

import os
import getpass



path=os.path.dirname(os.path.realpath(__file__))
user=getpass.getuser()

class Status(Enum):
    FORWARD   =  1
    BACKWARD  = -1
    STOP      =  0
    UNDEFINED =  2
    REWIRE    =  3

stop=False
def handler(signal_received, frame):
    global stop
    stop=True



def exercise_thread():
    global stop
    logging.debug("starting")



    if (user!='jacobi'):
        df = pd.read_excel (r'/home/abhorizon/Scrivania/abh_data/esercizi.xlsx', sheet_name='ParameteriForza')
        df_forza=pd.read_csv(r'/home/abhorizon/Scrivania/abh_data/livelli_potenza.csv')
    else:
        df = pd.read_excel (r'/home/jacobi/projects/abh_data/esercizi.xlsx', sheet_name='ParameteriForza')
        df_forza=pd.read_csv(r'/home/jacobi/projects/abh_data/livelli_potenza.csv')
    logging.debug("creating client from gui")
    itrial=0

    exercise_client=-1
    startstop_client=-1
    user_client=-1
    exercise_name_eval=-1
    motor_target=-1
    repetition_udp=-1
    repetition_udp_repetiter=-1
    percentage=0



    while (not stop):
        try:
            exercise_client = UdpReceiverThread("exercise_name_d",abh.ABH_CONTROL,abh.EXERCISE_NAME_DM_PORT)
            exercise_client.start()
            startstop_client = UdpReceiverThread("startstop_client_d",abh.ABH_CONTROL,abh.START_EXERCISE_PORT)
            startstop_client.start()
            user_client = UdpReceiverThread("user_client_d",abh.ABH_CONTROL,abh.UTENTE_PORT)
            user_client.start()
            power_client = UdpBinaryReceiverThread("power_client_d",abh.ABH_CONTROL,abh.POWER_NAME_DM_PORT)
            power_client.bufferLength(1)
            power_client.start()
            repetition_udp = UdpBinaryReceiverThread("repetition_udp",abh.ABH_VISION,abh.REP_COUNT_PORT)
            repetition_udp.bufferLength(3)
            repetition_udp.start()


            motor_fb_udp = UdpBinaryReceiverThread("motor_feedback",abh.ABH_CONTROL,abh.MOTOR_FEEDBACK_PORT)
            motor_fb_udp.bufferLength(2)
            motor_fb_udp.start()

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
    exercise["force"]=0.0
    exercise["force_return"]=0.0
    exercise["velocity"]=0.0


    motor_speed_threshold=1.0
    motor_speed_threshold_return=-1.0
    torque_change_time=0.5

    motor_speed_early_stop=0.1
    percentage_early_stop=90
    motor_speed_early_stop_return=-0.1
    percentage_early_stop_return=10

    state=Status.STOP
    last_state=Status.UNDEFINED
    repetition_count=0.0
    direction=0.0

    motor_speed=0.0

    while (not stop):
        time.sleep(0.001)

        if (power_client.isNewDataAvailable()):
            power_array=power_client.getLastDataAndClearQueue()
            power_level=min(20,max(1,int(power_array[0])))
            parametri_forza=df_forza[df_forza.power==power_level]
            exercise["force"]=parametri_forza.force.iloc[0]
            exercise["force_return"]=parametri_forza.force_return.iloc[0]
            exercise["velocity"]=parametri_forza.velocity.iloc[0]

        if (exercise_client.isNewStringAvailable()):
            esercizio=exercise_client.getLastStringAndClearQueue()
            try:
                es_data=df[(df.Name==esercizio)]
            except:
                print("invalid exercise = ", stringa)
                continue
            if (len(es_data)==0):
                logging.warning("exercise not found: %s", esercizio)
                continue
            exercise["name"]=esercizio
            torque_change_time=es_data.TimeFrom0To100.iloc[0]
            motor_speed_threshold=es_data.PositiveVelocityThreshold.iloc[0]
            motor_speed_threshold_return=es_data.NegativeVelocityThreshold.iloc[0]
            motor_speed_early_stop=es_data.VelocityEndPhase.iloc[0]
            percentage_early_stop=es_data.PercentageEndPhase.iloc[0]
            motor_speed_early_stop_return=es_data.VelocityEndPhaseReturn.iloc[0]
            percentage_early_stop_return=es_data.PercentageEndPhaseReturn.iloc[0]

            if (not isinstance(exercise_name_eval,int)):
                exercise_name_eval.sendString(esercizio)
                print("send ", esercizio)

        if (user_client.isNewStringAvailable()):
            stringa=user_client.getLastStringAndClearQueue()
            if (stringa):
                print("user_"+stringa)
                exercise_name_eval.sendString("user_"+stringa)

        if (startstop_client.isNewStringAvailable()):
            stringa=startstop_client.getLastStringAndClearQueue()
            print(stringa)
            if stringa[0:5]=="start" :
                state=Status.FORWARD
                change_direction=True
                motor_target_data=[0,exercise["force"]/100,exercise["velocity"]/100,torque_change_time]
                if not isinstance(exercise_name_eval,int):
                    exercise_name_eval.sendString("start")

            elif stringa=="rewire":
                state=Status.REWIRE
                motor_target_data=[0,0.20,0.2,1]
                print("rewire on")
            elif stringa=="stop_rewire":
                state=Status.STOP
                motor_target_data=[1,0,0,0.5]
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
            if len(repetition_state)==3:
                repetition_count=float(repetition_state[0])
                direction=float(repetition_state[1])
                percentage=float(repetition_state[2])

                # if (motor_speed<motor_speed_threshold and state == Status.FORWARD and direction==-1):
                #     state=Status.BACKWARD
                #     #print(motor_speed)
                # elif (motor_speed>motor_speed_threshold_return and state == Status.BACKWARD and direction==1):
                #     state=Status.FORWARD
                #     #print(motor_speed)

        if ( (state == Status.FORWARD) and
             ( (motor_speed<motor_speed_threshold and direction==-1) or
               ((motor_speed<motor_speed_early_stop) and  (percentage>percentage_early_stop))
             )
           ):
            state=Status.BACKWARD
            #print(motor_speed)
        elif ( (state == Status.BACKWARD) and
             ( (motor_speed>motor_speed_threshold_return and direction==1) or
               ((motor_speed>motor_speed_early_stop_return) and  (percentage<percentage_early_stop_return))
             )
           ):
            state=Status.FORWARD
            #print(motor_speed)
        elif (state == Status.UNDEFINED and direction==1):
            state=Status.FORWARD
        elif (state == Status.UNDEFINED and direction==-1):
            state=Status.BACKWARD
        elif (direction==5):
            state=Status.UNDEFINED
            #print(motor_speed)

        if (state == Status.STOP):
            repetition_count=0.0
            direction=0.0


        repetition_udp_repetiter.sendData([repetition_count,direction,motor_speed,percentage])

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
            elif (state == Status.REWIRE):
                motor_target_data=[0,0.20,0.2,1]
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

    if not isinstance(user_client,int):
        user_client.stopThread()
        user_client.join()
    else:
        logging.debug("user_client is off")

    if not isinstance(power_client,int):
        power_client.stopThread()
        power_client.join()
    else:
        logging.debug("power_client is off")



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
