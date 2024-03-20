

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
    }

    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: swipe.top
        anchors.top: barra.bottom


        QuattroImmagini
        {
            immagine11: "workout.png"
            testo11: qsTr("ALLENAMENTO\n GUIDATO")
            link11: "SceltaWorkout.qml"
            immagine21: "allenamento_singolo.png"
            testo21: qsTr("ALLENAMENTO\n LIBERO")
            link21: "SceltaGruppo.qml"
            immagine12: "sfida.png"
            testo12: qsTr("ALLENAMENTO\n PERSONALIZZATO")
            link12: "AllenamentoPersonalizzato.qml"
            immagine22: "statistiche.png"
            testo22: qsTr("STATISTICHE")
            link22: "SceltaStatisticheWorkout.qml"
        }

    }


}
