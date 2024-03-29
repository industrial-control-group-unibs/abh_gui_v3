import urllib.request
import urllib.parse
import urllib.request
import time
from python_binary_udp_helper import UdpBinarySenderThread, UdpBinaryReceiverThread

from pyShelly import pyShelly
from urllib3 import request
from signal import signal, SIGINT

from threading import Thread

import abh_constants as abh

stop=False
def handler(signal_received, frame):
    global stop
    stop=True



find_led = False
find_uv = False
led=[]
uv_light=[]

def device_added(dev,code):
    global find_uv
    global find_led
    global led
    global uv_light
    print (dev," ",code)
    print(dev.device_type)
    if dev.device_type == "RGBLIGHT":
        led=dev
        find_led = True
        print(f"Find led")
    if dev.device_type == "RELAY":
        uv_light=dev
        find_led = True
        print(f"Find uv light")


def led_thread():

    global stop
    global find_uv
    global find_led
    global led
    global uv_light
    shelly = pyShelly()
    print("version:",shelly.version())

    led_client = UdpBinaryReceiverThread("led_client_d",abh.ABH_CONTROL,abh.LED_PORT)
    led_client.bufferLength(3)
    led_client.start()

    uv_client = UdpBinaryReceiverThread("led_client_d", abh.ABH_CONTROL, abh.UV_PORT)
    uv_client.bufferLength(1)
    uv_client.start()

    shelly.cb_device_added.append(device_added)
    shelly.host_ip='192.168.33.2'
    shelly.bind_ip='192.168.33.2'
    shelly.start()
    shelly.discover()
    shelly.add_device_by_ip('192.168.33.1','IP-addr')

    uv = 0

    waiting=True



    while waiting:
        time.sleep(2)
        if led_client.isNewDataAvailable():
            led_color=led_client.getLastDataAndClearQueue()
            print("color = ", led_color)
        if (uv_client.isNewDataAvailable()):
            uv=uv_client.getLastDataAndClearQueue()
            print(f"uv command {uv}")
        print("waiting")
        if (stop):
            led_client.stopThread()
            led_client.join()
            return
        if find_led:
            waiting = False
            break
        # for dev in shelly.devices:
        #     print(dev.device_type)
        #     if dev.device_type == "RGBLIGHT":
        #         led=dev
        #         find_led = True
        #     if dev.device_type == "RELAY":
        #         uv_light=dev
        #         find_led = True
        # if find_uv and find_led:
        #     break

    print(f"Start control of the LED")
    if not led.turn_off():
        led.turn_off()
    time.sleep(0.5)
    led.turn_on()


    colore=[255,0,0]
    led_color=[1,0,0]
    while (not stop):
        time.sleep(0.1)

        if (led_client.isNewDataAvailable()):
            led_color=led_client.getLastDataAndClearQueue()
            print(f"colore {led_color}")
        if (uv_client.isNewDataAvailable()):
            uv=uv_client.getLastDataAndClearQueue()
            print(f"uv command {uv}")

        colore[0]=led_color[0]*255.0
        colore[1]=led_color[1]*255.0
        colore[2]=led_color[2]*255.0
        led.set_values(rgb=colore)

        if find_uv:
            if (uv>0):
                uv_light.turn_on()
            else:
                uv_light.turn_off()
        if (stop):
            led_client.stopThread()
            led_client.join()
            return


if __name__ == '__main__':
    #global stop
    ex_thread = Thread(target=led_thread, args=())
    signal(SIGINT, handler)
    ex_thread.start()
    while (not stop):
        time.sleep(0.1)

    if ex_thread.is_alive():
        ex_thread.join(timeout=10)
