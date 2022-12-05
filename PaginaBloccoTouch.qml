

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0

import SysCall 1.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    SysCall
    {
        id: chiamata_sistema
    }

    Barra_superiore{

    }

    Component.onCompleted: {
        chiamata_sistema.string="xinput disable 11"
        chiamata_sistema.call()
    }
    Component.onDestruction:
    {
        chiamata_sistema.string="xinput enable 11"
        chiamata_sistema.call()
    }

    Timer{
        id: conto_alla_rovescia
        interval: 500
        repeat: true
        running: true
        property int position: 0
        property int duration: 60000
        onTriggered: {
            if (position<duration)
            {
                position+=interval
            }
            else
            {
                pageLoader.source=pageLoader.last_source
            }
        }
    }

    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true


        Titolo
        {
            text:  "BLOCCO TOUCHSCREEN"
            height: parent.height*0.1
            fontSize: 40
        }



        CircularTimer {
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            width: 0.5*parent.width
            height: width
            tacche: 120
            value: 1-conto_alla_rovescia.position/conto_alla_rovescia.duration
            tempo: (conto_alla_rovescia.duration-conto_alla_rovescia.position) //timerino.remaining_time
            colore: (tempo<5000)?"red":parametri_generali.coloreBordo
        }



    }
}
