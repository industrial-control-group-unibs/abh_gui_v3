

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


    FrecceSotto
    {
        id: swipe
        swipe_visible: false

        onPressSx:{
           pageLoader.source="PaginaMondi.qml"
        }

        dx_visible: false

        up_visible: false
        down_visible: false
    }
    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: swipe.top
        anchors.top: barra.bottom


        QuattroImmagini
        {
            onPress11: {
                pageLoader.source = link11
            }
            onPress12: {
                pageLoader.source = link12
            }
            onPress21: {
                pageLoader.source = link21
            }
            onPress22: {
                pageLoader.source = link22
            }

            immagine11: "workout.png"
            testo11: qsTr("ALLENAMENTO\n GUIDATO")
            link11: "SceltaWorkout.qml"
            immagine12: "allenamento_singolo.png"
            testo12: qsTr("ALLENAMENTO\n LIBERO")
            link12: "SceltaGruppo.qml"
            immagine21: "sfida.png"
            testo21: qsTr("ALLENAMENTO\n PERSONALIZZATO")
            link21: "AllenamentoPersonalizzato.qml"
            immagine22: "statistiche.png"
            testo22: qsTr("STATISTICHE")
            link22: "SceltaStatisticheWorkout.qml"
        }

    }


}
