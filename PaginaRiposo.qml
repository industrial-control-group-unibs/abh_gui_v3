

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
                    console.log("fine timer");
                    selected_exercise.current_set++
                    if (selected_exercise.current_set<selected_exercise.sets)
                    {
                        console.log("rinvia nome");
                        exercise_udp.send()
                        pageLoader.source="PaginaWorkout.qml"
                    }
                    else
                    {
                        selected_exercise.current_set=0
                        console.log("?? finito");
                        if (selected_exercise.workout==="")
                        {
                            console.log("vai al riepilogo");

                            pageLoader.source="PaginaRiepilogo.qml"
                        }
                        else
                        {
                            //selected_exercise.reps
                            _workout.setScore(selected_exercise.score)
                            _workout.next();
                            if (_workout.endSession)
                            {
                                console.log("vai al riepilogo");
                                pageLoader.source="PaginaRiepilogoWorkout.qml"

                                _workout.updateStatFile(impostazioni_utente.identifier,_utenti.getWorkout(impostazioni_utente.identifier),timer_tempo.value,timer_tut.value);
                            }
                            else
                            {
                                console.log("vai al prossimo esercizio");
                                selected_exercise.code=_workout.code
                                selected_exercise.reps=_workout.reps
                                selected_exercise.rest_time=_workout.rest
                                selected_exercise.sets=_workout.sets
                                selected_exercise.rest_set_time=_workout.restSet
                                selected_exercise.power=_workout.power
                                pageLoader.source="PaginaRiepilogoSetWorkout.qml"
                            }
                        }
                    }
                    console.log("fatto");
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
