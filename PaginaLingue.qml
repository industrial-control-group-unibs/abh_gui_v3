

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    id: component
    anchors.fill: parent


    property string titolo: qsTr("LINGUA")

    property variant internalModel: ListModel {

        ListElement {
            nome: qsTr("ITALIANO")
            dict: "abh_it"
        }
        ListElement {
            nome: qsTr("INGLESE")
            dict: "abh_en"
        }
        ListElement {
            nome: qsTr("ARABO")
            dict: "abh_ar"
        }
        ListElement {
            nome: qsTr("TEDESCO")
            dict: "abh_de"
        }
        ListElement {
            nome: qsTr("FRANCESE")
            dict: "abh_fr"
        }
        ListElement {
            nome: qsTr("SPAGNOLO")
            dict: "abh_es"
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
                onPressSx:
                {
                    if (impostazioni_utente.identifier !=="")
                        pageLoader.source="PaginaAllenamento.qml"
                    else
                        pageLoader.source="PaginaLogin.qml"
                }
                dx_visible: false
                z:5
            }
        }
        Item{
            anchors.bottom: parent.bottom
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
                                _user_config.setValue("lingua",dict)
                                _history.pop()
                                pageLoader.source= "PaginaConfermaLingue.qml"

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
