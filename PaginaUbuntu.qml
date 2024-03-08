

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    titolo: qsTr("VUOI USCIRE?")

    signal spegni
    onPressNo: pageLoader.source=  "PaginaLogin.qml"
    onPressYes: {
        spegni()

        Qt.callLater(Qt.quit)
    }

    Item {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parametri_generali.larghezza_barra

        IconaBottone
        {
            visible: impostazioni_utente.identifier!==""
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            colore: parametri_generali.coloreUtente
            colore2: "transparent"
            onPressed: {
                zona_allenamento.gruppo = "tutti"
                pageLoader.source = "SceltaEserciziSearchTuning.qml"
            }
            Testo
            {
                text: qsTr("TUNING")
                color: parametri_generali.coloreBordo
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width*0.8
                height: width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
            }
        }
    }

    onSpegni: {


//        chiamata_sistema.string="xrandr --output "+parametri_generali.monitor+" --off"
//        chiamata_sistema.call()
    }


    SysCall
    {
        id: chiamata_sistema
    }
}

