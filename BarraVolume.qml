import QtQuick 2.0
import SysCall 1.0
import QtGraphicalEffects 1.12

Item {
    id: component
    anchors.fill: parent

    property string titolo: qsTr("VOLUME")
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
            id: titolo
            text: component.titolo
            height: parent.height*0.1
            fontSize: 40
        }

        Item
        {
            //visible: component.conferma
            anchors
            {
                top: volume.bottom
                topMargin: titolo.height
                left: titolo.left
                right: titolo.right
                leftMargin: 113/1080*parent.width
                rightMargin: 113/1080*parent.width
            }
            height: titolo.height
            IconaCerchio
            {
                id: icona_salva_pwd
                state: parametri_generali.voice?"pieno":"vuoto"
                onPressed: {
                    if (parametri_generali.voice)
                    {
                        parametri_generali.voice=false
                        state="vuoto"
                    }
                    else
                    {
                        parametri_generali.voice=true
                        state="pieno"
                    }
                }
            }


            Testo
            {
                text: parametri_generali.voice?qsTr("DISATTIVA AUDIO CONTEGGIO ESERCIZIO"):qsTr("ATTIVA AUDIO CONTEGGIO ESERCIZIO")
                anchors
                {
                    verticalCenter: icona_salva_pwd.verticalCenter
                    left: icona_salva_pwd.right
                    right: parent.right
                }
                anchors.margins: 10
                fontSizeMode: Text.Fit
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

            }

        }

        Item
        {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            height: 100
            id: volume

            IconaMeno
            {
//                anchors.left: parent.left
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
//                anchors.top: parent.top
                black: true
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
            IconaPlus
            {
//                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                height: parent.height
                black: true
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
//                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: meno.right
                anchors.right: piu.left
                anchors.leftMargin: meno.width*0.1
                anchors.rightMargin: meno.width*0.1
                height: parent.height*.5



                    RadialGradient {
                        anchors.fill: parent
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: parametri_generali.coloreUtente}
                            GradientStop { position: (0.8*chiamata_sistema.volume+80)/300; color: "transparent" }
                        }
                    }
            }



            IconaCerchio
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -2*piu.height
                width: parent.height
                onPressed:
                {
                    chiamata_sistema.string="pactl set-sink-mute @DEFAULT_SINK@ toggle"
                    chiamata_sistema.call()
                    chiamata_sistema.volume= chiamata_sistema.getVolume()
                    chiamata_sistema.muted= chiamata_sistema.isMuted()

                }

                Testo
                {
                    text: chiamata_sistema.muted? qsTr("UNMUTE"): qsTr("MUTE")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

            }

        }


    }
}




