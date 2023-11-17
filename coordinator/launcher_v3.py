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
    logpath = all_logs+datestr+'/'


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


    if (user!='jacobi'):
        file_visione = open(logpath + 'visione.txt', 'w')
        p.append(subprocess.Popen([pycmd, "/home/"+user+"/ABHORIZON_PC_VISION/AB_main_PC.py"], cwd=r'/home/'+user+'/ABHORIZON_PC_VISION', stdout=file_visione, stderr=file_visione))
        p[-1].name="vision"
        time.sleep(0.5)

        file_coordinator = open(logpath + 'coordinator.txt', 'w')
        p.append(subprocess.Popen([pycmd,path+"/coordinator.py"], cwd=path, stdout=file_coordinator, stderr=file_coordinator))
        p[-1].name="coordinator"

    file_led_control = open(logpath + 'led_control.txt', 'w')
    p.append(subprocess.Popen([pycmd,path+"/led_control.py"], cwd=path, stdout=file_led_control, stderr=file_led_control))
    p[-1].name="led"

    file_abh_gui_v3 = open(logpath + 'abh_gui_v3.txt', 'w')
    p.append(subprocess.Popen([path+"/../build/abh_gui_v3"], cwd=path, stdout=file_abh_gui_v3, stderr=file_abh_gui_v3))
    p[-1].name="gui"

    file_microphone = open(logpath + 'microphone.txt', 'w')
    p.append(subprocess.Popen([pycmd,path+"/../vosk/microphone.py"], cwd=path+"/../vosk", stdout=file_microphone))
    p[-1].name="vosk"


    file_microphone = open(logpath + 'wifi_list.txt', 'w')
    p.append(subprocess.Popen([pycmd,path+"/wifi_list.py"], cwd=path+"/../vosk", stdout=file_microphone))
    p[-1].name="wifi_list"

    if (user=='jacobi'):
        file_coordinator = open(logpath + 'coordinator.txt', 'w')
        p.append(subprocess.Popen([pycmd,path+"/fake_coordinator.py"], cwd=path, stdout=file_coordinator))
        p[-1].name="coordinator"
        p.append(subprocess.Popen([pycmd, path+"/sender.py"], cwd=path))
        p[-1].name="sender"
    else:
        file_motor_control = open(logpath + 'motor_control.txt', 'w')
        p.append(subprocess.Popen([pycmd,path+"/motor_control.py"], cwd=path, stdout=file_motor_control))
        p[-1].name="motor_control"

    is_died=False
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
                elif (proc.name == "vision" and proc.returncode < 0):
                    proc = subprocess.Popen([pycmd, "/home/"+user+"/ABHORIZON_PC_VISION/AB_main_PC.py"], cwd=r'/home/'+user+'/ABHORIZON_PC_VISION', stdout=file_visione, stderr=file_visione)
                    p[idx] = proc
                    p[idx].name = "vision"

                else:
                    is_died=True
                    for proc2 in p:
                        proc2.send_signal(signal.SIGINT)
                        print("process ",proc2.name, " is killed")
                    break
        if (is_died):
            break
        time.sleep(.1)
except KeyboardInterrupt:
    for proc in p:
        proc.send_signal(signal.SIGINT)
os.system("pkill -9 abh_gui_v3")
os.system("pkill -9 python")
