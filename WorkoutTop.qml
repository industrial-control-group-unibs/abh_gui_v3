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
            PropertyChanges { target: rect_utente; visible: false }
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
            fillMode: VideoOutput.PreserveAspectFit
            z:0
            visible: false
        }


        PlayPauseButton
        {
            visible: false
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
        height: 0.7*component.height
        x: 0.75*component.width-0.5*width
        y: 0.5*(component.height-height)
        width: 9/16*height
        id: rect_grafici
        color: "transparent"
        radius: rect_utente.radius
        border.width: rect_video_centrale.border.width
        border.color: parametri_generali.coloreBordo
        visible: !rect_video_centrale.visible

        Testo
        {
            anchors.bottom: rect_grafici.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height*0.1
            font.pixelSize: 40
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignBottom
            text: chrt_areachart.show_motor? qsTr("VELOCITA' ISTANTANEA"): chrt_areachart.show_current? qsTr("POWER") :qsTr("VISIONE")
            onTextChanged: chrt_areachart.clear()
            color: parametri_generali.coloreUtente
        }
        AreaChart{
            id: chrt_areachart
            //            anchors.fill: parent
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            property bool show_motor: true
            property bool show_current: false
            width: parent.width
            height: parent.height-2*parent.radius

            // @disable-check M16
            max: 100
            // @disable-check M16
            color:parametri_generali.coloreUtente
            // @disable-check M16
            chdata: show_motor? (fb_udp.data[2]) : show_current? 2.0*(fb_udp.data[7]-50.0): 2.0*(fb_udp.data[6]-50.0)

            MouseArea{
                anchors.fill: parent
                onPressed:
                {
                    if (parent.show_motor && !parent.show_current)
                    {
                        parent.show_motor=false
                    }
                    else if (!parent.show_motor && !parent.show_current)
                    {
                        parent.show_current=true
                    }
                    else
                    {
                        parent.show_current=false
                        parent.show_motor=true
                    }

                }
            }

            RigaGrafico
            {
                value: 1.0
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.9
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.8
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.7
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.6
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.5
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.4
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.3
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.2
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.1
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.0
                motore: chrt_areachart.show_motor
                larghezza: chrt_areachart.width
                altezza: chrt_areachart.height
                anchors.fill: parent
            }

//            Item {
//                id: riga
//                property real value: 0.8
//                property real label: riga.motore? 100.0*riga.value:100.0*(-1+2*riga.value)
//                property bool motore: chrt_areachart.show_motor
//                property real larghezza: chrt_areachart.width
//                property real altezza: chrt_areachart.height
//                anchors.fill: parent
//                Testo
//                {
//                    anchors.top: parent.top
//                    anchors.leftMargin: parent.width*0.1
//                    anchors.topMargin: parent.height*(1-riga.value)-height*0.5
//                    anchors.right: parent.left
//                    anchors.rightMargin: parent.width*0.02
//                    height: parent.height*0.1
//                    width: parent.width*0.1
//                    font.pixelSize: 20
//                    horizontalAlignment: Text.AlignRight
//                    verticalAlignment: Text.AlignVCenter
//                    text: riga.label.toFixed(0).toString()
//                    color: parametri_generali.coloreUtente
//                }

//                Shape {
//                    anchors.fill: parent
//                    ShapePath {
//                        strokeColor: parametri_generali.coloreBordo
//                        strokeWidth: 2.0
//                        startX: 0
//                        startY: riga.altezza*(1.0-riga.value)
//                        PathLine { x: riga.larghezza; y: riga.altezza*(1.0-riga.value) }
//                    }
//                }
//            }


            Shape {
                anchors.fill: parent
                id: limiti
                property real up: chrt_areachart.height*0.5*(1-(selected_exercise.max_pos_speed/chrt_areachart.max))
                property real down: chrt_areachart.height*0.5*(1-(selected_exercise.max_neg_speed/chrt_areachart.max))

                Testo
                {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width*0.1
                    anchors.topMargin: limiti.up-height
                    anchors.right: parent.right
                    height: parent.height*0.1
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    text: qsTr("LIMITE SUPERIORE")
                    color: parametri_generali.coloreUtente
                    visible: chrt_areachart.show_motor
                }

                Testo
                {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width*0.1
                    anchors.topMargin: limiti.down
                    anchors.right: parent.right
                    height: parent.height*0.1
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    text: qsTr("LIMITE INFERIORE")
                    color: parametri_generali.coloreUtente
                    visible: chrt_areachart.show_motor
                }



                ShapePath {
                    strokeColor: chrt_areachart.show_motor? (chrt_areachart.chdata>selected_exercise.max_pos_speed?"red": parametri_generali.coloreBordo) : "transparent"
                    strokeWidth: 2
                    strokeStyle: ShapePath.DashLine
                    //startY: parent.width*0.5*(1.0+selected_exercise.max_pos_speed/max)

                    startX: 0
                    startY: limiti.up
                    PathLine { x: chrt_areachart.width; y: limiti.up }
                }
                ShapePath {
                    strokeColor: chrt_areachart.show_motor? (chrt_areachart.chdata<selected_exercise.max_neg_speed?"red": parametri_generali.coloreBordo) : "transparent"
                    strokeWidth: 2
                    strokeStyle: ShapePath.DashLine
                    //startY: parent.width*0.5*(1.0+selected_exercise.max_pos_speed/max)

                    startX: 0
                    startY: limiti.down
                    PathLine { x: chrt_areachart.width; y: limiti.down }
                }


                ShapePath {
                    strokeColor: parametri_generali.coloreBordo
                    strokeWidth: 1
                    startX:  chrt_areachart.width*.5
                    startY: 0
                    PathLine { x: chrt_areachart.width*.5; y: chrt_areachart.height }
                }

                ShapePath {
                    strokeColor: parametri_generali.coloreBordo
                    strokeWidth: 1
                    startX:  chrt_areachart.width*.75
                    startY: 0
                    PathLine { x: chrt_areachart.width*.75; y: chrt_areachart.height }
                }

                ShapePath {
                    strokeColor: parametri_generali.coloreBordo
                    strokeWidth: 1
                    startX:  chrt_areachart.width*.25
                    startY: 0
                    PathLine { x: chrt_areachart.width*.25; y: chrt_areachart.height }
                }
            }
        }


    }


    Rectangle
    {
        height: 0.7*component.height
        x: 0.25*component.width-0.5*width
        y: 0.5*(component.height-height)
        width: 9/16*height
        id: rect_grafici2
        color: "transparent"
        radius: rect_utente.radius
        border.width: rect_video_centrale.border.width
        border.color: parametri_generali.coloreBordo
        visible: !rect_video_centrale.visible

        Testo
        {


            anchors.bottom: rect_grafici2.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height*0.1
            font.pixelSize: 40
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignBottom
            text: chrt_areachart2.show_motor? qsTr("VELOCITA' ISTANTANEA"): chrt_areachart2.show_current? qsTr("POWER") :qsTr("VISIONE")
            onTextChanged: chrt_areachart2.clear()
            color: parametri_generali.coloreUtente
        }
        AreaChart{
            id: chrt_areachart2
            //            anchors.fill: parent
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            property bool show_motor: true
            property bool show_current: false
            width: parent.width
            height: parent.height-2*parent.radius

            // @disable-check M16
            max: 100
            // @disable-check M16
            color:parametri_generali.coloreUtente
            // @disable-check M16
            chdata: show_motor? (fb_udp.data[2]) : show_current? 2.0*(fb_udp.data[7]-50.0): 2.0*(fb_udp.data[6]-50.0)

            MouseArea{
                anchors.fill: parent
                onPressed:
                {
                    if (parent.show_motor && !parent.show_current)
                    {
                        parent.show_motor=false
                    }
                    else if (!parent.show_motor && !parent.show_current)
                    {
                        parent.show_current=true
                    }
                    else
                    {
                        parent.show_current=false
                        parent.show_motor=true
                    }

                }
            }

            RigaGrafico
            {
                value: 1.0
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.9
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.8
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.7
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.6
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.5
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.4
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.3
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.2
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.1
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }
            RigaGrafico
            {
                value: 0.0
                motore: chrt_areachart2.show_motor
                larghezza: chrt_areachart2.width
                altezza: chrt_areachart2.height
                anchors.fill: parent
            }

//            Item {
//                id: riga
//                property real value: 0.8
//                property real label: riga.motore? 100.0*riga.value:100.0*(-1+2*riga.value)
//                property bool motore: chrt_areachart.show_motor
//                property real larghezza: chrt_areachart.width
//                property real altezza: chrt_areachart.height
//                anchors.fill: parent
//                Testo
//                {
//                    anchors.top: parent.top
//                    anchors.leftMargin: parent.width*0.1
//                    anchors.topMargin: parent.height*(1-riga.value)-height*0.5
//                    anchors.right: parent.left
//                    anchors.rightMargin: parent.width*0.02
//                    height: parent.height*0.1
//                    width: parent.width*0.1
//                    font.pixelSize: 20
//                    horizontalAlignment: Text.AlignRight
//                    verticalAlignment: Text.AlignVCenter
//                    text: riga.label.toFixed(0).toString()
//                    color: parametri_generali.coloreUtente
//                }

//                Shape {
//                    anchors.fill: parent
//                    ShapePath {
//                        strokeColor: parametri_generali.coloreBordo
//                        strokeWidth: 2.0
//                        startX: 0
//                        startY: riga.altezza*(1.0-riga.value)
//                        PathLine { x: riga.larghezza; y: riga.altezza*(1.0-riga.value) }
//                    }
//                }
//            }


            Shape {
                anchors.fill: parent
                id: limiti2
                property real up: chrt_areachart2.height*0.5*(1-(selected_exercise.max_pos_speed/chrt_areachart2.max))
                property real down: chrt_areachart2.height*0.5*(1-(selected_exercise.max_neg_speed/chrt_areachart2.max))

                Testo
                {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width*0.1
                    anchors.topMargin: limiti2.up-height
                    anchors.right: parent.right
                    height: parent.height*0.1
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    text: qsTr("LIMITE SUPERIORE")
                    color: parametri_generali.coloreUtente
                    visible: chrt_areachart2.show_motor
                }

                Testo
                {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width*0.1
                    anchors.topMargin: limiti2.down
                    anchors.right: parent.right
                    height: parent.height*0.1
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    text: qsTr("LIMITE INFERIORE")
                    color: parametri_generali.coloreUtente
                    visible: chrt_areachart2.show_motor
                }



                ShapePath {
                    strokeColor: chrt_areachart2.show_motor? (chrt_areachart2.chdata>selected_exercise.max_pos_speed?"red": parametri_generali.coloreBordo) : "transparent"
                    strokeWidth: 2
                    strokeStyle: ShapePath.DashLine
                    //startY: parent.width*0.5*(1.0+selected_exercise.max_pos_speed/max)

                    startX: 0
                    startY: limiti.up
                    PathLine { x: chrt_areachart2.width; y: limiti2.up }
                }
                ShapePath {
                    strokeColor: chrt_areachart2.show_motor? (chrt_areachart2.chdata<selected_exercise.max_neg_speed?"red": parametri_generali.coloreBordo) : "transparent"
                    strokeWidth: 2
                    strokeStyle: ShapePath.DashLine
                    //startY: parent.width*0.5*(1.0+selected_exercise.max_pos_speed/max)

                    startX: 0
                    startY: limiti.down
                    PathLine { x: chrt_areachart2.width; y: limiti2.down }
                }


                ShapePath {
                    strokeColor: parametri_generali.coloreBordo
                    strokeWidth: 1
                    startX:  chrt_areachart2.width*.5
                    startY: 0
                    PathLine { x: chrt_areachart2.width*.5; y: chrt_areachart2.height }
                }

                ShapePath {
                    strokeColor: parametri_generali.coloreBordo
                    strokeWidth: 1
                    startX:  chrt_areachart2.width*.75
                    startY: 0
                    PathLine { x: chrt_areachart2.width*.75; y: chrt_areachart2.height }
                }

                ShapePath {
                    strokeColor: parametri_generali.coloreBordo
                    strokeWidth: 1
                    startX:  chrt_areachart2.width*.25
                    startY: 0
                    PathLine { x: chrt_areachart2.width*.25; y: chrt_areachart2.height }
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



    BottoniSwipe{

        anchors
        {
            top: component.bottom
            topMargin: 0
            horizontalCenter: parent.horizontalCenter
        }
        z:5
        width: 0.4*component.width
        onPressRight:
        {
            component.state="stats"
        }
        onPressLeft:
        {
            component.state="workout"
        }
        visible: component.swipe
        state: "sx"
    }

}






