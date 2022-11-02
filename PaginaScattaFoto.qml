

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

    Component.onCompleted: {
        print(Date.fromLocaleString(locale, dateTimeString, "ddd yyyy-MM-dd hh:mm:ss"));
    }
    Barra_superiore{}


    Item {
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: rect_utente.bottom
        }


        FrecceSxDx
        {


            onPressSx: pageLoader.source=  "DefinizioneUtente1.qml"
            dx_visible: false
            z:5
        }
    }

    Rectangle   {
        width: 0.9*parent.width
        height: width
        anchors.verticalCenter: parent.verticalCenter
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
        running: true
        property int position: 0
        property int duration: 10000
        onTriggered: {
            if (position<duration)
            {
                position+=interval
            }
            else
            {
                udpStream.saveImage(PATH+"/utenti/"+component.dateTimeString+".png")
                impostazioni_utente.foto=component.dateTimeString+".png"
                pageLoader.source="PaginaConfermaFoto.qml"
            }
        }
    }

    Item   {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rect_utente.bottom
        anchors.topMargin: 100*parent.width/1080
        width: 436*parent.width/1080
        height: 581*parent.width/1080




        CircularTimer {
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            width: parent.width
            height: width
            tacche: 120
            value: 1-conto_alla_rovescia.position/conto_alla_rovescia.duration
            tempo: (conto_alla_rovescia.duration-conto_alla_rovescia.position) //timerino.remaining_time
            colore: parametri_generali.coloreBordo


        }
        Testo
        {
            text: "PREPARATI"
            font.pixelSize: 30
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5

            }
        }


    }
}
