

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
            text: "VUOI CANCELLARE L'UTENTE?"
        }

        SiNo
        {
            onPressNo: pageLoader.source=  "PaginaLogin.qml"
            onPressYes:
            {
                _utenti.removeUser(impostazioni_utente.nome)
                _utenti.readFile()
                pageLoader.source=  "PaginaLogin.qml"
            }
        }
    }


}
