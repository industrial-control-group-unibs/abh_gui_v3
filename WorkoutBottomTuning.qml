import QtQuick 2.12

import QtMultimedia 5.0
Item
{

    property real default_power: 0
    Component.onCompleted: {
        power_settings.value= selected_exercise.power
        if (selected_exercise.workout==="")
            default_power=selected_exercise.default_power
        else
            default_power=_workout.power
        if (selected_exercise.type===3)
        {
            icona_rep.ripetizioni=selected_exercise.reps
        }
        else
        {
            if (fb_udp.data[0]>1)
            {
                console.log("ripetizioni non sono 0")
                icona_rep.ripetizioni=1
            }
        }
    }

    anchors
    {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    height: parent.height*0.3

    property bool is_visible: true

    signal timeout
    id: component

    Timer{
        id: conto_alla_rovescia
        interval: 1000*60*5
        repeat: false
        running: parent.visible
        onTriggered:
        {
            timeout()
        }
    }

//    Timer{
//        id: go_out
//        interval: 200
//        repeat: false
//        running: false
//        onTriggered:
//        {
//            pageLoader.source = "PaginaRiposo.qml"
//        }
//    }


    Timer
    {
        property int value: 0
        interval: 500
        id: timer_esercizio
        repeat: true
        running: selected_exercise.type===3
        onTriggered:
        {
            value+=interval
            if (selected_exercise.type===3 && fb_udp.data[5]!==2)
            {
                icona_rep.ripetizioni=selected_exercise.reps-value*0.001
            }
        }



    }





    LinearSlider
    {
        visible: selected_exercise.type===1
        id: power_settings
        height: parent.height*0.20*0.66
        width: parent.width*0.5
        max: 25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height*0.2
        value: selected_exercise.power
        onValueChanged: {
            selected_exercise.power=value
        }
        Testo
        {
            text: qsTr("POWER")
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5

            }
        }
    }



    IconaRipetizioni
    {
        id: icona_rep
        visible: parent.is_visible && selected_exercise.code !== "novision"
        width: parent.height*0.35
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -parent.height*0.25
        anchors.verticalCenter: parent.verticalCenter
        colore: parametri_generali.coloreBordo
        ripetizioni: fb_udp.data[0]
        property real ratio: 1.0

        CircularTimer {
            colore: parametri_generali.coloreUtente
            anchors.fill: parent
            anchors.margins: dimensione_tache*-0.25
            value: parent.ratio
            visualizza_tempo: false
            dimensione_tache: 24
            tacche: 20
        }

        onRipetizioniChanged: {

            conto_alla_rovescia.restart()
            if (selected_exercise.type<3)
            {
            }
            else
            {
                if (ripetizioni<=0)
                {
                    icona_rep.ripetizioni=selected_exercise.reps
                }
            }
        }
        Testo
        {
            text: selected_exercise.type===3?qsTr("DURATA"):qsTr("RIPETIZIONI")
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5

            }
        }
    }

    CircularTimer {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: parent.width*0.35
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height*0.1
        width: icona_rep.width
        colore: parametri_generali.coloreUtente
        id: time
        value: timer_tempo.value/1000/60-Math.floor(timer_tempo.value/1000/60)
        tempo: timer_tempo.value
        visible: parent.is_visible
        dimensione_tache: 8
        tacche: 30

        Testo
        {
            text: qsTr("TIME")
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5

            }
        }
    }

    CircularTimer {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width*0.35
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height*0.1
        width: icona_rep.width
        colore: parametri_generali.coloreUtente
        id: tut
        value: timer_tut.value/1000.0/60.0-Math.floor(timer_tut.value/1000.0/60.0)
        tempo: timer_tut.value
        visible: parent.is_visible

        dimensione_tache: 8
        tacche: 30
        Testo
        {
            text: qsTr("TU")
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5

            }
        }
    }

    Testo
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        text: qsTr("SERIE")+" "+(selected_exercise.current_set+1)+" "+qsTr("DI")+" "+selected_exercise.sets
    }

    Testo
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        property real perc: fb_udp.data[6].toFixed(0)
        property real perc_saturata: 0
        property real velocita: 0

        property string testo2: ""
        property string testo:
        {
            if (fb_udp.data[5]===0)
                return "STOP"
            else if (fb_udp.data[5]===1)
                return "FORWARD"
            else if (fb_udp.data[5]===-1)
                return "BACKWARD"
            else if (fb_udp.data[5]===2)
                return "NONE"
            else if (fb_udp.data[5]===3)
                return "REWIRE"
            else if (fb_udp.data[5]===10)
                return "CALIBRATING"
            else if (fb_udp.data[5]===11)
                return "INITIALIZING"
        }

        property string t1: ""
        property string t2: ""
        property string t3: ""
        property string t4: ""
        property string t5: ""
        onTestoChanged:
        {
            perc_saturata = fb_udp.data[3].toFixed(0)
            velocita = fb_udp.data[2].toFixed(1)

            t1=t2
            t2=t3
            t3=t4
            t4=t5
            console.log("testo = ",testo)
            if (testo==="FORWARD" && testo2==="BACKWARD")
                t5="F="+perc_saturata+"%;"+velocita+" | "
            else if (testo==="BACKWARD" && testo2==="FORWARD")
                t5="B="+perc_saturata+"%;"+velocita+" | "

            testo2=testo
        }

        text: testo+" V: "+perc+"%"+"\n" +t1+t2+t3+t4+t5

    }


}






