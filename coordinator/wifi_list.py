import nmcli
import csv
import os
import getpass
import time
import subprocess
import getpass
import traceback

stop=False
def handler(signal_received, frame):
    global stop
    stop=True

nmcli.disable_use_sudo()

connessioni_note=nmcli.connection()
connessioni_note_ssid=[]
for c in connessioni_note:
    connessioni_note_ssid.append(c.name)

path=os.path.dirname(os.path.realpath(__file__))
user=getpass.getuser()



if (user!='jacobi'):
    filename='/home/'+user+'/Scrivania/abh/utenti/wifi_list.csv'
    device_list='/home/'+user+'/Scrivania/abh/utenti/device_names.csv'
else:
    filename='/home/jacobi/projects/abh/utenti/wifi_list.csv'
    device_list = '/home/jacobi/projects/abh/utenti/device_names.csv'

device_file=open(device_list,mode='r')
devices=csv.DictReader(device_file,delimiter=',')
scheda = ""
scheda_shelly = ""
wifi_shelly = ""
pwd_shelly =  ""
for r in devices:
    print(r)
    if r["nome"] == 'scheda wifi':
        scheda = r["valore"]
    if r["nome"] == 'scheda wifi shelly':
        scheda_shelly = r["valore"]
    if r["nome"] == 'nome wifi shelly':
        wifi_shelly = r["valore"]
    if r["nome"] == 'password wifi shelly':
        pwd_shelly = r["valore"]
print(f"scheda: {scheda}")
print(f"scheda shelly: {scheda_shelly}")


while (not stop):
    try:

        wrong_connection = False
        stato = nmcli.device.show(scheda)
        attivo = "connected" in stato['GENERAL.STATE']
        connessioni_wifi=nmcli.device.wifi(scheda)
        connessioni_note = nmcli.connection()

        connessioni_note_ssid = []
        for c in connessioni_note:
            connessioni_note_ssid.append(c.name)

        connessioni=[]
        for c in connessioni_wifi:
            nota = c.ssid in connessioni_note_ssid
            if not c.ssid:
                continue
            if ("Shelly" in c.ssid) or ("shelly" in c.ssid):
                if c.in_use:
                    print("shelly is in use in the wrong board")
                    wrong_connection = True
                continue
            conn={'is_use': c.in_use and attivo, 'known': False, 'ssid': c.ssid, 'pwd': ''}



            if not any(d['ssid'] == c.ssid for d in connessioni):
                password=subprocess.getoutput("nmcli -s -g 802-11-wireless-security.psk connection show " + c.ssid)

                if password:
                    if (not "Error:" in password) and (not "Errore:" in password):
                        conn['known']=True
                        conn['pwd']=password
                        #print(f"pwd = {conn}")
                    else:
                        conn['known'] = False
                connessioni.append(conn)

            for d in connessioni:
                if (d['ssid'] == c.ssid):
                    d['is_use'] = (d['is_use'] or c.in_use) and attivo

        connessioni = sorted(connessioni, key=lambda x: x['known'])
        connessioni = sorted(connessioni, key=lambda x: x['is_use'])
        # connessioni.reverse()


        if wrong_connection and len(connessioni)>0:
            for tmp in connessioni:
                print(tmp)
                if (tmp['known']):
                    print(f"first connection:\n{tmp}")
                    nmcli.device.wifi_connect(ssid=tmp['ssid'], ifname=scheda, password=tmp['pwd'])
                    break
        keys = ['is_use', 'known', 'ssid','pwd']
        with open(filename, 'w', newline='') as output_file:
            dict_writer = csv.DictWriter(output_file, keys)
            dict_writer.writeheader()
            dict_writer.writerows(connessioni)

        stato_shelly = nmcli.device.show(scheda_shelly)
        connessioni_wifi_shelly = nmcli.device.wifi(scheda_shelly)
        connesso_a_shelly = False
        for c in connessioni_wifi_shelly:
            if c.in_use and c.ssid == wifi_shelly:
                connesso_a_shelly = True
        if not connesso_a_shelly:
            try:
                nmcli.device.wifi_connect(ssid=wifi_shelly, ifname=scheda_shelly, password=pwd_shelly)
            except:
                print(f"unable to connect {wifi_shelly} to shelly wifi {wifi_shelly} with pwd {pwd_shelly}")
    except Exception as e:
        traceback.print_exc()
        print(f"unable to connect to network: {e}")

    time.sleep(5)
