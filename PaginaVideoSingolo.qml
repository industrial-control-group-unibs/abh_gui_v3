

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    id: component
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    property string link_dx: "PaginaPreparati.qml"
    property string video_folder: "video_istruzioni"
    property string video_name: selected_exercise.video_preparati
    property string titolo: selected_exercise.name
    property bool timer: true

    signal endVideo

    Component.onCompleted:
    {

    }

    Barra_superiore{
        id: barra

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

                text:titolo
            }
        }
    }

    Item
    {
        id: sotto
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height*0.3
        FrecceSxDx
        {
            onPressSx:
            {
                _history.pop()
                pageLoader.source= _history.front()
            }
            onPressDx: pageLoader.source= link_dx
        }

        CircularTimer {
            visible: component.timer
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            id: tempo
            value: mp_esercizio_preparati.position/mp_esercizio_preparati.duration
            tempo: (mp_esercizio_preparati.duration-mp_esercizio_preparati.position) //timerino.remaining_time
            colore: parametri_generali.coloreUtente
            coloreTesto: colore
        }
    }

    Item{
        anchors.top: barra.bottom
        anchors.bottom: sotto.top
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true



        Rectangle   {
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30
            width: 786/1396.61*height
            height: parent.height-anchors.topMargin
            radius: 20
            border.color: mp_esercizio_preparati.status===MediaPlayer.EndOfMedia? "transparent": parametri_generali.coloreBordo
            border.width: 2

            MouseArea
            {
                anchors.fill: parent
                property bool play: true
                onPressed:
                {
                    if (play)
                    {
                        play=false
                        mp_esercizio_preparati.pause()
                    }
                    else
                    {
                        play=true
                        mp_esercizio_preparati.play()
                    }
                }
            }

            Rectangle
            {
                id: video_preparatorio_mask
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
                anchors.fill:video_preparatorio_mask
                source: video_preparatorio
                maskSource: video_preparatorio_mask
            }


            MediaPlayer {
                id: mp_esercizio_preparati
                autoPlay: true
                autoLoad: true

                source: "file://"+PATH+"/"+ video_folder +"/"+video_name
                onStopped:
                {
                    component.endVideo()
                    play() //"play"
                }

            }

            VideoOutput {
                id: video_preparatorio

                source: mp_esercizio_preparati
                anchors.fill: parent
                z:0
                visible: false
            }





        }

    }
}
