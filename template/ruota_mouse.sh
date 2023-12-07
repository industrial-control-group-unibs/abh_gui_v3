#!/usr/bin/env bash
# ruota il touch, il nome del touch va settato come da mail
# Chiama  xinput list e cerca l'id del dispositivo
# Chiama xinput --list --id-only  e conta a che riga è l'id del dispositivo
# Chiama xinput  list --name-only e copia il nome della riga corrispondente (suppiamo eGalax Inc. eGalaxTouch P80H84 4104 v270HCT6_T1 k4.10.143)
# rotazione destra
#xinput set-prop "eGalax Inc. eGalaxTouch P80H84 4104 v270HCT6_T1 k4.10.143" 'Coordinate Transformation Matrix'   0 1 0 -1 0 1 0 0 1
# no rotazione
#xinput set-prop "eGalax Inc. eGalaxTouch P80H84 4104 v270HCT6_T1 k4.10.143" 'Coordinate Transformation Matrix'   1 0 0  0 1 0 0 0 1
# rotazione sinistra
#xinput set-prop "eGalax Inc. eGalaxTouch P80H84 4104 v270HCT6_T1 k4.10.143" 'Coordinate Transformation Matrix'   0 -1 1 1 0 0 0 0 1
#
#
xinput set-prop  "eGalax Inc. eGalaxTouch P80H84 4104 v270HCT6_T1 k4.10.143" 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1
