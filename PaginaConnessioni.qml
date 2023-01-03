

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0
Item {
    id: component
    anchors.fill: parent

    property string titolo: "CONNESSIONI"

    Component.onCompleted:
    {
        parametri_generali.wifi_name=""
        chiamata_sistema.string="nmcli device wifi rescan"
        chiamata_sistema.call()
        _wifi.readList()

    }


    SysCall
    {
        id: chiamata_sistema
    }


    Timer
    {
        interval: 5000
        id: timer_scan
        repeat: true
        running: true
        onTriggered:
        {
            chiamata_sistema.string="nmcli device wifi rescan"
            chiamata_sistema.call()
            _wifi.readList()
        }
    }

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
            height: 130/1920*component.height
            fontSize: 40
            id: titolo
        }

        ListView {
//            snapMode: ListView.SnapOneItem
//            highlightRangeMode: ListView.StrictlyEnforceRange
            id: lista_wifi
            clip: true
            anchors {
                top: titolo.bottom
                left: parent.left
                right: parent.right
            }
            height: parent.height*0.5
            model: _wifi
            currentIndex:-1
            delegate: Item {
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.right: parent.right
                height: 150
                Testo
                {
                    text: nome
                    font.bold:  lista_wifi.currentIndex === index
                    font.pixelSize: 20
                    verticalAlignment: Text.AlignVCenter

                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        lista_wifi.currentIndex = index
                        parametri_generali.wifi_name=nome
                    }
                }

            }



        }
    }
    Item
    {
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
            dx_visible: parametri_generali.wifi_name!==""
            onPressDx:
            {
                pageLoader.source="PaginaConnessioni2.qml"
            }

            z:5
        }
    }


}
