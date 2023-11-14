import nmcli
import csv
import os
import getpass
import time


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
else:
    filename='/home/jacobi/projects/abh/utenti/wifi_list.csv'

while (not stop):
    connessioni_wifi=nmcli.device.wifi()

    connessioni=[]
    for c in connessioni_wifi:
        nota = c.ssid in connessioni_note_ssid
        if not c.ssid:
            continue
        conn={'is_use': c.in_use, 'knonw': nota, 'ssid': c.ssid}


        if not any(d['ssid'] == c.ssid for d in connessioni):
            connessioni.append(conn)

        for d in connessioni:
            if (d['ssid'] == c.ssid):
                d['is_use'] = d['is_use'] or c.in_use

    connessioni = sorted(connessioni, key=lambda x: x['is_use'])
    # connessioni.reverse()
    keys = connessioni[0].keys()
    with open(filename, 'w', newline='') as output_file:
        dict_writer = csv.DictWriter(output_file, keys)
        dict_writer.writeheader()
        dict_writer.writerows(connessioni)
    time.sleep(5)
