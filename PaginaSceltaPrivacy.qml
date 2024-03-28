

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

Item {
    id: component
    anchors.fill: parent

    property string titolo: qsTr("PRIVACY")

    signal pressYes
    signal pressNo
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    property bool rifiuto: false

    onPressNo:
    {
        if (rifiuto)
        {
            rifiuto=false
        }
        else
        {
            rifiuto=true
        }
    }
    onPressYes:
    {
        if (rifiuto)
        {

            _utenti.removeUser(impostazioni_utente.identifier)
            _utenti.readFile()
            impostazioni_utente.nome=""
            impostazioni_utente.foto=""

            pageLoader.source=  "PaginaLogin.qml"
        }
        else
        {
            pageLoader.source = "PasswordSave.qml"
        }
    }

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

        FrecceSotto
        {
            id: sotto
            swipe_visible: false

            sx_visible: false
            dx_visible: false

            up_visible: flickable.ypos>0
            down_visible: flickable.ypos<0.98
            onPressDown:  flickable.contentY+=0.03*flickable.contentHeight
            onPressUp: flickable.contentY-=0.03*flickable.contentHeight
        }

        Item
        {
            id: icone
            anchors
            {
                left: parent.left
                right: parent.right
                bottom: sotto.top
            }
            height: parent.height*0.3

            Testo
            {
                id: messaggio
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left:  si.right
                anchors.right: no.left
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: rifiuto?qsTr("CANCELLARE\nUTENTE") :qsTr("ACCETTARE?")
            }

            IconaCerchio
            {
                id: si
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
                anchors.verticalCenter: parent.verticalCenter
                width: 150

                onPressed: component.pressYes()
                Testo
                {
                    text: qsTr("SI")
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5
                    }
                }
            }


            IconaCerchio
            {
                id: no
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                anchors.verticalCenter: parent.verticalCenter
                width: 150
                state: "pieno"
                onPressed: component.pressNo()
                Testo
                {
                    text: qsTr("NO")
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5
                    }
                }
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
                id: flickable
                property real ypos: visibleArea.yPosition

                Testo
                {
                    id: testo_privacy
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    fontSizeMode: Text.VerticalFit
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    text: _privacy
                }
            }
        }
    }
}
