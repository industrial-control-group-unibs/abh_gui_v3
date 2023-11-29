

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

Item {
    id: component
    anchors.fill: parent

    property string titolo: qsTr("INFORMAZIONI")

    implicitHeight: 1920/2
    implicitWidth: 1080/2



    Barra_superiore{}

    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true


        Titolo
        {
            text: component.titolo
            height: parent.height*0.1
            fontSize: 40
            id: titolo
        }

        Item
        {
            id: icone
            anchors
            {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: parent.height*0.3

            FrecceSxDx
            {
                id: freccia
                onPressSx:
                {
                    _history.pop()
                    pageLoader.source=_history.pop()
                }
                dx_visible: false
                z:5
            }
        }

        Item {
            id: testo
            anchors
            {
                left: parent.left
                right: parent.right
                top: titolo.bottom
                bottom: icone.top
            }

            Flickable {
                clip: true
                anchors.fill: parent
                contentWidth: parent.width; contentHeight: testo_privacy.height

                Testo
                {
                    id: testo_privacy
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    fontSizeMode: Text.VerticalFit
                    wrapMode: Text.WordWrap
                    text: _info
                }
            }
        }
    }
}
