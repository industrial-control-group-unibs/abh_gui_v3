

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    id: component
    anchors.fill: parent

    property string titolo: "IMPOSTAZIONI GENERALI"

    property variant internalModel: ListModel {
        ListElement {
            nome: "LINGUA"
            link: "PaginaImpostazioni.qml"
        }
        ListElement {
            nome: "VERSIONE SOFTWARE"
            link: "PaginaImpostazioni.qml"
        }
        ListElement {
            nome: "AGGIORNAMENTO SOFTWARE"
            link: "PaginaAggiornaSoftware.qml"
        }
    }

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
            height: 130/1920*component.height
            fontSize: 40
            id: titolo
        }



        Column
        {
            anchors {
                top: titolo.bottom
                topMargin: parametri_generali.larghezza_barra
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            id: lista_opzioni
            Repeater
            {
                model: component.internalModel
                delegate:
                    Item   {



                    width: component.width-2 //lista_zona.cellWidth-2
                    height: 120/1920*component.height
                    anchors.left: lista_opzioni.left
                    anchors.leftMargin: lista_opzioni.width*0.1
                    id: opzione
                    implicitWidth: 800
                    implicitHeight: 225
                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: pageLoader.source=link
                        z: 40
                    }

                    IconaPiu
                    {
                        id: icona_pid
                        height: 74/1920*component.height
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Testo
                    {
                        anchors.left: icona_pid.right
                        anchors.leftMargin: lista_opzioni.width*0.05
                        anchors.verticalCenter: parent.verticalCenter
                        height: icona_pid.height
                        font.pixelSize: 35/1920*component.height
                        verticalAlignment: Text.AlignVCenter
                        text: nome
                    }

                }
            }
        }

    }
}
