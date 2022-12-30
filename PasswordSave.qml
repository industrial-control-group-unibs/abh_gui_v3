import QtQuick 2.0
import SysCall 1.0
import QtGraphicalEffects 1.12

Item {
    id: component
    anchors.fill: parent

    property string titolo: conferma? "CONFERMA PASSWORD" : "INSERISCI PASSWORD"
    signal pressYes
    signal pressNo
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    property string password: ""
    property bool   conferma: false

    Component.onDestruction:
    {

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
            id: titolo
        }

        Item
        {
            id: display
            anchors
            {
                top: titolo.bottom
                bottom: tastierino.top
                horizontalCenter: parent.horizontalCenter
            }

            width: tastierino.width
            property real spacing: 5
            property int pwd_lenght: 8
            property real key_width: (width-(pwd_lenght-1)*spacing)/pwd_lenght

            Row
            {
                spacing: parent.spacing
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Repeater {
                    model: display.pwd_lenght

                    Rectangle
                    {
                        height: display.key_width
                        width: height
                        radius: 0.1*height
                        color: parametri_generali.coloreBordo

                        Rectangle
                        {
                            visible: tastierino.testo.length>index
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            height: parent.height*0.5
                            width: height
                            radius: 0.5*height
                            color: parametri_generali.coloreSfondo
                        }
                    }
                }
            }
        }


        Tastiera
        {
            id: tastierino
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width*0.1
            colore: parametri_generali.coloreBordo
            font_colore: parametri_generali.coloreSfondo

            onTestoChanged:
            {
                if (tastierino.testo.length>=display.pwd_lenght)
                {
                    if (component.conferma)
                    {
                        if (tastierino.testo===component.password)
                        {
                             _utenti.savePassword(impostazioni_utente.identifier,component.password)
                            pageLoader.source=  "PaginaLogin.qml"
                        }
                        else
                        {
                            component.conferma=false
                            testo=""
                        }
                    }
                    else
                    {
                        component.password=tastierino.testo
                        component.conferma=true
                        testo=""
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
            bottom: tastierino.top
        }
        height: 200
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
}
