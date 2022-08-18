

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

    Barra_superiore{}

    Item {
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        Rectangle
        {

            color:parametri_generali.coloreSfondo

            anchors {
//                left: parent.left
//                right: parent.right
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            width: 1000
            height: 500
//            border.color: "blue"
            clip: true
            GridView {
                Layout.alignment: Qt.AlignCenter
                snapMode: GridView.SnapToRow
                cellWidth: 250; cellHeight: cellWidth
//                orientation: ListView.Horizontal
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


                model: _utenti //ModelloUtenteTml{}


                delegate: IconaLogin{}

            }
        }
    }

}
