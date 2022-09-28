

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true


        Titolo
        {
            text: "IMPOSTAZIONI"
            height: parent.height
        }
    }

    QuattroImmagini
    {
        immagine11: "place_holder_4_3.png"
        testo11: "UTENTE\n"
        link11: "PaginaLogin.qml"
        immagine12: "place_holder_4_3.png"
        testo12: "CONNETIVITÀ\n"
        link12: "PaginaExit.qml"
        immagine21: "place_holder_4_3.png"
        testo21: "SCHERMO-AUDIO\n"
        link21: "TestPage.qml"
        immagine22: "place_holder_4_3.png"
        testo22: "LOG OUT\n"
        link22: "PaginaLogin.qml"
    }

//    Rectangle{
//        anchors.fill: parent
//        anchors.topMargin: parametri_generali.larghezza_barra
//        color:parametri_generali.coloreSfondo
//        clip: true

//        Text {
//            text: "IMPOSTAZIONI"
//            id: testo_utente
//            anchors
//            {
//                horizontalCenter: parent.horizontalCenter
//                top: parent.top
//                topMargin: 20
//            }
//            color: parametri_generali.coloreBordo
//            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

//            font.italic: false
//            font.letterSpacing: 0
//            font.pixelSize: 70
//            font.weight: Font.Normal
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignTop

//        }


//    }
}
