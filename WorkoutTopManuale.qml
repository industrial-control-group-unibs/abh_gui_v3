import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.12

import UdpVideoStream 1.0

import Charts 1.0
Item
{
    Component.onCompleted: {
        timer_tempo.start()
    }
    Component.onDestruction: timer_tempo.stop()

    implicitWidth: 1080*.5
    implicitHeight: 1920*.5


    id: component

    property bool swipe: true

    state: "utente"
    states: [

        State {
            name: "utente"
            PropertyChanges { target: rect_utente; height: 0.95*component.height   }
            PropertyChanges { target: rect_utente; y: 0.5*(component.height-height)   }
            PropertyChanges { target: rect_utente; x: 0.5*(component.width-width) }
            PropertyChanges { target: rect_utente; visible: true }

            PropertyChanges { target: rect_utente;          z:1 }
        }
    ]






    anchors
    {
        left: parent.left
        right: parent.right
        top: parent.top
    }
    height: parent.height*0.7




    Rectangle   {
        height: 0.3*parent.height
        width: 9/16*height
        x: 890/1080*parent.width-0.5*width
        y: 0.1*parent.height
        id: rect_utente
        visible: true

        color: "black"
        radius: 20
        border.color: parametri_generali.coloreBordo
        border.width: 2



        Rectangle
        {
            id: video2_mask
            anchors
            {
                fill: parent
                topMargin: parent.border.width
                bottomMargin: parent.border.width
                leftMargin: parent.border.width
                rightMargin: parent.border.width
            }
            visible: false
            color: "white"
            radius: parent.radius-parent.border.width
        }



        OpacityMask {
            anchors.fill:video2_mask
            source: video2_workout
            maskSource: video2_mask
        }

        VideoOutput {
            id: video2_workout

            source: udpStream
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectFit
            z:0
            visible: false
        }
    }



}






