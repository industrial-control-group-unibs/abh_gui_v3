

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    id: component
    anchors.fill: parent

    Component.onCompleted:
    {
        if (impostazioni_utente.identifier==="")
        {
            console.log("vai qui")
           pageLoader.source="PaginaImpostazioniAccount.qml"
        }
    }

    property string titolo: qsTr("IMPOSTAZIONI")

    property variant internalModel: ListModel {


        ListElement {
            nome: qsTr("MODIFICA UTENTE")
            link: "DefinizioneUtente1.qml"
        }
        ListElement {
            nome: qsTr("CONNESSIONI")
            link: "PaginaConnessioni.qml"
        }
        ListElement {
            nome: qsTr("AUDIO")
            link: "BarraVolume.qml"
        }
        ListElement {
            nome: qsTr("SCHERMO")
            link: "PaginaSchermo.qml"
        }
        ListElement {
            nome: qsTr("GENERALI")
            link: "PaginaGenerali.qml"
        }
        ListElement {
            nome: qsTr("SANIFICAZIONE")
            link: "PaginaSanificazione.qml"
        }
        ListElement {
            nome: qsTr("ASSISTENZA")
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
                    pageLoader.source="PaginaMondi.qml"
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
                bottomMargin: -parent.height*0.1

            }
            height: parent.height*0.2


            Rectangle
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
                height: 100
                width: height
                radius: width*0.5

                color: "transparent"
                border.color: parametri_generali.coloreBordo
                border.width: 5
                Image {
                    cache: false
                    fillMode: Image.PreserveAspectCrop
                    visible: false
                    mipmap: true
                    anchors.fill:parent
                    source: "file://"+PATH+"/../utenti/"+impostazioni_utente.identifier+"/foto.png"
                    id: allenamento_icona
                }

                Rectangle {
                    id: allenamento_mask
                    anchors
                    {
                        fill: parent
                        topMargin: parent.border.width
                        bottomMargin: parent.border.width
                        leftMargin: parent.border.width
                        rightMargin: parent.border.width
                    }
                    visible: false
                    color: "blue"
                    radius: parent.radius-parent.border.width
                }
                OpacityMask {
                    anchors.fill: allenamento_mask
                    source: allenamento_icona
                    maskSource: allenamento_mask
                }

                MouseArea
                {
                    anchors.fill: parent

                    onPressed: pageLoader.source="PaginaSceltaLogout.qml"
                }

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: parent.height*0.1
                    verticalAlignment: Text.AlignVCenter
                    text: qsTr("LOGOUT")
                }

            }



            IconaOff
            {
                id: iconaoff
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                onPressed: pageLoader.source=  "PaginaExit.qml"

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: parent.height*0.1
                    verticalAlignment: Text.AlignVCenter
                    text: qsTr("SPEGNI")
                }
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
