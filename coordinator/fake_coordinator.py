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
    send_data=False
    while (not stop):
        time.sleep(0.001)
        idx=idx+1
        if (startstop_client.isNewStringAvailable()):
            stringa=startstop_client.getLastStringAndClearQueue()
            print(stringa)
            if stringa[0:5]=="start":
                repetition_count=1
                idx=0
                send_data=True
                direction=1
                state=Status.FORWARD
            elif stringa=="stop":
                state=Status.STOP
                send_data=False
                repetition_count=1
                direction=0
                state=Status.STOP

        if send_data:
            if idx==500:
                idx=0
                repetition_count=repetition_count+1

        motor_speed=motor_speed+0.01
        if (motor_speed>100.0):
            motor_speed=0.0
        percentage=motor_speed

        repetition_udp_repetiter.sendData([repetition_count,direction,motor_speed,percentage,vosk_command,float(state.value)])

    if not isinstance(startstop_client,int):
        startstop_client.stopThread()
        startstop_client.join()
    else:
        logging.debug("startstop_client is off")

if __name__ == '__main__':
    # %% initialization
    signal(SIGINT, handler)
    # %%
    ex_thread = Thread(target=exercise_thread, args=())
    ex_thread.start()
    while (not stop):
        time.sleep(0.1)

    ex_thread.join()
    logging.info("return clean")
