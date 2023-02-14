

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




            console.log( _workout.getSessionProgess(selected_exercise.selected_session))
            _active_workouts.changeValue(
                        "ACTIVEWORKOUT_"+impostazioni_utente.identifier,
                        _active_workouts.getRowIndex("ACTIVEWORKOUT_"+impostazioni_utente.identifier,
                                                     0,
                                                     selected_exercise.workout),
                        1,
                        _workout.getProgess()
                        )

            _active_workouts.changeValue(
                        "ACTIVEWORKOUT_"+impostazioni_utente.identifier,
                        _active_workouts.getRowIndex("ACTIVEWORKOUT_"+impostazioni_utente.identifier,
                                                     0,
                                                     selected_exercise.workout),
                        2,
                        _workout.getScore()
                        )

            _active_workouts.changeValue(
                        "ACTIVEWORKOUT_"+impostazioni_utente.identifier,
                        _active_workouts.getRowIndex("ACTIVEWORKOUT_"+impostazioni_utente.identifier,
                                                     0,
                                                     selected_exercise.workout),
                        4,
                        _workout.getTime()
                        )

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
                        text: "PUNTEGGIO"
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
                        text: "COMPLETAMENTO"
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
                        text: "DURATA SESSIONE"
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
                        text: "TUT"
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
            anchors.bottomMargin: parent.height*0.1
            width: 100
            onPressed: component.press()

        }
    }
}


//import QtGraphicalEffects 1.12
//import QtQuick 2.12
//import QtQuick.Shapes 1.12

//import QtQuick.Layouts 1.1

//import QtMultimedia 5.0


//Item {
//    anchors.fill: parent

//    implicitHeight: 1920/2
//    implicitWidth: 1080/2

//    Component.onCompleted:
//    {
//        timer_tut.stop()
//        timer_tut.active=false
//        timer_tempo.stop()
//        startstop_udp.string="rewire"
//    }
//    Component.onDestruction:
//    {
//        startstop_udp.string="stop_rewire"
//    }

//    Barra_superiore{}


//    Rectangle{
//        anchors.fill: parent
//        anchors.topMargin: parametri_generali.larghezza_barra
//        color: "transparent"//parametri_generali.coloreSfondo
//        clip: true


//        Item {
//            anchors
//            {
//                left: parent.left
//                right: parent.right
//                top:parent.top
//                topMargin: 10
//            }
//            height: parent.height*0.2
//            Titolo
//            {
//                text: "BEN FATTO!"
//            }

//        }

//        CircularTimer {
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.horizontalCenterOffset: parent.width*0.25
//            anchors.verticalCenter: parent.verticalCenter
//            width: 400/1080*parent.width
//            id: time
//            value: timer_tempo.value/1000/60-Math.floor(timer_tempo.value/1000/60)
//            tempo: timer_tempo.value

//            Testo
//            {
//                text: "TEMPO\nGLOBALE"
//                anchors
//                {
//                    horizontalCenter: parent.horizontalCenter
//                    top: parent.bottom
//                    topMargin: 5

//                }
//            }
//        }

//        CircularTimer {
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.horizontalCenterOffset: -parent.width*0.25
//            anchors.verticalCenter: parent.verticalCenter
//            width: 400/1080*parent.width
//            id: tut
//            value: timer_tut.value/1000/60-Math.floor(timer_tut.value/1000/60)
//            tempo: timer_tut.value

//            Testo
//            {
//                text: "TEMPO\nESERCIZIO"
//                anchors
//                {
//                    horizontalCenter: parent.horizontalCenter
//                    top: parent.bottom
//                    topMargin: 5

//                }
//            }
//        }

//        IconaPlus
//        {
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: parent.height*0.1
//            width: 100
//            onPressed:
//            {
//                selected_exercise.current_set=0

//                if (selected_exercise.workout==="")
//                    pageLoader.source = "SceltaGruppo.qml"
//                else
//                    pageLoader.source = "SceltaWorkout.qml"

//            }
//            Testo
//            {
//                text: "CONTINUA"
//                anchors
//                {
//                    horizontalCenter: parent.horizontalCenter
//                    top: parent.bottom
//                    topMargin: 5

//                }
//            }
//        }


//    }
//}
