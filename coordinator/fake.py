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

if __name__ == '__main__':


    stop=False

    repetition_udp_repetiter = UdpBinarySenderThread("repetition_udp_repeater",abh.ABH_VISION,abh.REP_COUNT_PORT_DM)
    motor_feedback = UdpBinarySenderThread("motor_feedback",abh.ABH_CONTROL,abh.MOTOR_FEEDBACK_PORT)

    try:
        iter=0


        direction=1.0
        repetition_count=0.0
        abs_position= 0.0
        fb_velocity= 0.0

        while True:
            repetition_udp_repetiter.sendData([repetition_count,direction,fb_velocity])
            motor_feedback.sendData([abs_position,fb_velocity,fb_velocity])
            time.sleep(0.001)
            iter+=1
            if direction>0:
                fb_velocity+=.05
                if fb_velocity>100:
                    fb_velocity=100
                    direction=-1
            if direction<0:
                fb_velocity-=.05
                if fb_velocity<-100:
                    fb_velocity=-100
                    direction=1

            if iter>100:
                repetition_count+=1
                if repetition_count>10:
                    repetition_count=0
                iter=0
                print("rep =",repetition_count)


        # repetition_udp.join()

    except  :
        # repetition_udp.join()
        print("exiting")

    print("exit")
