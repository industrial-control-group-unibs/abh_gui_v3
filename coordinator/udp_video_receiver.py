import socket
from signal import signal, SIGINT
from sys import exit
from threading import Thread
from threading import Lock
from collections import deque
import time
import sys
import struct
import numpy as np
import cv2
from io import BytesIO

global stop
class ReceiverThread (Thread):
    def __init__(self, name,hostname,port):
        Thread.__init__(self)
        self.name = name
        self.s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.s.bind((hostname, port))
        print("host name "+socket.gethostname(),". port ",port)
        self.s.settimeout(1)
        self.new_data = False
        self.stop=False
        self.lock = Lock()
        self.buf_len=65536
        self.image = np.zeros((1,1,3), np.uint8)
    def __del__(self):
        self.stop=True
        print(self.name+": stop")
        self.s.close()

    def bufferLength(self,buf_len):
        self.buf_len=buf_len

    def isNewDataAvailable(self):
        return self.new_data

    def stopThread(self):
        self.stop=True
        print("stopping "+self.name)

    def getData(self):
        self.lock.acquire()
        im=self.image
        self.new_data = False
        self.lock.release()
        return im

    def run(self):
        print("init")

        frame=bytearray([])
        while True:
            if self.stop:
                break
            try:
                msg = bytearray(self.s.recv(self.buf_len))
                frame.extend(msg[1:])
                if (msg[0]==1):
                    nparr = np.frombuffer(frame, dtype=np.int8)
                    self.lock.acquire()
                    self.image = cv2.imdecode(nparr,  cv2.IMREAD_COLOR)
                    self.new_data = True
                    self.lock.release()
                    frame = bytearray([])

            except:
               continue

        print("exit ",self.name)
        self.s.close()

