

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
        if (selected_exercise.workout_finito)
            pageLoader.source = "PaginaRiepilogoWorkout.qml"
        else
            pageLoader.source = "PaginaRiepilogoSetWorkout.qml"
    }


    SoundEffect {
        id: playSound_serie
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/fine_sessione.wav"
        volume: parametri_generali.voice?1.0:0.0
    }

    SoundEffect {
        id: playSound_allenamento
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/allenamento_completato.wav"
        volume: parametri_generali.voice?1.0:0.0
    }



    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Component.onCompleted:
    {
        if (selected_exercise.workout_finito)
        {
            playSound_allenamento.play()
        }
        else
        {
            playSound_serie.play()
        }
        timer_tut.stop()
        timer_tut.active=false
        timer_tempo.stop()
        startstop_udp.string="rewire"

    }
    Component.onDestruction:
    {
        startstop_udp.string="stop_rewire"
        selected_exercise.score=0
        selected_exercise.workout_finito=false
    }

    Barra_superiore{}



    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true


        Item {
            id: titolo
            anchors
            {
                left: parent.left
                right: parent.right
                top:parent.top
                topMargin: 10
            }
            height: parent.height*0.4
            Titolo
            {
                text:qsTr("BEN FATTO!")+"\n\n"+(selected_exercise.workout_finito?qsTr("PROGRAMMA COMPLETATO!"):qsTr("ALLENAMENTO COMPLETATO!"))
                fontSize: 60
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

        Item {
            id: coppa
            anchors.top: titolo.bottom
            anchors.bottom: avanti.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: parent.width*0.1

              AnimatedImage {
                  anchors.fill: parent
                  fillMode: Image.PreserveAspectFit
                  id: animation;
                  source: "file://"+PATH+"/loghi/trophy.gif"
              }
        }

    }
}
