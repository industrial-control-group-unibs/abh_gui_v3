

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Rectangle {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Component.onCompleted:
    {
        if (impostazioni_utente.nome ==="")
            pageLoader.source="PaginaLogin.qml"

        led_udp.data=[parametri_generali.coloreLed.r, parametri_generali.coloreLed.g, parametri_generali.coloreLed.b]
    }


    Component.onDestruction: console.log("closing PaginaAllenamento")


    Barra_superiore{id: barra}

    color: parametri_generali.coloreSfondo


    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: barra.bottom


        QuattroImmagini
        {
            immagine11: "allenamento.png"
            testo11: qsTr("Allenamento")
            link11: "PaginaAllenamento.qml"

            immagine12: "yoga.png"
            testo12: qsTr("YOGA")
            link12: "PaginaMondi.qml"


            immagine21: "pilates.png"
            testo21: qsTr("PILATES")
            link21: "PaginaMondi.qml"

            immagine22: "meditazione.png"
            testo22: qsTr("MEDITATIONE")
            link22: "PaginaMondi.qml"
        }

    }


}
