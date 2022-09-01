import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Item {
    implicitWidth:  500
    property string link: "PaginaLogin.qml"
    property string nome: "ALLENAMENTO"
    property string immagine: "place_holder_4_3.png"
    id: component
    height: 3/4*width
    Rectangle {
        color: "transparent";
        anchors.fill: parent

        border.color: parametri_generali.coloreBordo
        border.width: 4
        radius: 20

        Image {

            layer.enabled: true
            fillMode: Image.PreserveAspectCrop
            visible: false
            mipmap: true
            anchors.fill:parent
            source: "file://"+PATH+"/loghi/"+component.immagine
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
            onClicked: pageLoader.source=  component.link
        }

        Testo
        {
            text: component.nome
            font.pixelSize: 33
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 20

            }
        }

    }


}
