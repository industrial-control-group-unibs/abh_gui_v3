

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
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


    Barra_superiore{}

    QuattroImmagini
    {
        immagine11: "workout.jpg"
        testo11: qsTr("ALLENAMENTO\n GUIDATO")
        link11: "SceltaWorkout.qml"
        immagine21: "allenamento_singolo.jpg"
        testo21: qsTr("ALLENAMENTO\n LIBERO")
        link21: "SceltaGruppo.qml"
        immagine12: "sfida.jpg"
        testo12: qsTr("ALLENAMENTO\n PERSONALIZZATO")
        link12: "SceltaAllenamentoPersonalizzato.qml"
        immagine22: "statistiche.jpg"
        testo22: qsTr("STATISTICHE\n")
        link22: "SceltaStatisticheWorkout.qml"
    }

}
