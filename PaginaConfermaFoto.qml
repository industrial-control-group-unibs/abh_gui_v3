

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
    Barra_superiore{}


    SysCall
    {
        id: chiamata_sistema
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



    Item
    {
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height*0.3

        Testo
        {
            text: "CONFERMI?"
            font.pixelSize: 30
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 5

            }
        }
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
