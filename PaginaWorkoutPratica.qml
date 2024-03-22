

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

    property real ripetizioni


    Component.onCompleted:
    {
        startstop_udp.string="start"
        state="sotto"
    }
    Component.onDestruction:
    {
        startstop_udp.string="stop"
    }


    id: component
    state: "sotto"

    signal finish

    onFinish: {
        pageLoader.source= "SceltaYogaPraticaEsercizi.qml"
    }

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
            visible: component.state==="sotto"
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






        WorkoutTopPratica{
            id: video_top
            swipe: false
        }
        WorkoutBottomPratica{
            id: sotto

            duration: video_top.duration
            position: video_top.position
            onTimeout:
            {
                component.state="early_stop"
            }
            onFinish: component.finish()
        }

        WorkoutEarlyStop
        {
            id: early_stop
            visible: false
            onCancel: {
                component.state="sotto"

            }
            onExit: component.finish()
        }

        WorkoutSkip
        {
            id: skip
            visible: false
            onCancel: {
                component.state="sotto"

            }
            onExit: component.finish()
        }

    }
}

