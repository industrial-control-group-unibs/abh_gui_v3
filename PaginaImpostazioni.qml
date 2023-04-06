

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    id: component
    anchors.fill: parent

    //Component.onDestruction: pageLoader.last_source="PaginaImpostazioni.qml"

    property string titolo: "IMPOSTAZIONI"

    property variant internalModel: ListModel {
        //        ListElement {
        //            nome: "CAMBIA UTENTE"
        //            link: "PaginaSceltaLogout.qml"
        //        }

        ListElement {
            nome: "MODIFICA UTENTE"
            link: "DefinizioneUtente1.qml"
        }
        ListElement {
            nome: "CONNESSIONI"
            link: "PaginaConnessioni.qml"
        }
        ListElement {
            nome: "AUDIO"
            link: "BarraVolume.qml"
        }
        ListElement {
            nome: "SCHERMO"
            link: "PaginaSchermo.qml"
        }
        ListElement {
            nome: "GENERALI"
            link: "PaginaGenerali.qml"
        }
        //        ListElement {
        //            nome: "PRIVACY"
        //            link: "PaginaPrivacy.qml"
        //        }
        ListElement {
            nome: "ASSISTENZA"
            link: "PaginaUbuntu.qml"
        }
    }

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{id: barra}

    Item {
        anchors.top: barra.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Item
        {
            id: freccia
            anchors
            {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: parent.height*0.3
            FrecceSxDx
            {

                property url this_source:"PaginaImpostazioni.qml"
                onPressSx:
                {
                    _history.pop()
                    pageLoader.source=_history.pop()
                }
                dx_visible: false
                z:5
            }
        }
        Item
        {
            id: tasti_utente
            anchors
            {
                left: parent.left
                right: parent.right
                bottom: freccia.top
            }
            height: parent.height*0.2

            IconaPiu
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
                onPressed: pageLoader.source="PaginaSceltaLogout.qml"
            }

            IconaOff
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                onPressed: pageLoader.source=  "PaginaExit.qml"
            }
        }

        Item{
            anchors.bottom: tasti_utente.top
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
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
                            onClicked:
                            {
                                pageLoader.source=link
                                _queue.push(link)
                            }
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

}
