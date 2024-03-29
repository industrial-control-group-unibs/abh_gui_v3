from signal import signal, SIGINT
from python_udp_helper import UdpSenderThread, UdpReceiverThread
from python_binary_udp_helper import UdpBinarySenderThread, UdpBinaryReceiverThread

import sys
import socket
import time
from threading import Thread
import Colorer
import pandas as pd
import abh_constants as abh
from enum import Enum

import os
import getpass
pd.options.mode.chained_assignment = None  # default='warn'


path=os.path.dirname(os.path.realpath(__file__))
user=getpass.getuser()

class Status(Enum):
    FORWARD   =  1
    BACKWARD  = -1
    STOP      =  0
    UNDEFINED =  2
    REWIRE    =  3

class MotorStatus(Enum):
    MOVE_FORWARD = 1
    REST_FORWARD = 2
    MOVE_BACKWARD = 3
    REST_BACKWARD = 4

stop=False
def handler(signal_received, frame):
    global stop
    stop=True



def exercise_thread():
    global stop
    print("starting coordinator", file=sys.stderr)



    if (user!='jacobi'):
        df = pd.read_excel (r'/home/'+user+'/Scrivania/abh/abh_data/esercizi_controllo.xlsx', sheet_name='ParameteriForza')
        df_forza=pd.read_csv(r'/home/'+user+'/Scrivania/abh/abh_data/livelli_potenza.csv')
    else:
        df = pd.read_excel (r'/home/jacobi/projects/abh//abh_data/esercizi_controllo.xlsx', sheet_name='ParameteriForza')
        df_forza=pd.read_csv(r'/home/jacobi/projects/abh/abh_data/livelli_potenza.csv')
    itrial=0

    exercise_client=-1
    startstop_client=-1
    user_client=-1
    power_client=-1
    parameters_client=-1
    type_client=-1
    exercise_name_eval=-1
    motor_target=-1
    repetition_udp=-1
    repetition_udp_repetiter=-1
    percentage=0
    percentage_graph=0
    calibrating=False
    initializing=False

    motor_status = MotorStatus.REST_BACKWARD


    exercise_parameters=[0,0,0,0, 0,0,0,0]
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
            parameters_client = UdpBinaryReceiverThread("parameters_client", abh.ABH_CONTROL, abh.PARAMETER_DM)
            parameters_client.bufferLength(9)
            parameters_client.start()

            type_client = UdpBinaryReceiverThread("type_client_d",abh.ABH_CONTROL,abh.TYPE_PORT)
            type_client.bufferLength(1)
            type_client.start()
            vosk_client = UdpBinaryReceiverThread("vosk_client_d",abh.ABH_CONTROL,abh.COMANDI_VOCALI_PORT)
            vosk_client.bufferLength(1)
            vosk_client.start()

            repetition_udp = UdpBinaryReceiverThread("repetition_udp",abh.ABH_VISION,abh.REP_COUNT_PORT)
            repetition_udp.bufferLength(3)
            repetition_udp.start()


            motor_fb_udp = UdpBinaryReceiverThread("motor_feedback",abh.ABH_CONTROL,abh.MOTOR_FEEDBACK_PORT)
            motor_fb_udp.bufferLength(4)
            motor_fb_udp.start()

            print("connected with gui")
            break
        except:
            if itrial % 60==0:
                print("waiting for connection with Display manager.")
            itrial+=1
            time.sleep(1)
    if (stop):
        print(f"stopped before connecting with Display manager, tried {itrial} times")
        del exercise_name_eval
        return


    try:
        exercise_name_eval = UdpSenderThread("exercise_name_eval",abh.ABH_VISION,abh.EXERCISE_NAME_PORT)
        repetition_udp_repetiter = UdpBinarySenderThread("repetition_udp_repetiter",abh.ABH_VISION,abh.REP_COUNT_PORT_DM)
    except Exception as e:
        print("unable to connect with Evaluator")


    try:
        motor_target = UdpBinarySenderThread("motor_target",abh.ABH_CONTROL,abh.MOTOR_TARGET_PORT)
        motor_target.start()
    except Exception as e:
        stop=True
        print("unable to connect with motor control")



    exercise=dict.fromkeys(['name','level','difficulty','force','velocity'])

    exercise["name"]=""
    exercise["force"]=0.0
    exercise["force_return"]=0.0
    exercise["velocity"]=0.0


    motor_speed_threshold=1.0
    motor_speed_threshold_return=-1.0
    torque_change_time_bw=0.5
    torque_change_time_fw=0.5
    exercise_type=1

    motor_speed_early_stop=0.1
    percentage_early_stop=90
    motor_speed_early_stop_return=-0.1
    percentage_early_stop_return=10

    state=Status.STOP
    last_state=Status.UNDEFINED
    repetition_count=1.0
    direction=0.0

    motor_speed=0.0
    real_current_value = 0.0
    reference_current_value = 0.0

    max_pos_motor_speed=0.0
    max_neg_motor_speed=0.0

    resend=False
    started = False

    vosk_command=0

    last_rep_count_from_vision=0

    switch_timer=0
    switch_timer_th=1

    power_level = 1

    # if power level == zero, use the the level=1 for the first repetitions
    force_power_level_0_last_reps = 0.0
    force_power_level_0_first_reps = 0.0
    force_power_first_reps = 0.0
    force_power_last_reps = 0.0

    vision_msg_counter=0

    none_counter = 0
    rest_counter = 0
    handles_up = True

    manual_training = True
    while (not stop):
        time.sleep(0.001)
        switch_timer += 0.001

        if (vosk_client.isNewDataAvailable()):
            vosk_command=vosk_client.getLastDataAndClearQueue()[0]
            if vosk_command>0:
                print(f"vosk comamnd={vosk_command}")

        if (type_client.isNewDataAvailable()):
            exercise_type=type_client.getLastDataAndClearQueue()[0]
            print(f"exercise_type: {exercise_type}")
            if exercise_type==0:
                print(f"exercise_type: {exercise_type}")
                exercise_type=1

        if (power_client.isNewDataAvailable()):
            power_array=power_client.getLastDataAndClearQueue()
            print("received ",power_array)
            power_level=min(25,max(0,int(power_array[0])))
            parametri_forza=df_forza[df_forza.power == power_level]

            if handles_up:
                exercise["force"]=parametri_forza.force_handles_up.iloc[0]
                exercise["force_return"]=parametri_forza.force_return_handles_up.iloc[0]
            else:
                exercise["force"] = parametri_forza.force_handles_down.iloc[0]
                exercise["force_return"] = parametri_forza.force_return_handles_down.iloc[0]

            force_power_last_reps = exercise["force"]
            exercise["velocity"]=parametri_forza.velocity.iloc[0]
            tmp = df_forza[df_forza.power == 0]
            if handles_up:
                force_power_first_reps = parametri_forza.force_return_handles_up.iloc[0]
            else:
                force_power_first_reps = parametri_forza.force_return_handles_down.iloc[0]
            if power_level == 0:
                force_power_level_0_last_reps = exercise["force"]
                tmp = df_forza[df_forza.power == power_level+1]
                if handles_up:
                    force_power_level_0_first_reps = tmp.force_handles_up.iloc[0]
                else:
                    force_power_level_0_first_reps = tmp.force_handles_up.iloc[0]
            if manual_training:
                if handles_up:
                    force_power_last_reps = parametri_forza.force_return_handles_up.iloc[0]
                else:
                    force_power_last_reps = parametri_forza.force_return_handles_down.iloc[0]

            print(f"forza: {exercise}")

            if started:
                resend = True

        if (exercise_client.isNewStringAvailable()):
            esercizio=exercise_client.getLastStringAndClearQueue()
            repetition_count = 1
            if (esercizio=="photo"):
                exercise_name_eval.sendString(esercizio)
                continue

            manual_training =  esercizio == "novision"

            try:
                es_data=df[(df.Name==esercizio)]
            except:
                print("invalid exercise = ", stringa)
                continue
            if (len(es_data)==0):
                print(f"exercise not found: {esercizio}")
                continue

            exercise["name"]=esercizio
            torque_change_time_fw = es_data.TimeFrom0To100Forward.iloc[0]
            torque_change_time_bw = es_data.TimeFrom0To100Backward.iloc[0]
            motor_speed_threshold=es_data.PositiveVelocityThreshold.iloc[0]
            motor_speed_threshold_return=es_data.NegativeVelocityThreshold.iloc[0]
            motor_speed_early_stop=es_data.VelocityEndPhase.iloc[0]
            percentage_early_stop=es_data.PercentageEndPhase.iloc[0]
            motor_speed_early_stop_return=es_data.VelocityEndPhaseReturn.iloc[0]
            percentage_early_stop_return=es_data.PercentageEndPhaseReturn.iloc[0]
            handles_up = es_data.HandlesUp.iloc[0] == 1
            if handles_up:
                print("Maniglie in alto")
            else:
                print("Maniglie in basso")

            exercise_parameters=[motor_speed_threshold,-motor_speed_threshold_return,torque_change_time_fw,
                                 torque_change_time_bw,motor_speed_early_stop,percentage_early_stop,
                                 -motor_speed_early_stop_return,percentage_early_stop_return]

            if (not isinstance(exercise_name_eval,int)):
                exercise_name_eval.sendString(esercizio)
                print("send to vision the code  =  ", esercizio)

        if (user_client.isNewStringAvailable()):
            stringa=user_client.getLastStringAndClearQueue()
            if (stringa):
                exercise_name_eval.sendString("user_"+stringa)

        if (parameters_client.isNewDataAvailable()):
            parameters_array=parameters_client.getLastDataAndClearQueue()
            motor_speed_threshold = parameters_array[0]
            motor_speed_threshold_return = -parameters_array[1]
            torque_change_time_fw = parameters_array[2]
            torque_change_time_bw = parameters_array[3]
            motor_speed_early_stop = parameters_array[4]
            percentage_early_stop = parameters_array[5]
            motor_speed_early_stop_return = -parameters_array[6]
            percentage_early_stop_return = parameters_array[7]
            save_parameters = parameters_array[8]
            try:
                es_data=df[(df.Name==esercizio)]
                es_data.TimeFrom0To100Forward.iloc[0] = torque_change_time_fw
                es_data.TimeFrom0To100Backward.iloc[0] = torque_change_time_bw
                es_data.PositiveVelocityThreshold.iloc[0] = motor_speed_threshold
                es_data.NegativeVelocityThreshold.iloc[0] = motor_speed_threshold_return
                es_data.VelocityEndPhase.iloc[0] = motor_speed_early_stop
                es_data.PercentageEndPhase.iloc[0] = percentage_early_stop
                es_data.VelocityEndPhaseReturn.iloc[0] = motor_speed_early_stop_return
                es_data.PercentageEndPhaseReturn.iloc[0] = percentage_early_stop_return



                if save_parameters>0:
                    df[(df.Name == esercizio)] = es_data
                    if (user != 'jacobi'):
                        df.to_excel(r'/home/' + user + '/Scrivania/abh/abh_data/esercizi_controllo.xlsx',
                                           sheet_name='ParameteriForza')
                    else:
                        df.to_excel(r'/home/jacobi/projects/abh//abh_data/esercizi_controllo.xlsx',
                                           sheet_name='ParameteriForza')
            except:
                print("invalid exercise = ", esercizio)
                continue

            print(f"parameters = {parameters_array}")

        if (startstop_client.isNewStringAvailable()):
            stringa=startstop_client.getLastStringAndClearQueue()
            started = False
            if stringa=="start":
                started = True
                repetition_count=1
                percentage = 0
                max_pos_motor_speed=0.0
                max_neg_motor_speed=0.0
                last_state = Status.UNDEFINED
                print(f"exercise: {exercise}")

                if (exercise_type==1):
                    state=Status.BACKWARD
                    change_direction=True
                    motor_target_data=[0,exercise["force"]/100,exercise["velocity"]/100,torque_change_time_bw]
                if not isinstance(exercise_name_eval,int):
                    print("Start vision")
                    exercise_name_eval.sendString(esercizio)
                    exercise_name_eval.sendString("start")

            elif stringa=="rewire":
                state=Status.REWIRE
                motor_target_data=[0,0.20,0.2,1]
                print("rewire on")
            elif stringa=="stop_rewire":
                started = False
                repetition_count = 1
                state=Status.STOP
                motor_target_data=[1,0,0,0.5]
            elif stringa=="stop":
                print("Stop motor")
                repetition_count = 1
                state=Status.STOP
                motor_target_data=[1,0,0,0.5]

                if not isinstance(exercise_name_eval,type):
                    exercise_name_eval.sendString("stop")
            elif stringa == "restart_vision":
                exercise_name_eval.sendString("stop")
                exercise_name_eval.sendString(esercizio)
                exercise_name_eval.sendString("start")

            else:
                print(f"startstop_client_d should receive start or stop. received: {stringa}")


        if (motor_fb_udp.isNewDataAvailable()):
            motor_fb=motor_fb_udp.getLastDataAndClearQueue()
            if len(motor_fb)==4:
                motor_speed=motor_fb[1]
                real_current_value = motor_fb[2]
                reference_current_value = motor_fb[3]


            max_pos_motor_speed=max(motor_speed,max_pos_motor_speed)
            max_neg_motor_speed=min(motor_speed,max_neg_motor_speed)
        if (repetition_udp.isNewDataAvailable()):
            repetition_state=repetition_udp.getData()
            if len(repetition_state)==3:
                vision_msg_counter=0

                rep_count_from_vision=float(repetition_state[0])
                direction=float(repetition_state[1])
                percentage_graph=max(0.0,float(repetition_state[2]))

                if  (state == Status.FORWARD):
                    percentage=max(percentage,max(0,float(repetition_state[2])))
                elif (state == Status.BACKWARD):
                    percentage=min(percentage,max(0,float(repetition_state[2])))
                initializing=repetition_state[2] == -30
                calibrating=repetition_state[2] == -50
                if repetition_state[2] < 0:
                    percentage = 50.0

                #print(rep_count_from_vision,exercise_type)

                if exercise_type>1:
                    if last_rep_count_from_vision!=rep_count_from_vision:
                        repetition_count=repetition_count+1
                elif ((last_rep_count_from_vision!=rep_count_from_vision) and (max_pos_motor_speed>10) and (max_neg_motor_speed<-2)):
                    repetition_count=repetition_count+1
                    max_pos_motor_speed=0.0
                    max_neg_motor_speed=0.0

                last_rep_count_from_vision=rep_count_from_vision
            else:
              print("lunghezza messaggio visione non corretta")
        else:
            if state == Status.STOP:
                vision_msg_counter=0
            else:
                vision_msg_counter+=1
            if (vision_msg_counter>10000):
              print("no messaggi da visione")
              vision_msg_counter=0
              rep_count_from_vision=-10

        if manual_training:
            calibrating = True
            #force_power_level_0_first_reps=force_power_level_0_last_reps
            #force_power_first_reps=force_power_last_reps


        prev_motor_status = motor_status
        if motor_status == MotorStatus.REST_BACKWARD and motor_speed<motor_speed_threshold_return*2.0:
            motor_status = MotorStatus.MOVE_BACKWARD
        elif motor_status == MotorStatus.REST_BACKWARD and motor_speed>0:
            motor_status = MotorStatus.REST_FORWARD
        elif motor_status == MotorStatus.MOVE_BACKWARD and motor_speed>motor_speed_threshold_return:
            motor_status = MotorStatus.REST_FORWARD
        elif motor_status == MotorStatus.REST_FORWARD and motor_speed>motor_speed_threshold*2:
            motor_status = MotorStatus.MOVE_FORWARD
        elif motor_status == MotorStatus.REST_FORWARD and motor_speed < 0:
            motor_status = MotorStatus.REST_BACKWARD
        elif motor_status == MotorStatus.MOVE_FORWARD and motor_speed<motor_speed_threshold:
            motor_status = motor_status

        if prev_motor_status != motor_status:
            print(f"switch from {prev_motor_status} to {motor_status}")

        if started and (motor_status==MotorStatus.REST_FORWARD or MotorStatus.REST_BACKWARD):
            rest_counter+=1
        else:
            rest_counter =0

        if ( (state == Status.FORWARD) and
             ( (motor_speed<motor_speed_threshold and direction==-1 and exercise["force"]<30  and (switch_timer>switch_timer_th)) or
               ((motor_speed<motor_speed_early_stop) and  (percentage>percentage_early_stop)) or
               (( initializing or calibrating)  and (motor_status == motor_status.REST_BACKWARD and motor_status == motor_status.MOVE_BACKWARD))
             )
           ):
            state=Status.BACKWARD
            switch_timer=0
        elif ( (state == Status.BACKWARD) and
             ( (motor_speed>motor_speed_threshold_return and direction==1 and exercise["force"]<30 and (switch_timer>switch_timer_th)) or
               ((motor_speed>motor_speed_early_stop_return) and  (percentage<percentage_early_stop_return))
             )
           ):
            state=Status.FORWARD
            switch_timer=0
        elif (state == Status.UNDEFINED and direction==1):
            state=Status.BACKWARD
        elif (state == Status.UNDEFINED and direction==-1):
            state=Status.FORWARD
        elif (none_counter>=2000):
            if state != Status.UNDEFINED:
                print(f"None present")
            state = Status.UNDEFINED
        if (direction==5):
            none_counter += 1
        else:
            none_counter = 0


        if (state == Status.STOP and exercise_type==1):
            repetition_count=1.0
            direction=0.0

        # if power level == zero, use the the level=1 for the first repetitions
        if power_level == 0:
            if repetition_count<4:
                exercise["force"] = force_power_level_0_first_reps
            else:
                exercise["force"] = force_power_level_0_last_reps
        elif initializing or calibrating:
            exercise["force"] = force_power_first_reps
        else:
            exercise["force"] = force_power_last_reps

        stato_macchina=float(state.value)
        if (calibrating):
          stato_macchina=10
        elif (initializing):
          stato_macchina=11

        data_to_be_send=[repetition_count,direction,motor_speed,percentage,vosk_command,stato_macchina,percentage_graph,real_current_value]

        repetition_udp_repetiter.sendData(data_to_be_send+exercise_parameters)
        vosk_command = 0

        if ((last_state != state) or resend):
            resend=False
            if (state == Status.FORWARD and exercise_type == 1):
                motor_target_data=[0,exercise["force"]/100,exercise["velocity"]/100,torque_change_time_fw]
            elif (state == Status.BACKWARD and exercise_type == 1):
                motor_target_data=[0,exercise["force_return"]/100,exercise["velocity"]/100,torque_change_time_bw]
            elif (state == Status.STOP):
                motor_target_data=[1,0,0,1]
            elif (state == Status.UNDEFINED):
                motor_target_data=[1,0,0,1]
            elif (state == Status.REWIRE):
                motor_target_data=[0,0.20,0.2,1]
            motor_target.sendData(motor_target_data)
            print(f"state = {state}, motor = {motor_target_data}")
            last_state = state

    if not isinstance(exercise_client,type):
        exercise_client.stopThread()
        exercise_client.join()

    if not isinstance(startstop_client,int):
        startstop_client.stopThread()
        startstop_client.join()

    if not isinstance(user_client,int):
        user_client.stopThread()
        user_client.join()

    if not isinstance(power_client,int):
        power_client.stopThread()
        power_client.join()



    if not isinstance(repetition_udp,int):
        repetition_udp.stopThread()
        repetition_udp.join()

    if not isinstance(motor_fb_udp,int):
        motor_fb_udp.stopThread()
        motor_fb_udp.join()




if __name__ == '__main__':
    # %% initialization
    signal(SIGINT, handler)

    # %%
    print("starting coordinator thread")
    # ex_thread = Thread(target=exercise_thread, args=())
    # ex_thread.start()
    # while (not stop):
    #     time.sleep(0.1)
    #
    # ex_thread.join()
    exercise_thread()
    print("return clean")
