

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0

//import UdpVideoStream 1.0

PaginaVideoSingolo
{
    id: component
    onPressSx: pageLoader.source= "SceltaYogaPraticaEsercizi.qml"
    link_dx: "PaginaWorkoutPratica.qml"
    link_dx_visible: true
    video_folder: "video_preparazione_esercizi"
    video_name: _esercizi.getVideoPrep(disciplina.esercizio)
    titolo: _esercizi.getName(disciplina.esercizio)
    timer: true
    testo_visibile: false

    Component.onCompleted: {
        selected_exercise.code="novision"
        video_name= _esercizi.getVideoWorkout(disciplina.esercizio)
    }

    onEndVideo: pageLoader.source=pageLoader.source= "PaginaWorkoutPratica.qml"

    property bool play5s: false
    onRemaning_timeChanged:
    {

        if (component.remaning_time<5.0 && !component.play5s)
        {
            component.play5s=true
            playSound.play()
        }
    }

    SoundEffect {
        id: playSound
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/frase5sec.wav"
        volume: parametri_generali.voice?1.0:0.0
    }


//    Component.onCompleted:
//    {
//        startstop_udp.string="rewire"
//    }
//    Component.onDestruction:
//    {
//        startstop_udp.string="stop_rewire"
//    }


}
