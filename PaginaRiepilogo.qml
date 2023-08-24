

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    id: component

    signal press


    onPress:
    {
        selected_exercise.current_set=0
        pageLoader.source = "PaginaAllenamento.qml"


        if (selected_exercise.workout==="")
        {
            pageLoader.source = "SceltaGruppo.qml"
        }
        else
        {





            if (selected_exercise.personalizzato)
            {
                _active_workouts.changeValue(
                            impostazioni_utente.identifier+"/CUSTOMWORKOUT",
                            _active_workouts.getRowIndex(impostazioni_utente.identifier+"/CUSTOMWORKOUT",
                                                         0,
                                                         selected_exercise.workout),
                            1,
                            _workout.getProgess()
                            )

                _active_workouts.changeValue(
                            impostazioni_utente.identifier+"/CUSTOMWORKOUT",
                            _active_workouts.getRowIndex(impostazioni_utente.identifier+"/CUSTOMWORKOUT",
                                                         0,
                                                         selected_exercise.workout),
                            2,
                            _workout.getScore()
                            )

                _active_workouts.changeValue(
                            impostazioni_utente.identifier+"/CUSTOMWORKOUT",
                            _active_workouts.getRowIndex(impostazioni_utente.identifier+"/CUSTOMWORKOUT",
                                                         0,
                                                         selected_exercise.workout),
                            4,
                            _workout.getTime()
                            )
                _active_workouts.changeValue(
                            impostazioni_utente.identifier+"/CUSTOMWORKOUT",
                            _active_workouts.getRowIndex(impostazioni_utente.identifier+"/CUSTOMWORKOUT",
                                                         0,
                                                         selected_exercise.workout),
                            5,
                            _workout.getTut()
                            )
            }
            else
            {
                _active_workouts.changeValue(
                            impostazioni_utente.identifier+"/ACTIVEWORKOUT",
                            _active_workouts.getRowIndex(impostazioni_utente.identifier+"/ACTIVEWORKOUT",
                                                         0,
                                                         selected_exercise.workout),
                            1,
                            _workout.getProgess()
                            )

                _active_workouts.changeValue(
                            impostazioni_utente.identifier+"/ACTIVEWORKOUT",
                            _active_workouts.getRowIndex(impostazioni_utente.identifier+"/ACTIVEWORKOUT",
                                                         0,
                                                         selected_exercise.workout),
                            2,
                            _workout.getScore()
                            )

                _active_workouts.changeValue(
                            impostazioni_utente.identifier+"/ACTIVEWORKOUT",
                            _active_workouts.getRowIndex(impostazioni_utente.identifier+"/ACTIVEWORKOUT",
                                                         0,
                                                         selected_exercise.workout),
                            4,
                            _workout.getTime()
                            )
                _active_workouts.changeValue(
                            impostazioni_utente.identifier+"/ACTIVEWORKOUT",
                            _active_workouts.getRowIndex(impostazioni_utente.identifier+"/ACTIVEWORKOUT",
                                                         0,
                                                         selected_exercise.workout),
                            5,
                            _workout.getTut()
                            )
            }

            _workout.next()
            if (_workout.endSession)
            {

                _workout.updateStatFile(impostazioni_utente.identifier,_utenti.getWorkout(impostazioni_utente.identifier),timer_tempo.value,timer_tut.value);
                selected_exercise.workout_finito=false
                pageLoader.source="PaginaCoppa.qml"
            }
            else
            {
                selected_exercise.code=_workout.code
                selected_exercise.reps=_workout.reps
                selected_exercise.rest_time=_workout.rest
                selected_exercise.sets=_workout.sets
                selected_exercise.rest_set_time=_workout.restSet
                selected_exercise.power=_workout.power
                pageLoader.source="PaginaIstruzioni.qml"
            }


        }

    }

    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Component.onCompleted:
    {
        led_udp.data=[parametri_generali.coloreLed.r, parametri_generali.coloreLed.g, parametri_generali.coloreLed.b]
        timer_tut.stop()
        timer_tut.active=false
        timer_tempo.stop()
        startstop_udp.string="rewire"

        if (selected_exercise.score>2.0)
            selected_exercise.score=2.0;
        else if  (selected_exercise.score<0.0)
            selected_exercise.score=0.0;
    }
    Component.onDestruction:
    {
        startstop_udp.string="stop_rewire"
    }

    Barra_superiore{}

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
            id: titolo
            Titolo
            {
                text: selected_exercise.name
            }
        }

        Item {
            anchors
            {
                left: parent.left
                right: parent.right
                top:titolo.bottom
                bottom: avanti.top
                bottomMargin: 10
            }

            id: indicatori
            property real spacing: 10
            property real h:  (height-spacing*3)/3
            property real w: width

            Column {
                spacing: indicatori.spacing
                Item {
                    width: indicatori.w;
                    height: indicatori.h

                    CircularIndicator
                    {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.7
                        width: height

                        stepSize: 0.01
                        trackColor: parametri_generali.coloreBordo
                        trackWidth: 0.1*width
                        progressWidth: trackWidth
                        handleColor: "transparent"
                        progressColor: parametri_generali.coloreUtente
                        value: selected_exercise.score


                        Testo
                        {
                            text: (parent.value*10).toFixed(1).toString()
                            font.pixelSize: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: parametri_generali.coloreBordo
                            anchors
                            {
                                fill:parent
                            }
                        }
                    }
                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.15*parent.height
                        text: qsTr("PUNTEGGIO")
                        font.pixelSize: 50
                    }
                }
                Item {
                    width: indicatori.w;
                    height: indicatori.h

                    CircularIndicator
                    {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.7
                        width: height

                        stepSize: 0.01
                        trackColor: parametri_generali.coloreBordo
                        trackWidth: 0.1*width
                        progressWidth: trackWidth
                        handleColor: "transparent"
                        progressColor: parametri_generali.coloreUtente
                        value: selected_exercise.completamento


                        Testo
                        {
                            text: (parent.value*100).toFixed(0).toString()+"%"
                            font.pixelSize: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: parametri_generali.coloreBordo
                            anchors
                            {
                                fill:parent
                            }
                        }
                    }
                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.15*parent.height
                        text: qsTr("AVANZAMENTO")
                        font.pixelSize: 50
                    }
                }
                Item {
                    width: indicatori.w;
                    height: indicatori.h*0.5

                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.5*parent.height
                        text: qsTr("DURATA SESSIONE")
                        font.pixelSize: 50
                    }
                    Rectangle
                    {
                        anchors
                        {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                        }
                        height: 0.5*parent.height
                        radius: 0.5*height
                        width: parent.width*0.8
                        color: parametri_generali.coloreUtente
                        Testo
                        {
                            anchors.fill: parent
                            font.pixelSize: 50
                            font.bold: true
                            text: selected_exercise.time_esercizio+" s"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
                Item {
                    width: indicatori.w;
                    height: indicatori.h*0.5

                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.5*parent.height
                        text: "TU"
                        font.pixelSize: 50
                    }

                    Rectangle
                    {
                        anchors
                        {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                        }
                        height: 0.5*parent.height
                        radius: 0.5*height
                        width: parent.width*0.8
                        color: parametri_generali.coloreUtente
                        Testo
                        {
                            anchors.fill: parent
                            font.pixelSize: 50
                            font.bold: true
                            text: selected_exercise.tut_esercizio+" s"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }



        IconaPlus
        {
            id: avanti
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.03
            width: 100
            onPressed: component.press()

        }
    }
}
