import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Item {
    implicitHeight: 500
    implicitWidth:  500
    property string link: "PaginaLogin.qml"
    property string nome: "ALLENAMENTO"
    property string immagine: "place_holder_4_3.png"

    Layout.alignment: Qt.AlignCenter
//    Layout.preferredWidth: 500
//    Layout.preferredHeight: 500

    Column
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent";
            width: 447///500*parent.width
            height: 347///500*parent.width
            border.color: parametri_generali.coloreBordo
            border.width: 4
            radius: 20

            Image {

                layer.enabled: true
                fillMode: Image.PreserveAspectCrop
                visible: false
                mipmap: true
                anchors.fill:parent
                source: "file://"+PATH+"/images/"+immagine
                id: allenamento_icona
            }

            Rectangle {
                id: allenamento_mask
                anchors
                {
                    fill: parent
                    topMargin: parent.border.width
                    bottomMargin: parent.border.width
                    leftMargin: parent.border.width
                    rightMargin: parent.border.width
                }
                visible: false
                color: "blue"
                radius: parent.radius-parent.border.width
            }
            OpacityMask {
                anchors.fill: allenamento_mask
                source: allenamento_icona
                maskSource: allenamento_mask
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: pageLoader.source=  link
            }

        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            //                    anchors.verticalCenter: parent.verticalCenter
            layer.enabled:true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 4
                radius: 4
                samples: 17
                color: "#40000000"
            }
            color: parametri_generali.coloreTestoChiaro
            wrapMode: TextEdit.WordWrap
            text:nome
            font.family: "MS Shell Dlg 2"
            font.italic: false
            font.letterSpacing: 0
            font.pixelSize: 33
            font.weight: Font.DemiBold
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
        }
    }

}
