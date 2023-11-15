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

import psutil

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


    startstop_client = UdpReceiverThread("startstop_client_d",abh.ABH_CONTROL,abh.START_EXERCISE_PORT)
    startstop_client.start()
    repetition_udp_repetiter = UdpBinarySenderThread("repetition_udp_repetiter",abh.ABH_VISION,abh.REP_COUNT_PORT_DM)

    state=Status.STOP
    repetition_count=1
    direction=1
    motor_speed=0
    percentage=0
    vosk_command=0

    idx=0
    send_data=True
    while (not stop):
        time.sleep(0.001)
        idx=idx+1
        if (startstop_client.isNewStringAvailable()):
            stringa=startstop_client.getLastStringAndClearQueue()
            print(stringa)
            if stringa=="start" or stringa=="restart_vision":

                repetition_count=1
                idx=0
                send_data=True
                direction=1
                state=Status.FORWARD
            elif stringa=="stop" or stringa=="rewire":
                state=Status.STOP
                send_data=True
                repetition_count=1
                direction=0
                state=Status.STOP
            print(f"Next state {state}")
        if send_data:
            if idx==1000:
                idx=0
                if state==Status.FORWARD:
                    repetition_count=repetition_count+1
                    print(repetition_count)


        stato_macchina=float(state.value)
        stato_macchina=11
        if repetition_count==1:
            stato_macchina=11
        if repetition_count<=4:
            stato_macchina=10
        if (repetition_count>10 and repetition_count<20):
            stato_macchina=2


        motor_speed=motor_speed+0.03
        if (motor_speed>100.0):
            motor_speed=0.0
        percentage=motor_speed

        print(f"rep: {repetition_count}, stato: {stato_macchina}")
        motor_speed = 0.0
        repetition_udp_repetiter.sendData([repetition_count,direction,motor_speed,percentage,vosk_command,stato_macchina,percentage,percentage])

    if not isinstance(startstop_client,int):
        startstop_client.stopThread()
        startstop_client.join()
    else:
        logging.debug("startstop_client is off")

if __name__ == '__main__':
    # %% initialization
    signal(SIGINT, handler)
    # %%

    pids = psutil.pids()
    found_abh_gui=False
    for pid in pids:
        p=psutil.Process(pid)
        if p.name() == "abh_gui_v3":
            print(p)
            if (not found_abh_gui):
                found_abh_gui=True
                abh_gui_time=p.create_time()
                p_abh=p
            else:
                print("duplicate abh_gui_v3",p,p_abh)
                p_abh.terminate()
                p_abh.kill()
                p.kill()



    ex_thread = Thread(target=exercise_thread, args=())
    ex_thread.start()
    while (not stop):
        time.sleep(0.1)

    ex_thread.join()
    logging.info("return clean")
