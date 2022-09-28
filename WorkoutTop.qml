import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.12

import UdpVideoStream 1.0


Item
{
    Component.onCompleted: {
        timer_tempo.start()
        //            timer_tut.start()
    }

    implicitWidth: 1080
    implicitHeight: 1920*.5


    id: component
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
        },
        State {
            name: "uguali"
            PropertyChanges { target: rect_utente; height: 0.8*component.height   }
            PropertyChanges { target: rect_utente; y: 0.5*(component.height-height)   }
            PropertyChanges { target: rect_utente; x: 0.75*component.width-0.5*width }
            PropertyChanges { target: rect_video_centrale; height: 0.8*component.height   }
            PropertyChanges { target: rect_video_centrale;  y: 0.5*(component.height-height)   }
            PropertyChanges { target: rect_video_centrale; x: 0.25*component.width-0.5*width }
            PropertyChanges { target: rect_video_centrale; visible: true }
        },
        State {
            name: "stats"
            PropertyChanges { target: rect_utente; height: 0.8*component.height   }
            PropertyChanges { target: rect_utente; y: 0.5*(component.height-height)   }
            PropertyChanges { target: rect_utente; x: 0.25*component.width-0.5*width  }
            PropertyChanges { target: rect_video_centrale; height: 0.8*component.height   }
            PropertyChanges { target: rect_video_centrale; x: 0.25*component.width-0.5*width }
            PropertyChanges { target: rect_video_centrale; visible: false }
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
        height: 0.8*parent.height
        width: 9/16*height
        x: 0.5*(parent.width-width)
        y: 0.5*(parent.height-height)
        radius: 20
        color: "transparent"
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
                mp_workout.play()
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
            loops: MediaPlayer.Infinite
            //                loops: MediaPlayer.Infinite
            source: "file://"+PATH+"/video_workout_esercizi/"+selected_exercise.video_workout
            onStopped: tasto_video.state= "play"
            onPositionChanged:
            {
                if (duration>0)
                {
                    if (duration-position<1000)
                    {
                        seek(0)
                        play()
                    }
                }
            }
        }

        VideoOutput {
            id: video_workout

            source: mp_workout
            anchors.fill: parent
            z:0
            visible: false
        }


        PlayPauseButton
        {
            id: tasto_video
            width: 20
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: video_workout.bottom
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
    }


    Rectangle
    {
        anchors.fill: rect_utente
        color: "transparent"
        radius: rect_utente.radius
        border.color: "transparent"//rect_utente.border.color
        border.width: rect_utente.border.width
//        border.color: parametri_generali.coloreBordo
//        border.width: 2
        visible: !rect_video_centrale.visible

        CircularIndicator
        {


            width: parent.width

            trackWidth: 2
            progressWidth: 3
            handleWidth: 0//13
            handleHeight: handleWidth
            handleRadius: handleWidth*.5
            handleVerticalOffset: 0

            startAngle: 0
            endAngle: 360
            rotation: 0
            minValue: 0//-100
            maxValue: 100
            snap: true
            stepSize: 1
            value: (fb_udp.data[2])

            handleColor: "#4E4F50"
            trackColor: "#4E4F50"
            progressColor: value>selected_exercise.max_pos_speed?"red": value<selected_exercise.max_neg_speed?"red": "#D4C9BD"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
//            anchors.verticalCenterOffset: -parent.height*0.25

            Text {
                text:Number(parent.value).toFixed()
                anchors
                {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
                color: parametri_generali.coloreBordo
                wrapMode: TextEdit.WordWrap
                font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                font.italic: false
                font.letterSpacing: 0
                font.pixelSize: 30
                font.weight: Font.Normal
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop

            }
            Testo
            {
                text: "SPEED"
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.bottom
                    topMargin: 5

                }
            }

        }

    }

    Rectangle   {
        height: 0.3*parent.height
        width: 9/16*height
        x: 890/1080*parent.width-0.5*width
        y: 0.1*parent.height
        id: rect_utente
        visible: true

        color: "transparent"
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
            z:0
            visible: false
        }
    }


}






