

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
    property bool play: true
    property bool testo_visibile: false
    property string testo: ""
    property real remaning_time: 10000
    signal endVideo

    Component.onCompleted:
    {

    }


    Timer
    {
        id: pause_timer
        property int value: 0
        interval: 120*1000 // two minutes
        repeat: false
        running: true
        onTriggered:
        {
            console.log("timer elapsed")
        }
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

        Testo
        {
            visible: component.testo_visibile
            text: component.testo
            font.pixelSize: 60
            fontSizeMode: Text.Fit
            wrapMode: Text.WordWrap
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: parent.height*0.25

            }
            width: 0.5*parent.width
        }

        FrecceSxDx
        {
            onPressSx:
            {
                _history.pop()
                pageLoader.source= _history.pop()
            }
            onPressDx: pageLoader.source= link_dx
        }

        CircularTimer {
            visible: component.timer
            width: parent.height*0.35
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            id: tempo
            value: mp_esercizio_preparati.position/mp_esercizio_preparati.duration
            tempo: (mp_esercizio_preparati.duration-mp_esercizio_preparati.position) //timerino.remaining_time
            colore: parametri_generali.coloreUtente
            coloreTesto: component.play?colore:"transparent"

            onTempoChanged: component.remaning_time=tempo.tempo*0.001
            Item {
                visible: !component.play
                anchors.fill: parent
                Rectangle
                {
                    color: tempo.colore
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: -0.08*parent.width
                    width: 0.1*parent.width
                    height: 0.5*parent.height
                }
                Rectangle
                {
                    color: tempo.colore
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 0.08*parent.width
                    width: 0.1*parent.width
                    height: 0.5*parent.height
                }
            }
            MouseArea
            {
                id: play_pause_timer
                anchors.fill: parent
                onPressed:
                {
                    if (component.play)
                    {
                        component.play=false
                        mp_esercizio_preparati.pause()
                    }
                    else
                    {
                        component.play=true
                        mp_esercizio_preparati.play()
                        pause_timer.restart()
                    }
                }
            }
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

            Testo
            {
                visible: mp_esercizio_preparati.status===MediaPlayer.EndOfMedia
                anchors.fill: parent
                text: qsTr("PREMI PER VEDERE\nIL TUTORIAL")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                font.pixelSize: 40
            }

            MouseArea
            {
                id: play_pause
                anchors.fill: parent
                onPressAndHold: console.error("press and hold during video")
                onPressed:
                {
                    if (component.play && mp_esercizio_preparati.status!==MediaPlayer.EndOfMedia)
                    {
                        component.play=false
                        mp_esercizio_preparati.pause()
                    }
                    else
                    {
                        component.play=true
                        mp_esercizio_preparati.play()
                        pause_timer.restart()
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
                    if (pause_timer.running)
                        play() //"play"
                    else
                        play_pause.play=false
                }

            }

            VideoOutput {
                id: video_preparatorio

                source: mp_esercizio_preparati
                anchors.fill: parent
                fillMode: VideoOutput.PreserveAspectFit
                z:0
                visible: false
            }
            Item {
                visible: !component.play  && !component.timer
//                anchors.left: parent.left
//                anchors.top: parent.top
//                anchors.topMargin: parent.width*0.02
//                anchors.leftMargin: parent.width*0.02
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width*0.40
                height: width
                Rectangle
                {
                    color: parametri_generali.coloreUtente
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: -0.08*parent.width
                    width: 0.1*parent.width
                    height: 0.5*parent.height
                }
                Rectangle
                {
                    color: parametri_generali.coloreUtente
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 0.08*parent.width
                    width: 0.1*parent.width
                    height: 0.5*parent.height
                }
            }





        }

    }
}
