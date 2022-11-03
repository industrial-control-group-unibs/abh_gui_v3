

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    id: component
    anchors.fill: parent

    property string titolo: "IMPOSTAZIONI"

    property variant internalModel: ListModel {
        ListElement {
            nome: "LOGOUT"
            link: "PaginaLogin.qml"
        }
        ListElement {
            nome: "ALLENAMENTO"
            link: "PaginaAllenamento.qml"
        }

        ListElement {
            nome: "CONNESSIONI"
            link: "PaginaLogin.qml"
        }
        ListElement {
            nome: "AUDIO"
            link: "BarraVolume.qml"
        }
        ListElement {
            nome: "SCHERMO"
            link: "PaginaLogin.qml"
        }
        ListElement {
            nome: "GENERALI"
            link: "PaginaLogin.qml"
        }
        ListElement {
            nome: "ASSISTENZA"
            link: "PaginaLogin.qml"
        }
    }

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

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
                    height: component.height*0.1
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
                        height: 111/1920*component.height
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Testo
                    {
                        anchors.left: icona_pid.right
                        anchors.leftMargin: lista_opzioni.width*0.05
                        anchors.verticalCenter: parent.verticalCenter
                        height: icona_pid.height
                        font.pixelSize: 60/1920*component.height
                        verticalAlignment: Text.AlignVCenter
                        text: nome
                    }

                }
            }
        }

    }
}
