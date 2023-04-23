

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

//    Component.onDestruction:
//    {
//        pageLoader.last_source="PaginaPreparati.qml"
//    }

    Component.onCompleted:
    {
        led_udp.data=[parametri_generali.coloreLedPausa.r, parametri_generali.coloreLedPausa.g, parametri_generali.coloreLedPausa.b]
    }
    Component.onDestruction:
    {
        startstop_udp.string="stop_rewire"
    }

    Barra_superiore{

        Item
        {
            anchors
            {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                leftMargin: 170
                rightMargin: 170
            }
            Titolo
            {

                text:selected_exercise.name
            }
        }
    }

    Item
    {
        id: sotto
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height*0.3
        FrecceSxDx
        {
            sx_visible: false
            dx_visible: true
            onPressDx: conto_alla_rovescia.position=conto_alla_rovescia.duration
        }


    }

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true



        Timer{
            id: conto_alla_rovescia
            interval: 500
            repeat: true
            running: true
            property int position: 0
            property int duration: selected_exercise.rest_time*1000
            onTriggered: {
                if (position<duration)
                {
                    position+=interval
                }
                else
                {
                    selected_exercise.current_set++
                    if (selected_exercise.current_set<selected_exercise.sets)
                    {
                        exercise_udp.send()
                        pageLoader.source="PaginaWorkout.qml"
                    }
                    else
                    {
                        led_udp.data=[parametri_generali.coloreLed.r, parametri_generali.coloreLed.g, parametri_generali.coloreLed.b]
                        selected_exercise.current_set=0
                        if (selected_exercise.workout==="")
                        {
                        }
                        else
                        {

                            _workout.setScore(selected_exercise.score)
                            _workout.setTime(selected_exercise.time_esercizio)
                            _workout.setTut(selected_exercise.tut_esercizio)
                        }
                        pageLoader.source="PaginaRiepilogo.qml"

                    }
                }
            }
        }

        Item   {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 300*parent.width/1080
            width: 436*parent.width/1080
            height: 581*parent.width/1080




            CircularTimer {
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                width: parent.width
                height: width
                tacche: 120
                value: 1-conto_alla_rovescia.position/conto_alla_rovescia.duration
                tempo: (conto_alla_rovescia.duration-conto_alla_rovescia.position) //timerino.remaining_time
                onTempoChanged:
                {
                    if (tempo<10000)
                    {
                        startstop_udp.string="rewire"
                        led_udp.data=[parametri_generali.coloreLedFinePausa.r, parametri_generali.coloreLedFinePausa.g, parametri_generali.coloreLedFinePausa.b]
                    }
                }

                colore: (tempo<10000)?"red":parametri_generali.coloreUtente
                coloreTesto: colore
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        conto_alla_rovescia.position=conto_alla_rovescia.duration
                    }
                }
            }
            Testo
            {
                text: "SERIE "+(selected_exercise.current_set+1)+" DI "+selected_exercise.sets
                font.pixelSize: 60
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
