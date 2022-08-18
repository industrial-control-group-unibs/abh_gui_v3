

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Component.onCompleted: startstop_udp.string="start"
    Component.onDestruction:
    {
        selected_exercise.name="unselected"
        selected_exercise.code="unselected"
        startstop_udp.string="stop"
        pageLoader.last_source="PaginaWorkout.qml"
    }

    Barra_superiore{}
    FrecceSxDx
    {
        link_sx: pageLoader.last_source
        dx_visible: false
        z:5
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
        state: "sx"
    }

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true

        Titolo
        {
            text: selected_exercise.name
        }




        WorkoutTop{
            id: video_top
        }
        WorkoutBottom{}
    }
}
