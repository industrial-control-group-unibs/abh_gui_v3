

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

    property string link_sx: pageLoader.last_source
    property string link_dx: "PaginaPreparati.qml"
    property string video_folder: "video_istruzioni"
    property string video_name: selected_exercise.video_preparati
    property string titolo: selected_exercise.name
    property bool timer: true

    Barra_superiore{
        id: barra
        Titolo
        {
            text:titolo
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
            onPressSx: pageLoader.source= link_sx
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
        }
    }

    Item{
        anchors.top: barra.bottom
        anchors.bottom: sotto.top
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true



        Rectangle   {
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.verticalCenter: parent.verticalCenter
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

                //                onPressPlay:
                //                {
                //                    mp_esercizio_preparati.play()
                //                }
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

//                loops: MediaPlayer.Infinite
                source: "file://"+PATH+"/"+ video_folder +"/"+video_name
                onStopped: play() //"play"

            }

            VideoOutput {
                id: video_preparatorio

                source: mp_esercizio_preparati
                anchors.fill: parent
                z:0
                visible: false
            }

//            PlayPauseButton
//            {
//                id: tasto_video
//                width: 100
//                anchors
//                {
//                    horizontalCenter: parent.horizontalCenter
//                    top: video_preparatorio.bottom
//                    topMargin: 5
//                }
//                z:2
//                state: "pause"

//                onPressPause: mp_esercizio_preparati.pause()
//                onPressPlay:
//                {
//                    mp_esercizio_preparati.play()
//                }
//            }




        }

    }
}
