import QtQuick 2.0
import SysCall 1.0
import QtGraphicalEffects 1.12

Item {
    id: component
    anchors.fill: parent

    property string titolo: "VOLUME"
    signal pressYes
    signal pressNo
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    SysCall
    {
        id: chiamata_sistema
        property int volume: getVolume()
        property bool muted: isMuted()
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
                pageLoader.source=pageLoader.last_source
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
            height: 0.1*parent.height
            id: volume

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
                    if (chiamata_sistema.volume>=0)
                    {
                    chiamata_sistema.string="pactl set-sink-volume @DEFAULT_SINK@ -5%"
                    chiamata_sistema.call()
                    chiamata_sistema.volume= chiamata_sistema.getVolume()
                    }
                }
                id: meno
            }
            IconaPiu
            {
//                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                height: parent.height
//                anchors.top: parent.top
                onPressed:
                {
                    if (chiamata_sistema.volume<100)
                    {
                        chiamata_sistema.string="pactl set-sink-volume @DEFAULT_SINK@ +5%"
                        chiamata_sistema.call()
                        chiamata_sistema.volume= chiamata_sistema.getVolume()
                    }
                }
                id: piu
            }

            Item
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: meno.right
                anchors.right: piu.left
                anchors.leftMargin: meno.width*0.1
                anchors.rightMargin: meno.width*0.1
                height: parent.height*.2


//                Rectangle
//                {
//                    anchors.verticalCenter: parent.verticalCenter
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    height: parent.height
//                    width: parent.width//*chiamata_sistema.volume/100
//                    color: "red"
//                    radius: height*0.25

                    RadialGradient {
                        anchors.fill: parent
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: parametri_generali.coloreBordo}
                            GradientStop { position: (chiamata_sistema.volume+10)/210; color: "transparent" }
                        }
                    }
//                }
            }



            IconaCerchio
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -2*piu.height
                width: parent.height
                onPressed:
                {
                    console.log("volume= ",chiamata_sistema.getVolume())
                    chiamata_sistema.string="pactl set-sink-mute @DEFAULT_SINK@ toggle"
                    chiamata_sistema.call()
                    chiamata_sistema.volume= chiamata_sistema.getVolume()
                    chiamata_sistema.muted= chiamata_sistema.isMuted()

                }

                Testo
                {
                    text: chiamata_sistema.muted? "UNMUTE": "MUTE"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

            }

        }


    }
}




