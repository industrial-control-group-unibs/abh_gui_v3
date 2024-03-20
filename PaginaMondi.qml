

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
    BottoniSwipe2{
        id: swipe
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.bottom+30
        bordo: parametri_generali.coloreUtente
        state: "dx"
        onPressLeft: pageLoader.source="PaginaAllenamento.qml"
    }

    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: swipe.top
        anchors.top: barra.bottom


        QuattroImmagini
        {
            immagine11: "meditazione.png"
            testo11: qsTr("MEDITAZIONE")
            link11: "SceltaWorkout.qml"

            immagine21: "yoga.png"
            testo21: qsTr("ALTRA SCRITTA")
            link21: "SceltaGruppo.qml"


            immagine12: "yoga.png"
            testo12: qsTr("YOGA")
            link12: "AllenamentoPersonalizzato.qml"

            immagine22: "yoga.png"
            testo22: qsTr("ALTRA SCRITTA")
            link22: "SceltaStatisticheWorkout.qml"
        }

    }


}
