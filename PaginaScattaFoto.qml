

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtMultimedia 5.12

import QtQuick.Layouts 1.1
import QtQml 2.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    id: component
    property var locale: Qt.locale()
    property string dateTimeString: "Tue 2013-09-17 10:56:06"
    property date currentDate: new Date();
    Component.onCompleted: {

        dateTimeString = currentDate.toLocaleDateString( locale,"yyyyMMdd")+Qt.formatTime(new Date(),"hhmmss");
        selected_exercise.code="photo"
    }
    Component.onDestruction: startstop_udp.string="stop"
    Barra_superiore{}


    Item
    {
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height*0.3
        FrecceSxDx
        {
            id: freccia
            onPressSx:
            {
                pageLoader.source="DefinizioneUtente1.qml"
            }
            dx_visible: false
            z:5
        }
    }

    Rectangle   {
        width: 0.8*parent.width
        height: width
        anchors.top: parent.top
        anchors.topMargin: parametri_generali.larghezza_barra+30
        anchors.horizontalCenter: parent.horizontalCenter
        id: rect_utente
        visible: true

        color: "transparent"
        radius: width*0.5
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
            radius: width*0.5
            visible: false
            color: "white"
        }

        MouseArea
        {
            anchors.fill: parent
            onPressed:    conto_alla_rovescia.running=true

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


    Timer{
        id: conto_alla_rovescia
        interval: 500
        repeat: true
        running: false
        property int position: 0
        property int duration: 10000
        onTriggered: {
            if (position<duration)
            {
                position+=interval
            }
            else
            {
                udpStream.saveImage(PATH+"/../utenti/"+component.dateTimeString+".png")
                impostazioni_utente.foto=component.dateTimeString+".png"
                pageLoader.source="PaginaConfermaFoto.qml"
            }
        }

    }

    Item   {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rect_utente.bottom
        anchors.topMargin: 50*parent.width/1080
        width: parent.width
        height: 0.3*parent.height




        CircularTimer {
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            width: 0.3*parent.width
            height: width
            tacche: 120
            value: 1-conto_alla_rovescia.position/conto_alla_rovescia.duration
            tempo: (conto_alla_rovescia.duration-conto_alla_rovescia.position) //timerino.remaining_time
            colore: parametri_generali.coloreBordo
            Testo
            {
                text: conto_alla_rovescia.running? qsTr("PREPARATI"): qsTr("PREMI PER INIZIARE")
                font.pixelSize: 30
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.bottom
                    topMargin: 5

                }
            }

            MouseArea
            {
                anchors.fill: parent
                onPressed:
                {
                    conto_alla_rovescia.running=true
                    startstop_udp.string="start"
                }
            }


        }



    }
}
