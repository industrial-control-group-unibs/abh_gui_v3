import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import Qt.labs.qmlmodels 1.0 //sudo apt install qml-module-qt-labs-qmlmodels



Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    id: component
    property bool link_dx_visible: false
    property string text: tastierino.testo
    property string titolo: ""
    signal pressSx
    signal pressDx

    onTextChanged:
    {
        link_dx_visible=text.length>0
    }

    Barra_superiore{titolo: component.titolo}

    Item
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z:parent.z+2
        height:274+50

    }

    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true

        Tastiera
        {
            id: tastierino
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width*0.1
            colore: parametri_generali.coloreBordo
            font_colore: parametri_generali.coloreSfondo


        }

        Item {
            anchors.top:    parent.top
            anchors.bottom: tastierino.top
            anchors.left:   parent.left
            anchors.right:  parent.right

            FrecceSxDx
            {
                onPressSx: component.pressSx()
                onPressDx: component.pressDx()
                dx_visible: component.link_dx_visible
                colore: parametri_generali.coloreBordo
            }

            Rectangle
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                height: 80/1080*parent.width
                radius: 20

                width: parent.width*0.6
                border.color: parametri_generali.coloreBordo
                border.width: 5
                color: "transparent"
                Testo
                {
                    text: component.text
                    font.pixelSize: 50
                    anchors.fill: parent
                    anchors.margins: 10
                    fontSizeMode: Text.Fit
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }



    }
}
