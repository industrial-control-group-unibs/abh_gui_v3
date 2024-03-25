

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




    Barra_superiore{id: barra}
    color: parametri_generali.coloreSfondo


    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
//        anchors.bottomMargin: barra.height
        anchors.top: barra.bottom


        QuattroImmagini
        {

            onPress11: {
                pageLoader.source = link11
            }
            onPress12: {
                disciplina.nome="YOGA"
                console.log("disciplina",disciplina.nome)
                pageLoader.source = link12
            }
            onPress21: {
                disciplina.nome="PILATES"
                pageLoader.source = link21
            }
            onPress22: {
                disciplina.nome="MEDITAZIONE"
                pageLoader.source = link22
            }

            immagine11: "allenamento.png"
            testo11: qsTr("ALLENAMENTO")
            link11: "PaginaAllenamento.qml"

            immagine12: "yoga.png"
            testo12: qsTr("YOGA")
            link12: "SceltaYoga.qml"


            immagine21: "pilates.png"
            testo21: qsTr("PILATES")
            link21:  "SceltaYoga.qml"

            immagine22: "meditazione.png"
            testo22: qsTr("MEDITAZIONE")
            link22:  "SceltaYoga.qml"
        }

    }


}
