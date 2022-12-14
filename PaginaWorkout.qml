

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
        timer_tut.active=true
        startstop_udp.string="start"
        parametri_generali.login_page=false
    }
    Component.onDestruction:
    {
        timer_tut.active=false
        startstop_udp.string="stop"
        parametri_generali.login_page=true
    }
    id: component
    state: "sotto"

    states: [
        State {
            name: "sotto"
            PropertyChanges { target: sotto;      visible: true}
            PropertyChanges { target: early_stop; visible: false}
            PropertyChanges { target: skip;       visible: false}
            PropertyChanges { target: sotto;      z: 5}
            PropertyChanges { target: early_stop; z: 1}
            PropertyChanges { target: skip;       z: 1}

        },
        State {
            name: "early_stop"
            PropertyChanges { target: sotto;      visible: false}
            PropertyChanges { target: early_stop; visible: true}
            PropertyChanges { target: skip;       visible: false}
            PropertyChanges { target: sotto;      z: 1}
            PropertyChanges { target: early_stop; z: 5}
            PropertyChanges { target: skip;       z: 1}
        },
        State {
            name: "skip"
            PropertyChanges { target: sotto;      visible: false}
            PropertyChanges { target: early_stop; visible: false}
            PropertyChanges { target: skip;       visible: true}
            PropertyChanges { target: sotto;      z: 1}
            PropertyChanges { target: early_stop; z: 1}
            PropertyChanges { target: skip;       z: 5}
        }
    ]

    onStateChanged: console.log("ehi!!!", state)

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
        height: parent.height*0.3
        FrecceSxDx
        {
            id: freccia
            visible: component.state==="sotto"
            onPressSx:
            {
//                sx_visible= false
//                dx_visible= false
//                sotto.visible=false
//                freccia.visible=false
//                early_stop.visible=true
                component.state="early_stop"

                console.log("qua!!!", component.state)
            }
            dx_visible: true
            onPressDx:
            {
                component.state="skip"
//                sx_visible= false
//                dx_visible= false
//                sotto.visible=false
//                freccia.visible=false
//                skip.visible=true

                console.log("qua!!!", component.state)
            }
            z:5
        }
    }

    BottoniSwipe{

        onPressRight:
        {
            video_top.state="stats"
        }
        onPressLeft:
        {
            video_top.state="workout"
        }
        visible: freccia.visible
        state: "sx"
    }

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true






        WorkoutTop{
            id: video_top
        }
        WorkoutBottom{
            id: sotto

            onTimeout:
            {
//                freccia.sx_visible= false
//                sotto.visible=false
//                freccia.visible=false
//                early_stop.visible=true
                component.state="early_stop"
            }
        }

        WorkoutEarlyStop
        {
            id: early_stop
            visible: false
            onCancel: {

                component.state="sotto"
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
//                freccia.sx_visible=true
//                sotto.visible=true
//                freccia.visible=true
//                skip.visible=false
                component.state="sotto"
            }
            onExit: pageLoader.source=  "PaginaRiposo.qml"
        }
    }
}
