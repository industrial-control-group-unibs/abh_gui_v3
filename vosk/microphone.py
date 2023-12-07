#!/usr/bin/env python3

import sys
sys.path.append('../coordinator')

import argparse
import os
import queue
import sounddevice as sd
import vosk
import sys
from difflib import SequenceMatcher
import json
import csv
from python_binary_udp_helper import UdpBinarySenderThread, UdpBinaryReceiverThread
from python_udp_helper import UdpReceiverThread
import getpass

import abh_constants as abh


q = queue.Queue()

def int_or_str(text):
    """Helper function for argument parsing."""
    try:
        return int(text)
    except ValueError:
        return text

def callback(indata, frames, time, status):
    """This is called (from a separate thread) for each audio block."""
    if status:
        print(status, file=sys.stderr)
    q.put(bytes(indata))

parser = argparse.ArgumentParser(add_help=False)
parser.add_argument(
    '-l', '--list-devices', action='store_true',
    help='show list of audio devices and exit')
args, remaining = parser.parse_known_args()
if args.list_devices:
    print(sd.query_devices())
    parser.exit(0)
parser = argparse.ArgumentParser(
    description=__doc__,
    formatter_class=argparse.RawDescriptionHelpFormatter,
    parents=[parser])
parser.add_argument(
    '-f', '--filename', type=str, metavar='FILENAME',
    help='audio file to store recording to')
parser.add_argument(
    '-m', '--model', type=str, metavar='MODEL_PATH',
    help='Path to the model')
parser.add_argument(
    '-d', '--device', type=int_or_str,
    help='input device (numeric ID or substring)')
parser.add_argument(
    '-r', '--samplerate', type=int, help='sampling rate')
args = parser.parse_args(remaining)

user=getpass.getuser()
if (user != 'jacobi'):
    path = '/home/' + user + '/Scrivania/abh/abh_data/traduzioni/comandi_vocali/'
else:
    path = '/home/jacobi/projects/abh/abh_data/traduzioni/comandi_vocali/'
dict_frasi={}
lingua= "abh_fr"

comando_vocale = UdpBinarySenderThread("exercise_name_eval",abh.ABH_VISION,abh.COMANDI_VOCALI_PORT)

lingua_client = UdpReceiverThread("lingua", abh.ABH_CONTROL, abh.LANGUAGE_PORT)
lingua_client.start()



try:
    while True:
        with open(path + '/' + lingua + '.csv') as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            line_count = 0

            for row in csv_reader:
                print(row)
                if line_count == 0:
                    line_count += 1
                else:
                    line_count += 1
                    dict_frasi[row[0]] = row[1]
            print(f'Processed {line_count} lines.')

        if not os.path.exists(path+'/'+lingua):
            print ("Please download a model for your language from https://alphacephei.com/vosk/models")
            print ("and unpack as 'model' in the current folder.")
            parser.exit(0)
        if args.samplerate is None:
            device_info = sd.query_devices(args.device, 'input')
            # soundfile expects an int, sounddevice provides a float:
            args.samplerate = int(device_info['default_samplerate'])

        model = vosk.Model(path+'/'+lingua)


        with sd.RawInputStream(samplerate=args.samplerate, blocksize = 8000, device=args.device, dtype='int16',
                                channels=1, callback=callback):
                print('#' * 80)
                print('Press Ctrl+C to stop the recording')
                print('#' * 80)

                rec = vosk.KaldiRecognizer(model, args.samplerate)
                while True:

                    if (lingua_client.isNewStringAvailable()):
                        lingua = lingua_client.getLastStringAndClearQueue()
                        print(f"Selezionata lingua: {lingua}")
                        break
                    data = q.get()
                    if rec.AcceptWaveform(data):
                        frase = json.loads(rec.Result())["text"]
                        if len(frase)==0:
                            comando_vocale.sendData([0])
                            continue
                        for key, value  in dict_frasi.items():
                            match=SequenceMatcher(None, frase, key).ratio()
                            print(key, " match =",match)
                            if match>0.8:
                                print('send(',[float(value)],')')
                                comando_vocale.sendData([float(value)])

except KeyboardInterrupt:
    print('\nDone')
    parser.exit(0)
except Exception as e:
    parser.exit(type(e).__name__ + ': ' + str(e))
