

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0




PaginaVideoSingolo
{
    id: component
    link_dx: "PaginaWorkout.qml"
    video_folder: "video_preparazione_esercizi"
    video_name: selected_exercise.video_preparati
    titolo: selected_exercise.name

    onEndVideo: pageLoader.source="PaginaWorkout.qml"

    Item {
        id: ricevi_comando_vocale
        property real data: fb_udp.data[4]
        onDataChanged:
        {
            if (data==1)
            {
                pageLoader.source="PaginaWorkout.qml"
            }
        }
    }

    property bool play3s: false
    property bool playgo: false
    onRemaning_timeChanged:
    {
        console.log(component.remaning_time)
        if (component.remaning_time<6.0 && !component.playgo)
        {
            component.playgo=true
            playSound_go.play()
        }
        if (component.remaning_time<4.0 && !component.play3s)
        {
            component.play3s=true
            playSound.play()
        }
    }

    SoundEffect {
        id: playSound
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/321beep.wav"
        volume: parametri_generali.voice?1.0:0.0
    }
    SoundEffect {
        id: playSound_go
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/readygo.wav"
        volume: parametri_generali.voice?1.0:0.0
    }

    Component.onCompleted:
    {
        startstop_udp.string="rewire"
    }
    Component.onDestruction:
    {
        //_history.pop()
        //link_sx=_history.pop()

        if (selected_exercise.workout==="")
        {
            timer_tempo.resetValue()
            timer_tut.resetValue()
            selected_exercise.rest_time= parseFloat(_default[8])
        }

        startstop_udp.string="stop_rewire"
        if (selected_exercise.workout==="" || _workout.completed)
        {
            selected_exercise.current_set=0
        }
        else
        {
        }
    }
}


