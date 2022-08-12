

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true


        Text {
            text: selected_exercise.ex_name
            id: testo_utente
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 20
            }
            color: parametri_generali.coloreBordo
            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

            font.italic: false
            font.letterSpacing: 0
            font.pixelSize: 70
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop

        }


        Rectangle   {
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 426-parametri_generali.larghezza_barra
            width: 436
            height: 581
            radius: 20
            border.color: parametri_generali.coloreBordo
            border.width: 2



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

                loops: MediaPlayer.Infinite
                source: "file://"+PATH+"/video/"+"placeholver_video.mp4"


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
