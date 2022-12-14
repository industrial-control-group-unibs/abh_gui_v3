

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Rectangle {
    id: pagina_login
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2
    color:parametri_generali.coloreSfondo
    clip: true

    Component.onCompleted:
    {
        impostazioni_utente.nome=""
        impostazioni_utente.foto=""
        impostazioni_utente.identifier=""
        parametri_generali.login_page=true
    }
    Component.onDestruction:
    {
        timer_tempo.resetValue()
        timer_tut.resetValue()
    }
    Barra_superiore{}

    Item {
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        Rectangle
        {

            color:parametri_generali.coloreSfondo

            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            width: 1000
            height: 500
            clip: true
            GridView {
                Layout.alignment: Qt.AlignCenter
                snapMode: GridView.SnapToRow
                cellWidth: 250; cellHeight: cellWidth
                clip: true
                anchors {
                    left: parent.left
                    leftMargin: 0.5*(parent.width - Math.min(4,count)*cellWidth)
                    topMargin: count<4? 0.5*cellHeight:0
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                id: lista_login


                model: _utenti


                delegate: IconaLogin{}

            }
        }


    }

    IconaOff
    {
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 40
        }
        onPressed: pageLoader.source=  "PaginaExit.qml"
    }

}
