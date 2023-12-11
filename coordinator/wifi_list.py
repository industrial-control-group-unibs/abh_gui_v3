import nmcli
import csv
import os
import getpass
import time
import subprocess
import getpass

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
    stato = nmcli.device.show(scheda)
    attivo = "connected" in stato['GENERAL.STATE']
    connessioni_wifi=nmcli.device.wifi(scheda)
    connessioni_note = nmcli.connection()

    connessioni=[]
    for c in connessioni_wifi:
        nota = c.ssid in connessioni_note_ssid
        if not c.ssid:
            continue
        if "Shelly" in c.ssid:
            continue
        if "shelly" in c.ssid:
            continue
        conn={'is_use': c.in_use and attivo, 'known': False, 'ssid': c.ssid}



        if not any(d['ssid'] == c.ssid for d in connessioni):
            password=subprocess.getoutput("nmcli -s -g 802-11-wireless-security.psk connection show " + c.ssid)
            if password:
                if not "Error:" in password:
                    conn['known']=True
            connessioni.append(conn)

        for d in connessioni:
            if (d['ssid'] == c.ssid):
                d['is_use'] = (d['is_use'] or c.in_use) and attivo

    connessioni = sorted(connessioni, key=lambda x: x['known'])
    connessioni = sorted(connessioni, key=lambda x: x['is_use'])
    # connessioni.reverse()
    keys = ['is_use', 'known', 'ssid']
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
        nmcli.device.wifi_connect(ssid=wifi_shelly, ifname=scheda_shelly, password=pwd_shelly)

    time.sleep(5)
