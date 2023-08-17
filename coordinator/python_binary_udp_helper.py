import socket
from signal import signal, SIGINT
from sys import exit
from threading import Thread
from threading import Lock
from collections import deque
import time
import sys
import struct

global stop
class UdpBinaryReceiverThread (Thread):
    def __init__(self, name,hostname,port):
        Thread.__init__(self)
        self.name = name
        self.s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.s.bind((hostname, port))
        print("host name "+socket.gethostname(),". port ",port)
        self.s.settimeout(1)
        self.queue = deque()
        self.stop=False
        self.lock = Lock()
        self.buf_len=1

    def __del__(self):
        self.stop=True
        print(self.name+": stop")
        self.s.close()

    def bufferLength(self,buf_len):
        self.buf_len=buf_len

    def isNewDataAvailable(self):
        self.lock.acquire()
        flag=len(self.queue)>0
        self.lock.release()
        return flag

    def stopThread(self):
        self.stop=True
        print("stopping "+self.name)

    def getData(self):
        self.new_value=False;
        data=[]
        self.lock.acquire()
        if len(self.queue)>0:
            data=self.queue.popleft()
        self.lock.release()
        return data

    def getLastDataAndClearQueue(self):
        self.new_value=False;
        data=[]
        self.lock.acquire()
        if len(self.queue)>0:
            data=self.queue.pop()
            self.queue.clear()
        self.lock.release()
        return data

    def run(self):
        print("init")

        while True:
            if self.stop:
                break
            try:
                msg = self.s.recv(self.buf_len*8) # buffer size is 1024 bytes
                full_msg = list(struct.unpack(f'{self.buf_len}d',msg))
                if len(full_msg) > 0:
                    self.new_value=True;
                    self.lock.acquire()
                    self.queue.append(full_msg)
                    self.lock.release()
            except:
                continue

        print("exit ",self.name)
        self.s.close()

class UdpBinarySenderThread (Thread):
    def __init__(self, name,hostname,port):
        Thread.__init__(self)
        self.s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.port=port
        self.hostname=hostname
        self.stop=False
        self.name = name

    def __del__(self):
        print(self.name+": stop")
        self.stop=True
        self.s.close()

    def sendData(self,data):
        if self.s.sendto(struct.pack(f'{len(data)}d', *data),(self.hostname,self.port)) < 0:
            print("error sending message")
