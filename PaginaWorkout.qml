

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    property real time_ex: 0
    property real tut_ex: 0

    property real calibrazione: fb_udp.data[5]
    property real ripetizioni:  fb_udp.data[0]
    property bool end_calibration: false

    onRipetizioniChanged:
    {
         if (fb_udp.data[0]>=3 && state=="calibration")
         {
             state="sotto"
             end_calibration=true
         }
    }

    onCalibrazioneChanged:
    {
//         if (fb_udp.data[5]===10)
//         {
//             state= "calibration"
//         }
         if (fb_udp.data[0]>=3 && state=="calibration")
         {
             state="sotto"
         }
    }

    Component.onCompleted:
    {

        startstop_udp.string="start"
        parametri_generali.login_page=false
        _active_workouts.readFile((impostazioni_utente.identifier+"/ACTIVEWORKOUT"))

        if (selected_exercise.current_set>0 || selected_exercise.type===3  || selected_exercise.code === "novision")
            state="sotto"
        else
        {
            state="calibration"
            timer_tempo.resetValue()
            timer_tut.resetValue()
        }
        time_ex.active=true
        time_ex=timer_tempo.value*0.001
        tut_ex=timer_tut.value*0.001
        timer_tut.active=true
    }
    Component.onDestruction:
    {
        timer_tut.active=false
        time_ex.active=false
        startstop_udp.string="stop"
        parametri_generali.login_page=true

        selected_exercise.time_esercizio+=(timer_tempo.value*0.001-time_ex)
        selected_exercise.tut_esercizio+=(timer_tut.value*0.001-tut_ex)
    }


    id: component
    state: "sotto"

    states: [
        State {
            name: "sotto"
            PropertyChanges { target: sotto;      visible: true}
            PropertyChanges { target: early_stop; visible: false}
            PropertyChanges { target: skip;       visible: false}
            PropertyChanges { target: calibrazione;  visible: false}
            PropertyChanges { target: sotto;      z: 5}
            PropertyChanges { target: early_stop; z: 1}
            PropertyChanges { target: skip;       z: 1}

        },
        State {
            name: "early_stop"
            PropertyChanges { target: sotto;      visible: false}
            PropertyChanges { target: early_stop; visible: true}
            PropertyChanges { target: skip;       visible: false}
            PropertyChanges { target: calibrazione;  visible: false}
            PropertyChanges { target: sotto;      z: 1}
            PropertyChanges { target: early_stop; z: 5}
            PropertyChanges { target: skip;       z: 1}
        },
        State {
            name: "skip"
            PropertyChanges { target: sotto;      visible: false}
            PropertyChanges { target: early_stop; visible: false}
            PropertyChanges { target: skip;       visible: true}
            PropertyChanges { target: calibrazione;  visible: false}
            PropertyChanges { target: sotto;      z: 1}
            PropertyChanges { target: early_stop; z: 1}
            PropertyChanges { target: skip;       z: 5}
        },
        State {
            name: "calibration"
            PropertyChanges { target: sotto;      visible: false}
            PropertyChanges { target: early_stop; visible: false}
            PropertyChanges { target: skip;       visible: false}
            PropertyChanges { target: calibrazione;  visible: true}
            PropertyChanges { target: sotto;      z: 1}
            PropertyChanges { target: early_stop; z: 1}
            PropertyChanges { target: skip;       z: 5}
        }
    ]

    Item {
        id: ricevi_comando_vocale
        property real data: fb_udp.data[4]
        onDataChanged:
        {
            if (data==2)
            {
                pageLoader.source = "PaginaRiposo.qml"
            }
        }
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
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 140//210
        FrecceSxDx
        {
            id: freccia
            visible: (component.state==="sotto" ||component.state==="calibration")
            onPressSx:
            {
                component.state="early_stop"

            }
            dx_visible: component.state==="sotto"
            onPressDx:
            {
                component.state="skip"
            }
            z:5
        }
    }



    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true






        WorkoutTop{
            id: video_top
            swipe: component.state==="sotto"
        }
        WorkoutBottom{
            id: sotto

            onTimeout:
            {
                component.state="early_stop"
            }
        }

        WorkoutEarlyStop
        {
            id: early_stop
            visible: false
            onCancel: {
                if (selected_exercise.current_set>0)
                    component.state="sotto"
                else
                {
                     component.state="calibration"
                }
//                component.state="sotto"
            }
            onExit:
            {
                if (selected_exercise.workout==="")
                    pageLoader.source = "SceltaGruppo.qml"
                else
                    pageLoader.source = "ListaEserciziWorkout.qml"
            }
        }

        WorkoutSkip
        {
            id: skip
            visible: false
            onCancel: {
                component.state="sotto"

            }
            onExit: pageLoader.source=  "PaginaRiposo.qml"
        }

        WorkoutCalibration
        {
            id: calibrazione
            visible: false
        }
    }
}
