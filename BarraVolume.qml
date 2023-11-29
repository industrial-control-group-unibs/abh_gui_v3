import QtQuick 2.0
import SysCall 1.0
import QtGraphicalEffects 1.12
import QtMultimedia 5.0

Item {
    id: component
    anchors.fill: parent

    property string titolo: qsTr("VOLUME")
    signal pressYes
    signal pressNo
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Component.onCompleted: console.log("entrato")

    Barra_superiore{}

    SysCall
    {
        id: chiamata_sistema
        property int volume: parametri_generali.volume
        property string volumeString: chiamata_sistema.volume
        property bool muted: isMuted()
        onVolumeChanged:
        {
            _user_config.setValue("volume",volumeString)
        }
    }

    SoundEffect {
        id: playSound_ding
        source: "file://"+PATH+"/suoni/"+parametri_generali.lingua+"/ding_regolazione_audio.wav"
        volume: 1.0
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
            id: audio_esercizi
            anchors
            {
                top: volume.bottom
                topMargin: titolo.height
                left: titolo.left
                right: titolo.right
                leftMargin: 113/1080*parent.width
                rightMargin: 113/1080*parent.width
            }
            height: titolo.height*.7
            IconaCerchio
            {
                id: icona_salva_pwd
                state: parametri_generali.voice?"pieno":"vuoto"
                onPressed: {
                    if (parametri_generali.voice)
                    {
                        _user_config.setValue("voice","false")
                        state="vuoto"
                    }
                    else
                    {
                        _user_config.setValue("voice","true")
                        state="pieno"
                    }
                }
            }


            Testo
            {
                text: component.muted?qsTr("PREMI PER DISATTIVARE AUDIO CONTEGGIO ESERCIZIO"):qsTr("PREMI PER ATTIVARE AUDIO CONTEGGIO ESERCIZIO")
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
            //visible: component.conferma
            anchors
            {
                top: audio_esercizi.bottom
                topMargin: titolo.height*.5
                left: titolo.left
                right: titolo.right
                leftMargin: 113/1080*parent.width
                rightMargin: 113/1080*parent.width
            }
            height: titolo.height*.7
            IconaCerchio
            {
                id: icona2
                state: !chiamata_sistema.muted?"pieno":"vuoto"
                onPressed: {
                    chiamata_sistema.string="pactl set-sink-mute @DEFAULT_SINK@ toggle"
                    chiamata_sistema.call()
                }
            }


            Testo
            {
                text: !chiamata_sistema.muted?qsTr("PREMI PER LA MODALITA' SILENZIOSA"):qsTr("PREMI PER USCIRE DALLA MODALITA' SILENZIOSA")
                anchors
                {
                    verticalCenter: icona2.verticalCenter
                    left: icona2.right
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
            anchors.verticalCenterOffset: -parent.height*0.25
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
                      chiamata_sistema.volume -= 5
                    }
                    playSound_ding.play()
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
                        chiamata_sistema.volume += 5
                    }
                    playSound_ding.play()
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
                visible: false
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




