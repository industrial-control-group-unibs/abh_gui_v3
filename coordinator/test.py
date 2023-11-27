import subprocess
import signal
import os
import time
import getpass

import psutil
import datetime
import shutil
import copy

path=os.path.dirname(os.path.realpath(__file__))
os.system("pkill -9 abh_gui_v3")


pids = psutil.pids()
found_abh_gui=False
for pid in pids:
    try:
        p=psutil.Process(pid)
        if (any('ABHORIZON_PC_VISION' in s for s in p.cmdline())
                or any('abh_gui_v3' in s for s in p.cmdline())
                or any('wifi_list' in s for s in p.cmdline())
                or any('coordinator' in s for s in p.cmdline())
                or any('led_control' in s for s in p.cmdline())
                or any('motor_control' in s for s in p.cmdline())):
            if any('launcher_v3' in s for s in p.cmdline()):
                print("questo è il main!")
                continue
            print(f"killing {p.cmdline()}")
            p.kill()
    except:
        print("unable to manager process")


user=getpass.getuser()
if user=='jacobi':
    pycmd="python3"
else:
    pycmd="python"
try:
    p=[]

    now = datetime.datetime.now()
    datestr=now.strftime('%Y%m%d_%H%M%S')


    if (user!='jacobi'):
        all_logs='/home/' + user + '/Scrivania/abh/utenti/logs/'
    else:
        all_logs='/home/' + user + '/projects/abh/utenti/logs/'
    logpath = all_logs#+datestr+'/'


    if not os.path.isdir(logpath):
        os.makedirs(logpath)

    subfolders = [f.path for f in os.scandir(all_logs) if f.is_dir()]
    for subf in subfolders:
        x=subf.replace(all_logs, '')
        try:
            date_log = datetime.datetime.strptime(x, '%Y%m%d_%H%M%S')
            diff_data=(now-date_log).total_seconds()
            if (diff_data>604800):
                shutil.rmtree(subf)
        except:
            shutil.rmtree(subf)

    file_launcher = open(logpath + 'launcher.txt', 'w')
    file_launcher.write("Start launcher\n")
    file_launcher.flush()

    file_coordinator1 = open(logpath + 'coordinator.txt', 'w')
    file_coordinator2 = open(logpath + 'coordinator2.txt', 'w')

    p.append(subprocess.Popen([pycmd,"-u",path+"/coordinator.py"], cwd=path, stdout=file_coordinator1, stderr=file_coordinator2))
    #p.append(subprocess.Popen([pycmd,path+"/coordinator.py"], cwd=path))
    p[-1].name="coordinator"
    p[-1].logfile=file_coordinator1

    is_died=False

    idxt=0
    while True:
        for idx,proc in enumerate(p):
            if not(proc.poll() is None):
                print(f"process {proc.name} is died: {proc.returncode}")
                if (proc.name == "gui" and proc.returncode<0):

                    os.system("xset -display :0.0 dpms force off")

                    proc = subprocess.Popen([path+"/../build/abh_gui_v3"], cwd=path, stdout=file_abh_gui_v3, stderr=file_abh_gui_v3)
                    p[idx]=proc
                    p[idx].name="gui"
                    time.sleep(2)
                    os.system("xset -display :0.0 dpms force on")
                    file_launcher.write(f"restart {p[idx].name}\n")
                    file_launcher.flush()
                elif (proc.name == "led" and proc.returncode < 0):
                    proc = subprocess.Popen([pycmd,path+"/led_control.py"], cwd=path, stdout=file_led_control, stderr=file_led_control)
                    p[idx] = proc
                    p[idx].name = "led"
                    file_launcher.write(f"restart {p[idx].name}\n")
                    file_launcher.flush()
                elif (proc.name == "coordinator" and proc.returncode < 0):
                    proc =subprocess.Popen([pycmd,path+"/coordinator.py"], cwd=path, stdout=file_coordinator, stderr=file_coordinator)
                    p[idx] = proc
                    p[idx].name = "coordinator"
                    file_launcher.write(f"restart {p[idx].name}\n")
                    file_launcher.flush()
                elif (proc.name == "vosk" and proc.returncode < 0):
                    proc = subprocess.Popen([pycmd,path+"/../vosk/microphone.py"], cwd=path+"/../vosk", stdout=file_microphone, stderr=file_microphone)
                    p[idx] = proc
                    p[idx].name = "vosk"
                    file_launcher.write(f"restart {p[idx].name}\n")
                    file_launcher.flush()
                elif (proc.name == "wifi_list" and proc.returncode < 0):
                    proc = subprocess.Popen([pycmd,path+"/wifi_list.py"], cwd=path+"/../vosk", stdout=file_wifi, stderr=file_wifi)
                    p[idx] = proc
                    p[idx].name = "wifi_list"
                    file_launcher.write(f"restart {p[idx].name}\n")
                    file_launcher.flush()
                elif (proc.name == "motor_control" and proc.returncode < 0):
                    proc =subprocess.Popen([pycmd,path+"/motor_control.py"], cwd=path, stdout=file_motor_control, stderr=file_motor_control)
                    p[idx] = proc
                    p[idx].name = "motor_control"
                    file_launcher.write(f"restart {p[idx].name}\n")
                    file_launcher.flush()
                else:
                    is_died=True
                    file_launcher.write(f"process is died: {p[idx].name}")
                    file_launcher.flush()
            else:
                p[-1].logfile.flush()

        if (is_died):
            break
        time.sleep(.01)
        idxt+=1

        if (idxt>100):
            print("break")
            break

    for proc in p:
        proc.send_signal(signal.SIGINT)

except KeyboardInterrupt:
    for proc in p:
        proc.send_signal(signal.SIGINT)
os.system("pkill -9 abh_gui_v3")
os.system("pkill -9 python")
