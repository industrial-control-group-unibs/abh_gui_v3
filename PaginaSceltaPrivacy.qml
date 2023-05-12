

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

Item {
    id: component
    anchors.fill: parent

    property string titolo: selected_exercise.name

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
            pageLoader.source = "PaginaLogin.qml"
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
        }

        Item
        {
            id: icone
            anchors
            {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
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
                text: rifiuto?"CANCELLARE\nUTENTE" :"ACCETTARE?"
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
                    text: "SI"
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
                    text: "NO"
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
                top: parent.top
                bottom: icone.top
            }

            Flickable {
                clip: true
                anchors.fill: parent
                contentWidth: parent.width; contentHeight: testo_privacy.height

                Testo
                {
                    id: testo_privacy
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    fontSizeMode: Text.VerticalFit
                    wrapMode: Text.WordWrap
                    text: _privacy
                }
            }
        }
    }
}
