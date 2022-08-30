from signal import signal, SIGINT
from python_udp_helper import UdpSenderThread, UdpReceiverThread
from python_binary_udp_helper import UdpBinarySenderThread, UdpBinaryReceiverThread
import sys
import socket
import time
import logging
from threading import Thread
import Colorer
import abh_constants as abh

stop = False


def handler(signal_received, frame):
    global stop
    stop = True

    logging.debug("return clean")



if __name__ == '__main__':
    signal(SIGINT, handler)
    logging.basicConfig(filename='fake_gui.log', level=logging.DEBUG, format=' [%(asctime)s,%(filename)s:%(lineno)s - %(funcName)20s()] %(levelname)-8s :: %(message)s', filemode='w')
    logger = logging.getLogger(__name__)
    console = logging.StreamHandler()
    console.setFormatter(logging.Formatter(logging.BASIC_FORMAT))
    console.setLevel(logging.INFO)
    logging.getLogger('').addHandler(console)



    exercise_server = UdpSenderThread("exercise_name_d",abh.ABH_CONTROL,abh.EXERCISE_NAME_DM_PORT)
    startstop_server = UdpSenderThread("start_exercise_port_d",abh.ABH_CONTROL,abh.START_EXERCISE_PORT)
    logging.info("connected")
    while (not stop):
        exercise_server.sendString("biceps_curl;1;Facile")
        for idx in range(0,5):
            time.sleep(1)
        startstop_server.sendString("start")
        for idx in range(0,5):
            time.sleep(1)
        startstop_server.sendString("stop")
        for idx in range(0,5):
            time.sleep(1)
    logging.info("stopping threads")



    logging.info("return clean")
    del logger
