

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12


import QtQuick.Layouts 1.1
import QtQml 2.0

import SysCall 1.0
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


    SysCall
    {
        id: chiamata_sistema
    }
    FrecceSxDx
    {
        onPressSx: pageLoader.source=  "DefinizioneUtente1.qml"
        onPressDx: pageLoader.source=  "PaginaWorkout.qml"
        z:5
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

        Image {

            fillMode: Image.PreserveAspectCrop
            visible: false
            mipmap: true
            anchors.fill:parent
            source: "file://"+PATH+"/utenti/"+impostazioni_utente.foto
            id: allenamento_icona
        }


        OpacityMask {
            anchors.fill:video2_mask
            source: allenamento_icona
            maskSource: video2_mask
        }


    }




    Item   {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rect_utente.bottom
        anchors.topMargin: 100*parent.width/1080
        width: 436*parent.width/1080
        height: 581*parent.width/1080




        SiNo
        {
            onPressNo:
            {
                chiamata_sistema.string="rm '"+PATH+"/utenti/"+impostazioni_utente.foto+"'"
                chiamata_sistema.call()
                pageLoader.source="PaginaScattaFoto.qml"

            }
            onPressYes: pageLoader.source="DefinizioneUtente1.qml"
        }


    }
}
