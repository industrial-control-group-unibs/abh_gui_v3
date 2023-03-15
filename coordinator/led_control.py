import urllib.request
import urllib.parse
import urllib.request
import time

from pyShelly import pyShelly
from urllib3 import request



def device_added(dev,code):
  print (dev," ",code)

shelly = pyShelly()
print("version:",shelly.version())

shelly.cb_device_added.append(device_added)
shelly.start()
shelly.discover()

try:
    waiting=True
    while waiting:
        time.sleep(1)
        print("waiting")
        for dev in shelly.devices:
            print(dev.device_type)
            if (dev.device_type=="RGBLIGHT"):
                led=dev
                waiting=False
                break


    if not led.turn_off():
        led.turn_off()

    time.sleep(1)
    led.turn_on()

    colore=[255,0,0]
    colore2=[255,0,0]
    inc=+20
    power=0
    power=1
    power_inc=0.05
    while True:
        colore[0]-=inc
        colore[2]+=inc
        if (colore[0]<0 or colore[2]>255):
            rgb=[0,0,255]
            inc*=-1
        elif (colore[2]<0 or colore[0]>255):
            colore=[255,0,0]
            inc*=-1
        power+=power_inc
        if (power>1):
            power=1.0
            power_inc*=-1
        elif (power<0):
            power=.0
            power_inc*=-1

        colore2[0]=int(colore[0]*power)
        colore2[1]=int(colore[1]*power)
        colore2[2]=int(colore[2]*power)
        led.set_values(rgb=colore2)
        time.sleep(0.1)
except KeyboardInterrupt:
    pass

