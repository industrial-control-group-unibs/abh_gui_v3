import urllib.request
import urllib.parse
import urllib.request

from pyShelly import pyShelly
from urllib3 import request

def device_added(dev,code):
  print (dev," ",code)

shelly = pyShelly()
print("version:",shelly.version())

shelly.cb_device_added.append(device_added)
shelly.start()
shelly.discover()

while True:
    pass 
