import QtQuick 2.0
import SysCall 1.0
import QtGraphicalEffects 1.12

Item {
    id: component
    anchors.fill: parent

    property string titolo: avvia?qsTr("SANIFICAZIONE  IN CORSO"):qsTr("SANIFICAZIONE")
    signal pressYes
    signal pressNo

    property bool conferma: false
    property bool avvia: false
    property int durata: 30
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    SysCall
    {
        id: chiamata_sistema
        property int luminosita: _light
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
            visible: !component.conferma
            id: freccia2
            onPressSx:
            {
                component.avvia=false
                component.conferma=false
            }
            dx_visible: false

            z:5
        }
        FrecceSxDx
        {
            visible: (!component.conferma && !component.avvia)
            id: freccia
            onPressSx:
            {
                _history.pop()
                pageLoader.source=_history.pop()
            }
            dx_visible: true
            onPressDx: component.conferma=true
            z:5
        }
        Item
        {
            visible: component.conferma
            anchors.fill: parent
            SiNo
            {
                onPressNo:
                {
                    component.conferma=false
                }
                onPressYes:
                {
                    component.conferma=false
                    component.avvia=true
                }
            }
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
            visible: component.avvia

            anchors.fill: parent

            Timer{
                id: conto_alla_rovescia
                interval: 500
                repeat: true
                running: component.avvia
                property int position: 0
                property int duration: component.durata*60*1000
                onTriggered: {
                    if (position<duration)
                    {
                        position+=interval
                    }
                    else
                    {
                        chiamata_sistema.string="systemctl poweroff"
                        chiamata_sistema.call()
                        chiamata_sistema.string="xset -display :0.0 dpms force off"
                        chiamata_sistema.call()
                    }
                }
            }

            CircularTimer {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 200
                colore: parametri_generali.coloreUtente
                value: 1-conto_alla_rovescia.position/conto_alla_rovescia.duration
                tempo: (conto_alla_rovescia.duration-conto_alla_rovescia.position) //timerino.remaining_time

                Testo
                {
                    text: qsTr("TEMPO")
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.top
                        topMargin: parent.height*0.05

                    }
                }
            }
        }

        Item
        {
            visible: !component.avvia
            anchors
            {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            height: parent.height/5.0


            LinearSlider
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: 30
                min: 5
                max: 120
                increment: 5

                onValueChanged: component.durata=value

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    anchors.bottomMargin: parent.height*0.1
                    width: 300
                    textFormat: Text.RichText
                    text: component.conferma? qsTr("<span style='font-size: 70px;'>AVVIA SANIFICAZIONE </span> <br />")+ qsTr("<span style='font-size: 30px'>LA MACCHINA SI SPEGNERÀ AL TERMINE</span>"):
                                              qsTr("<span style='font-size: 70px;'>IMPOSTA DURATA </span>")+ qsTr("<span style='font-size: 30px'>min.</span>")

                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
                }

            }


        }




    }
}




