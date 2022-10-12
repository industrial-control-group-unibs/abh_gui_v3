

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0




PaginaVideoSingolo
{
    link_sx: pageLoader.last_source
    link_dx: "PaginaWorkout.qml"
    video_folder: "video_preparazione_esercizi"
    video_name: selected_exercise.video_preparati
    titolo: selected_exercise.name
    Component.onDestruction:
    {
        pageLoader.last_source="PaginaPreparati.qml"
    }
}



//Item {
//    anchors.fill: parent

//    implicitHeight: 1920/2
//    implicitWidth: 1080/2

//    Component.onDestruction:
//    {
//        pageLoader.last_source="PaginaPreparati.qml"
//    }

//    Barra_superiore{
//        Titolo
//        {
//            text: selected_exercise.name
//        }
//    }

//    Item
//    {
//        anchors
//        {
//            left: parent.left
//            right: parent.right
//            bottom: parent.bottom
//        }
//        height: parent.height*0.3
//        FrecceSxDx
//        {
//            onPressSx: pageLoader.source= pageLoader.last_source
//            onPressDx: pageLoader.source=  "PaginaWorkout.qml"
//        }
//    }

//    Rectangle{
//        anchors.fill: parent
//        anchors.topMargin: parametri_generali.larghezza_barra
//        color: "transparent"//parametri_generali.coloreSfondo
//        clip: true





//        Rectangle   {
//            color: "transparent"
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.top: parent.top
//            anchors.topMargin: 300*parent.width/1080
//            width: 436*parent.width/1080
//            height: 581*parent.width/1080
//            radius: 20
//            border.color: mp_esercizio_preparati.status===MediaPlayer.EndOfMedia? "transparent": parametri_generali.coloreBordo
////            border.color: parametri_generali.coloreBordo
//            border.width: 2



//            Rectangle
//            {
//                id: video_preparatorio_mask
//                anchors
//                {
//                    fill: parent
//                    topMargin: parent.border.width
//                    bottomMargin: parent.border.width
//                    leftMargin: parent.border.width
//                    rightMargin: parent.border.width
//                }
//                visible: false
//                color: "white"
//                radius: parent.radius-parent.border.width
//            }

//            OpacityMask {
//                anchors.fill:video_preparatorio_mask
//                source: video_preparatorio
//                maskSource: video_preparatorio_mask
//            }


//            MediaPlayer {
//                id: mp_esercizio_preparati
//                autoPlay: true
//                autoLoad: true

////                loops: MediaPlayer.Infinite
//                source: "file://"+PATH+"/video_preparazione_esercizi/"+selected_exercise.video_preparati
//                onStopped: tasto_video.state= "play"

//            }

//            VideoOutput {
//                id: video_preparatorio

//                source: mp_esercizio_preparati
//                anchors.fill: parent
//                z:0
//                visible: false
//            }

//            PlayPauseButton
//            {
//                id: tasto_video
//                width: 20
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



//            CircularTimer {
//                anchors
//                {
//                    horizontalCenter: parent.horizontalCenter
//                    top: video_preparatorio.bottom
//                    topMargin: 50
//                }

//                id: tempo
//                value: mp_esercizio_preparati.position/mp_esercizio_preparati.duration
//                tempo: (mp_esercizio_preparati.duration-mp_esercizio_preparati.position) //timerino.remaining_time
//            }

////            PlayButton
////            {
////                anchors
////                {
////                    horizontalCenter: parent.horizontalCenter
////                    top: video_preparatorio.bottom
////                    topMargin: 200
////                }
////                width: 100
////                MouseArea
////                {
////                    anchors.fill: parent
////                    onClicked: pageLoader.source=  "PaginaWorkout.qml"
////                }
////            }


//        }

//    }
//}
