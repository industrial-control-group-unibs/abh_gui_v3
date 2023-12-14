from __future__ import division

from pyzbar.pyzbar import decode
from PIL import Image
import os
import getpass
from python_udp_helper import UdpSenderThread, UdpReceiverThread
from udp_video_receiver import ReceiverThread
import cv2
import numpy as np
import socket
import struct
import math
import time

# #pip3 install pyzbar
# #pip3 install pillow
#
# user=getpass.getuser()
# if user=='jacobi':
#     pycmd="python3"
# else:
#     pycmd="python"
# if (user!='jacobi'):
#     user_path='/home/' + user + '/Scrivania/abh/utenti/'
# else:
#     user_path='/home/' + user + '/projects/abh/utenti/'
#
#
# decocdeQR = decode(Image.open('some_file.png'))
# decocdeQR = decode(Image.open('foto.png'))
# print(decocdeQR[0].data.decode('ascii'))
#

rec = ReceiverThread("rec","localhost",5000)
rec.start()

#cv2.namedWindow("video", cv2.WINDOW_AUTOSIZE)
while True:
    if rec.isNewDataAvailable():
        print("qui")
        cv2.imshow("video", rec.getData())
        cv2.waitKey(1)
    else:
        print("qua")
    time.sleep(0.01)

rec.stopThread()

