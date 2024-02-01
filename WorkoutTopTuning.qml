import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.12

import UdpVideoStream 1.0

import BinarySender 1.0
import Charts 1.0


Item
{
    Component.onCompleted:  timer_tempo.start()
    Component.onDestruction: timer_tempo.stop()

    implicitWidth: 1080*.5
    implicitHeight: 1920*.5


    id: component

    property bool swipe: true
    property real pos_velocity_th: fb_udp.data[8]
    property real neg_velocity_th: fb_udp.data[9]
    property real time_0_100_fw: fb_udp.data[10]
    property real time_0_100_bw: fb_udp.data[11]
    property real vel_end_phase: fb_udp.data[12]
    property real perc_end_phase: fb_udp.data[13]
    property real vel_end_phase_ret: fb_udp.data[14]
    property real perc_end_phas_ret: fb_udp.data[15]
    property real save_parameters: 0

    property var exerciseParameters: [pos_velocity_th,neg_velocity_th,time_0_100_fw,time_0_100_bw,vel_end_phase,perc_end_phase,vel_end_phase_ret,perc_end_phas_ret,save_parameters]


    BinarySender {
        id: parameters_udp
        // @disable-check M16
        port: "21026"
        // @disable-check M16
        host: "localhost"
        // @disable-check M16
        data: component.exerciseParameters

    }



    state: "workout"
    states: [
        State {
            name: "utente"
            PropertyChanges { target: rect_utente; visible: true }

        },
        State {
            name: "stats"
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


    Rectangle
    {
        height: rect_utente.height
        x: rect_utente.x
        y: rect_utente.y
        width: rect_utente.width
        id: rect_grafici
        color: "transparent"
        radius: rect_utente.radius
        border.width: rect_utente.border.width
        border.color: parametri_generali.coloreBordo
        visible: !rect_utente.visible



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
        height: rect_utente.height
        x: 0.25*component.width-0.5*width
        y: rect_utente.y
        width: rect_utente.width
        id: rect_parametri
        color: "transparent"
        radius: rect_utente.radius
        border.width: rect_utente.border.width
        border.color: parametri_generali.coloreBordo
        visible: true

        IconaBottone
        {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: width*0.1
            width: 100
            colore: parametri_generali.coloreUtente
            colore2: "transparent"
            onPressed: {
                component.exerciseParameters[8]=1
                parameters_udp.data=component.exerciseParameters
                component.exerciseParameters[8]=0
            }
            Testo
            {
                text: qsTr("SALVA")
                color: parametri_generali.coloreBordo
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width*0.8
                height: width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
            }
        }
        Testo
        {
            anchors.bottom: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height*0.1
            font.pixelSize: 40
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignBottom
            text: qsTr("SETTAGGIO PARAMETRI")
            color: parametri_generali.coloreUtente
        }

        Column
        {
            anchors.fill: parent
            spacing: parent.height*0.02

            VariazioneParametri
            {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
                value: component.pos_velocity_th
                step: 0.1
                name: qsTr("POSITIVE VELOCITY THRESHOLD")
                onValueChanged:
                {
                    component.exerciseParameters[0]=value
                    parameters_udp.data=component.exerciseParameters
                }
            }
            VariazioneParametri
            {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
                value: component.neg_velocity_th
                step: 0.1
                name: qsTr("NEGATIVE VELOCITY THRESHOLD")
                onValueChanged:
                {
                    component.exerciseParameters[1]=value
                    parameters_udp.data=component.exerciseParameters
                }
            }
            VariazioneParametri
            {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
                value: component.time_0_100_fw
                step: 0.1
                name: qsTr("TIME FROM 0 TO 100 FORWARD")
                onValueChanged:
                {
                    component.exerciseParameters[2]=value
                    parameters_udp.data=component.exerciseParameters
                }
            }
            VariazioneParametri
            {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
                value: component.time_0_100_bw
                step: 0.1
                name: qsTr("TIME FROM 0 TO 100 BACKWARD")
                onValueChanged:
                {
                    component.exerciseParameters[3]=value
                    parameters_udp.data=component.exerciseParameters
                }
            }
            VariazioneParametri
            {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
                value: component.vel_end_phase
                step: 1
                name: qsTr("VELOCITY END PHASE")
                onValueChanged:
                {
                    component.exerciseParameters[4]=value
                    parameters_udp.data=component.exerciseParameters
                }
            }
            VariazioneParametri
            {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
                value: component.perc_end_phase
                step: 1
                name: qsTr("PERCENTAGE END PHASE")
                onValueChanged:
                {
                    component.exerciseParameters[5]=value
                    parameters_udp.data=component.exerciseParameters
                }
            }
            VariazioneParametri
            {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
                value: component.vel_end_phase_ret
                step: 2
                name: qsTr("VELOCITY END PHASE RETURN")
                onValueChanged:
                {
                    component.exerciseParameters[6]=value
                    parameters_udp.data=component.exerciseParameters
                }
            }
            VariazioneParametri
            {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
                value: component.perc_end_phas_ret
                step: 1
                name: qsTr("PERCENTAGE END PHASE RETURN")
                onValueChanged:
                {
                    component.exerciseParameters[7]=value
                    parameters_udp.data=component.exerciseParameters
                }
            }
        }
    }

    Rectangle   {
        height: 0.7*component.height
        width: 9/16*height
        x: 0.75*component.width-0.5*width
        y: 0.5*(component.height-height)
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
            component.state="utente"
        }
        visible: component.swipe
        state: "sx"
    }

}






