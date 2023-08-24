import subprocess
import signal
import os
import time
import getpass

import psutil

path=os.path.dirname(os.path.realpath(__file__))
os.system("pkill abh_gui_v3")


pids = psutil.pids()
found_abh_gui=False
for pid in pids:
    p=psutil.Process(pid)
    print(p.cmdline())
    if ("ABHORIZON_PC_VISION" in p.cmdline()) or ("abh_gui_v3" in p.cmdline()):
        if "launcher_v3" in p.cmdline():
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
    if (user!='jacobi'):
        p.append(subprocess.Popen([pycmd, "/home/"+user+"/ABHORIZON_PC_VISION/AB_main_PC.py"], cwd=r'/home/'+user+'/ABHORIZON_PC_VISION'))
        p[-1].name="vision"
        time.sleep(0.5)

    p.append(subprocess.Popen([pycmd,path+"/coordinator.py"], cwd=path))
    p[-1].name="coordinator"
    p.append(subprocess.Popen([pycmd,path+"/led_control.py"], cwd=path))
    p[-1].name="led"
    p.append(subprocess.Popen([path+"/../build/abh_gui_v3"], cwd=path, stdout=subprocess.DEVNULL    ))
    p[-1].name="gui"
    p.append(subprocess.Popen([pycmd,path+"/../vosk/microphone.py"], cwd=path+"/../vosk", stdout=subprocess.DEVNULL    ))
    p[-1].name="vosk"

    if (user=='jacobi'):
        p.append(subprocess.Popen([pycmd,path+"/fake_evaluator.py"], cwd=path))
        p[-1].name="fake_evaluator"
        p.append(subprocess.Popen([pycmd, path+"/sender.py"], cwd=path))
        p[-1].name="sender"
    else:
        p.append(subprocess.Popen([pycmd,path+"/motor_control.py"], cwd=path))
        p[-1].name="motor_control"

    is_died=False
    while True:
        for proc in p:
            if not(proc.poll() is None):
                print("process ",proc.name, " is died")
                is_died=True
                for proc2 in p:
                    proc2.send_signal(signal.SIGINT)
                    print("process ",proc2.name, " is killed")
                break
        if (is_died):
            break
        time.sleep(1)
except KeyboardInterrupt:
    for proc in p:
        proc.send_signal(signal.SIGINT)
os.system("pkill abh_gui_v3")
os.system("pkill python")
