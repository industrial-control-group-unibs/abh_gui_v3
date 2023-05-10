import QtQuick 2.0
import SysCall 1.0


Item {
    id: component
    anchors.fill: parent

    property string titolo: "LUMINOSITÀ"

    signal pressYes
    signal pressNo
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

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
            dx_visible: false
            z:5
        }
    }

    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true


        Titolo
        {
            text: component.titolo
            height: parent.height*0.1
            fontSize: 40
        }

        Item
        {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            height: 100
            id: volume
            SysCall
            {
                id: chiamata_sistema
            }
            IconaMeno
            {
//                anchors.left: parent.left
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
//                anchors.top: parent.top
                onPressed:
                {
                    chiamata_sistema.string="light -U 5"
                    chiamata_sistema.call()
                }
            }
            IconaPlus
            {
//                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                height: parent.height
//                anchors.top: parent.top
                onPressed:
                {
                    chiamata_sistema.string="light -A 5"
                    chiamata_sistema.call()
                }
            }

//            IconaCerchio
//            {
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter
//                width: parent.height
//                onPressed:
//                {
//                    chiamata_sistema.string="pactl set-sink-mute @DEFAULT_SINK@ toggle"
//                    chiamata_sistema.call()

//                }

//                Testo
//                {
//                    text: "MUTE"
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    anchors.verticalCenter: parent.verticalCenter
//                    verticalAlignment: Text.AlignVCenter
//                    horizontalAlignment: Text.AlignHCenter
//                }
//            }

        }


    }
}




