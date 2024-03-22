import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.12

import UdpVideoStream 1.0

import Charts 1.0
Item
{
    property real duration: mp_workout.duration
    property real position: mp_workout.position

    implicitWidth: 1080*.5
    implicitHeight: 1920*.5


    id: component

    property bool swipe: false

    state: "workout"
    states: [
        State {
            name: "workout"
            PropertyChanges { target: rect_video_centrale;  height: 0.95*component.height   }
            PropertyChanges { target: rect_video_centrale;  y: 0.5*(component.height-height)   }
            PropertyChanges { target: rect_video_centrale;  x: 0.5*(component.width-video_workout.width) }

            PropertyChanges { target: rect_utente; height: 0.3*component.height           }
            PropertyChanges { target: rect_utente; x: rect_video_centrale.x+rect_video_centrale.width-width  }
            PropertyChanges { target: rect_utente; y: rect_video_centrale.y  }
            PropertyChanges { target: rect_video_centrale; visible: true }
            PropertyChanges { target: rect_utente; visible: true }

            PropertyChanges { target: rect_video_centrale;  z:1 }
            PropertyChanges { target: rect_utente;          z:5 }
        },
        State {
            name: "utente"
            PropertyChanges { target: rect_utente; height: 0.95*component.height   }
            PropertyChanges { target: rect_utente; y: 0.5*(component.height-height)   }
            PropertyChanges { target: rect_utente; x: 0.5*(component.width-width) }
            PropertyChanges { target: rect_video_centrale;  height: 0.3*component.height           }
            PropertyChanges { target: rect_video_centrale; x: rect_utente.x+rect_utente.width-width  }
            PropertyChanges { target: rect_video_centrale; y: rect_utente.y  }
            PropertyChanges { target: rect_video_centrale; visible: true }
            PropertyChanges { target: rect_utente; visible: true }

            PropertyChanges { target: rect_video_centrale;  z:5 }
            PropertyChanges { target: rect_utente;          z:1 }
        },
        State {
            name: "uguali"
            PropertyChanges { target: rect_utente; height: 0.7*component.height   }
            PropertyChanges { target: rect_utente; y: 0.5*(component.height-height)   }
            PropertyChanges { target: rect_utente; x: 0.75*component.width-0.5*width }
            PropertyChanges { target: rect_video_centrale; height: 0.7*component.height   }
            PropertyChanges { target: rect_video_centrale;  y: 0.5*(component.height-height)   }
            PropertyChanges { target: rect_video_centrale; x: 0.25*component.width-0.5*width }
            PropertyChanges { target: rect_video_centrale; visible: true }
            PropertyChanges { target: rect_utente; visible: true }
        },
        State {
            name: "stats"
            PropertyChanges { target: rect_utente; height: 0.7*component.height   }
            PropertyChanges { target: rect_utente; y: 0.5*(component.height-height)   }
            PropertyChanges { target: rect_utente; x: 0.25*component.width-0.5*width  }
            PropertyChanges { target: rect_video_centrale; height: 0.7*component.height   }
            PropertyChanges { target: rect_video_centrale; x: 0.75*component.width-0.5*width }
            PropertyChanges { target: rect_video_centrale; y: 0.5*(component.height-height)   }
            PropertyChanges { target: rect_video_centrale; visible: false }
            PropertyChanges { target: rect_utente; visible: true }
        }
    ]






    anchors
    {
        left: parent.left
        right: parent.right
        top: parent.top
    }
    height: parent.height*0.7


    PlayPauseButton
    {
        visible: true
        id: tasto_video
        width: 100
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            top: parent.bottom
            topMargin: 5
        }
        z:2
        state: "pause"

        onPressPause: mp_workout.pause()
        onPressPlay:
        {
            mp_workout.play()
        }
    }

    Rectangle   {
        height: 0.8*parent.height
        width: 9/16*height
        x: 0.5*(parent.width-width)
        y: 0.5*(parent.height-height)
        radius: 20
        color: "black"
        border.color: parametri_generali.coloreBordo
        border.width: 2
        id: rect_video_centrale

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                if (component.state==="workout")
                    component.state="utente"
                else if (component.state==="utente")
                    component.state="uguali"
                else if (component.state==="uguali")
                    component.state="workout"
                //mp_workout.play()
            }

        }

        Rectangle
        {
            id: video_mask
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
            anchors.fill:video_mask
            source: video_workout
            maskSource: video_mask
        }


        MediaPlayer {
            id: mp_workout
            autoPlay: true
            autoLoad: true
            //loops: MediaPlayer.Infinite
            source: "file://"+PATH+"/video_workout_esercizi/"+_esercizi.getVideoWorkout(disciplina.esercizio)
            onStopped: tasto_video.state= "play"

        }

        VideoOutput {
            id: video_workout

            source: mp_workout
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectFit
            z:0
            visible: false
        }



    }



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

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                if (component.state==="workout")
                    component.state="utente"
                else if (component.state==="utente")
                    component.state="uguali"
                else if (component.state==="uguali")
                    component.state="workout"
                mp_workout.play()
            }

        }

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






