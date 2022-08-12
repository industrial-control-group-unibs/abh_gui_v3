

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
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            height: 300

            GridView {
                Layout.alignment: Qt.AlignCenter
                snapMode: GridView.SnapToRow
                cellWidth: 250; cellHeight: cellWidth
                anchors.fill: parent


                id: lista_login
                anchors {
                    fill: parent
                }


                model: ModelloUtenteTml{}


                delegate: IconaLogin{}

            }
        }
    }

}
