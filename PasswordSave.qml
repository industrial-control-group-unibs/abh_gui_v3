import QtQuick 2.0
import SysCall 1.0
import QtGraphicalEffects 1.12

Item {
    id: component
    anchors.fill: parent

    property string titolo: conferma? qsTr("CONFERMA IL PIN") : qsTr("INSERISCI IL PIN")
    signal pressYes
    signal pressNo
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    property string password: ""
    property bool   conferma: false
    property bool   salva_pwd: false

    Component.onCompleted:
    {
        parametri_generali.login_page=false
    }
    Component.onDestruction:
    {
        parametri_generali.login_page=true
    }





    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true


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
                    _history.pop()
                    pageLoader.source=_history.pop()
                }
                dx_visible: false
                z:5
            }
        }

        Titolo
        {
            text: component.titolo
            height: parent.height*0.1
            fontSize: 40
            id: titolo
        }
        Item
        {
            //visible: component.conferma
            anchors
            {
                top: titolo.bottom
                topMargin: titolo.height*0.1
                left: titolo.left
                right: titolo.right
                leftMargin: 113/1080*parent.width
                rightMargin: 113/1080*parent.width
            }
            height: titolo.height
            IconaCerchio
            {
                id: icona_salva_pwd
                onPressed: {
                    component.salva_pwd=true
                    pieno=!pieno
                }
            }


            Testo
            {
                text: qsTr("RICORDA IL PIN")
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
            id: display
            anchors
            {
                top: titolo.bottom
                bottom: tastierino.top
                horizontalCenter: parent.horizontalCenter
            }

            width: tastierino.width
            property real spacing: 5
            property int pwd_lenght: 4
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
                            if (component.salva_pwd)
                                _utenti.saveStorePassword(impostazioni_utente.identifier,"true")
                            else
                                _utenti.saveStorePassword(impostazioni_utente.identifier,"false")
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





}
