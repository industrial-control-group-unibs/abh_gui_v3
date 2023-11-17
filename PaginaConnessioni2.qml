

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0
Item {
    id: component
    anchors.fill: parent

    property string titolo: qsTr("CONNESSIONI")

    Component.onCompleted:
    {
        chiamata_sistema.string="nmcli device wifi rescan"
        chiamata_sistema.call()

        if (parametri_generali.wifi_known)
        {
            chiamata_sistema.string="nmcli device wifi connect "+parametri_generali.wifi_name+" ifname "+parametri_generali.wifi_net+" &"
            chiamata_sistema.call()
            _history.pop()
            pageLoader.source="PaginaImpostazioni.qml"
        }
    }
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    Tastiera
    {
        z: 4
        id: tastiera
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        colore: parametri_generali.coloreBordo
        font_colore: parametri_generali.coloreSfondo
        visible: true
    }



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

        Rectangle
        {
            id: casella
            property color colore: parametri_generali.coloreBordo
            anchors
            {
                top: titolo.bottom
                topMargin: 30
                horizontalCenter: parent.horizontalCenter
            }

            width: parent.width*0.5
            height: 80/1080*parent.width
            radius: 20
            color: "transparent"
            border.color: colore
            Testo
            {
                text: "PASSWORD"
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.bottom
                    topMargin: 5
                }
            }


            Text {
                id: input_nome
                anchors.left:parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                height: 60
                text: tastiera.testo

                color: parametri_generali.coloreBordo
                font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                font.italic: false
                font.letterSpacing: 0
                font.pixelSize: 20
                font.weight: Font.Normal
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

            }
        }

    }
    Item
    {
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: tastiera.top
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

            onPressDx:
            {
                chiamata_sistema.string="nmcli device wifi connect "+parametri_generali.wifi_name+" ifname "+parametri_generali.wifi_net+" password "+input_nome.text
                chiamata_sistema.call()
            }

            z:5
        }
    }



    SysCall
    {
        id: chiamata_sistema
    }

}
