from signal import signal, SIGINT
from python_udp_helper import UdpReceiverThread, UdpSenderThread
from python_binary_udp_helper import UdpBinarySenderThread, UdpBinaryReceiverThread

import sys
import socket
import time
import logging
from threading import Thread
import Colorer
import abh_constants as abh

if __name__ == '__main__':


    stop=False
    logging.basicConfig(filename='fake_evalutator.log', level=logging.DEBUG, format=' [%(asctime)s,%(filename)s:%(lineno)s - %(funcName)20s()] %(levelname)-8s :: %(message)s')
    logger = logging.getLogger(__name__)
    console = logging.StreamHandler()
    console.setFormatter(logging.Formatter(logging.BASIC_FORMAT))
    console.setLevel(logging.INFO)
    logging.getLogger('').addHandler(console)


    repetition_udp = UdpBinarySenderThread("exercise_name_eval",abh.ABH_VISION,abh.REP_COUNT_PORT)
    try:
        itrial=0
        while (not stop):
            try:
                exercise_client = UdpReceiverThread("exercise_name_eval",abh.ABH_VISION,abh.EXERCISE_NAME_PORT)
                exercise_client.start()
                logging.debug("connected with coordinator")
                break
            except:
                if itrial % 60==0:
                    logging.debug("waiting for connection with coordinator for exercise name.")
                itrial+=1
                time.sleep(1)


        percentage=0
        inc=1
        rep=0
        while True:
           if stop:
               exercise_client.stopThread()
               break
           if (exercise_client.isNewStringAvailable()):
               print("new string: "+exercise_client.getString())
           percentage+=inc
           if (percentage>=100):
               percentage=100
               inc*=-1
               rep+=1
           elif (percentage<=0):
               percentage=0
               inc*=-1
           if rep>21:
               rep=0
           stringa=str(rep)+","+str(percentage)
           repetition_udp.sendData([rep,percentage,inc])
           time.sleep(0.003)

        exercise_client.join()
        repetition_udp.join()
        logging.info("return clean")
        del logger

    except  :
        print("exiting")
        exercise_client.stopThread()

        exercise_client.join()
        logging.info("return clean")

    print("exit")
