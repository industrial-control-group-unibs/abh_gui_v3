

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
//        selected_exercise.name="unselected"
//        selected_exercise.code="unselected"
        timer_tut.active=false
        startstop_udp.string="stop"
        parametri_generali.login_page=true

        pageLoader.last_source="PaginaWorkout.qml"
    }

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
            onPressSx:
            {
                sx_visible= false
                sotto.visible=false
                freccia.visible=false
                early_stop.visible=true
            }
            dx_visible: true
            onPressDx:
            {
                sx_visible= false
                sotto.visible=false
                freccia.visible=false
                skip.visible=true
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
                freccia.sx_visible= false
                sotto.visible=false
                freccia.visible=false
                early_stop.visible=true
            }
        }

        WorkoutEarlyStop
        {
            id: early_stop
            visible: false
            onCancel: {
                freccia.sx_visible=true
                sotto.visible=true
                freccia.visible=true
                early_stop.visible=false
            }
            onExit: pageLoader.source= "PaginaAllenamento.qml"
        }

        WorkoutSkip
        {
            id: skip
            visible: false
            onCancel: {
                freccia.sx_visible=true
                sotto.visible=true
                freccia.visible=true
                skip.visible=false
            }
            onExit: pageLoader.source=  "PaginaRiposo.qml"
        }
    }
}
