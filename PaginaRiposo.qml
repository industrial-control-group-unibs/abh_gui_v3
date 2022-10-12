

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

    Barra_superiore{

        Titolo
        {
            text: selected_exercise.name
        }
    }
//    FrecceSxDx
//    {
//        link_sx: pageLoader.last_source
//        link_dx: "PaginaWorkout.qml"
//    }

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
                        _workout.next();
                        if (selected_exercise.workout==="" || _workout.completed)
                        {
                            pageLoader.source="PaginaRiepilogo.qml"
                            selected_exercise.current_set=0
                        }
                        else
                        {
                            selected_exercise.name=_workout.name
                            selected_exercise.reps=_workout.reps
                            selected_exercise.rest_time=_workout.rest
                            selected_exercise.sets=_workout.sets
                            selected_exercise.max_pos_speed=_workout.maxPosSpeed
                            selected_exercise.max_neg_speed=_workout.maxNegSpeed
                            selected_exercise.current_set=0
                            selected_exercise.power=_workout.power
                            pageLoader.source="PaginaPreparati.qml"
                        }
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
                colore: (tempo<5000)?"red":parametri_generali.coloreBordo
            }
            Testo
            {
                text: "SET "+(selected_exercise.current_set+1)+" DI "+selected_exercise.sets
                font.pixelSize: 30
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
