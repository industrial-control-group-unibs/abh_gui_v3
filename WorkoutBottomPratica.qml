import QtQuick 2.12

import QtMultimedia 5.0
Item
{

    property real duration
    property real position
    Component.onCompleted: {

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
    signal stop
    signal finish
    id: component

    Timer{
        id: conto_alla_rovescia
        interval: 1000*60*60
        repeat: false
        running: parent.visible
        onTriggered:
        {
            timeout()
        }
    }



    SoundEffect {
        id: playSound_5s
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/54321.wav"
        volume: parametri_generali.voice?1.0:0.0
    }
    SoundEffect {
        id: playSound_go
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/frase5sec.wav"
        volume: parametri_generali.voice?1.0:0.0
    }


    SoundEffect {
        id: playSound_1
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/1.wav"
        volume: parametri_generali.voice?1.0:0.0
    }
    SoundEffect {
        id: playSound_2
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/2.wav"
        volume: parametri_generali.voice?1.0:0.0
    }
    SoundEffect {
        id: playSound_3
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/3.wav"
        volume: parametri_generali.voice?1.0:0.0
    }
    SoundEffect {
        id: playSound_4
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/4.wav"
        volume: parametri_generali.voice?1.0:0.0
    }
    SoundEffect {
        id: playSound_5
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/5.wav"
        volume: parametri_generali.voice?1.0:0.0
    }


    IconaRipetizioni
    {
        id: icona_rep
        visible: true
        width: parent.height*0.35
        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.verticalCenterOffset: -parent.height*0.25
        anchors.verticalCenter: parent.verticalCenter
        colore: parametri_generali.coloreBordo
        ripetizioni: (component.duration-component.position)*0.001
        property real ratio: (1.0*component.position)/component.duration

        CircularTimer {
            colore: parametri_generali.coloreUtente
            anchors.fill: parent
            anchors.margins: dimensione_tache*-0.25
            value: parent.ratio
            visualizza_tempo: false
            dimensione_tache: 24
            tacche: 20
        }

        property bool play5s: false
        property bool playgo: false
        onRipetizioniChanged: {

            if (!playgo)
            {
                playgo=true
                playSound_go.play()
            }

            if (icona_rep.ripetizioni<6 && !play5s)
            {
                play5s=true
                playSound_5s.play()
            }

            conto_alla_rovescia.restart()

            led_udp.data=[parametri_generali.coloreLedInizio.r*(1.0-ratio)+parametri_generali.coloreLedFine.r*ratio,
                          parametri_generali.coloreLedInizio.g*(1.0-ratio)+parametri_generali.coloreLedFine.g*ratio,
                          parametri_generali.coloreLedInizio.b*(1.0-ratio)+parametri_generali.coloreLedFine.b*ratio]

            if (ripetizioni<=0)
            {
                component.finish()
            }

        }
        Testo
        {
            text: qsTr("DURATA")
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
        visible: false
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
        visible: false

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



}






