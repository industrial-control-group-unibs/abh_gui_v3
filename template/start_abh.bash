#!/usr/bin/env bash
date > /tmp/ora2

# aspetta prima di partire
ritardo_alla_partenza=25
for i in $(seq $ritardo_alla_partenza); do
    command
    xset -display :0.0 dpms force off
    sleep 1
done

pkill update-notifier  # disattiva notifiche aggiornamenti &

date > /tmp/ora


# fai partire l'applicazione
python /home/$USER/projects/abh_gui_v3/coordinator/launcher_v3.py &

# accendi il monitor
xset -display :0.0 dpms force on
