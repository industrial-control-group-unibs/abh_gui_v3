

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Component.onCompleted:
    {
        timer_tut.stop()
        timer_tut.active=false
        timer_tempo.stop()
        startstop_udp.string="rewire"
    }
    Component.onDestruction:
    {
        startstop_udp.string="stop_rewire"
    }

    Barra_superiore{}
//        FrecceSxDx
//        {
//            link_sx: "PaginaAllenamento.qml"
//            dx_visible: false;
//        }

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true


        Item {
            anchors
            {
                left: parent.left
                right: parent.right
                top:parent.top
                topMargin: 10
            }
            height: parent.height*0.2
            Titolo
            {
                text: "BEN FATTO!"
            }

        }

        CircularTimer {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: parent.width*0.25
            anchors.verticalCenter: parent.verticalCenter
            width: 400/1080*parent.width
            id: time
            value: timer_tempo.value/1000/60-Math.floor(timer_tempo.value/1000/60)
            tempo: timer_tempo.value

            Testo
            {
                text: "TEMPO\nGLOBALE"
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
            anchors.horizontalCenterOffset: -parent.width*0.25
            anchors.verticalCenter: parent.verticalCenter
            width: 400/1080*parent.width
            id: tut
            value: timer_tut.value/1000/60-Math.floor(timer_tut.value/1000/60)
            tempo: timer_tut.value

            Testo
            {
                text: "TEMPO\nESERCIZIO"
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.bottom
                    topMargin: 5

                }
            }
        }

        PlayPauseButton
        {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.1
            width: 100
            onPressPlay:
            {
                selected_exercise.current_set=0

                if (selected_exercise.workout==="")
                    pageLoader.source = "SceltaGruppo.qml"
                else
                    pageLoader.source = "SceltaWorkout.qml"

            }
            Testo
            {
                text: "CONTINUA PER IL\nLOG OUT"
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.bottom
                    topMargin: 5

                }
            }
        }


    }
}
