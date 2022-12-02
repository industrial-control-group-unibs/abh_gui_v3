

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
import QtQuick 2.2
import QtQuick.Dialogs 1.0
Item {
    id: component
    anchors.fill: parent

    property string titolo: "IMPOSTAZIONE COLORE"

    property variant internalModel: ListModel {
        ListElement {
            nome: "SFONDO"
        }
        ListElement {
            nome: "COLORE PRINCIPALE"
        }
        ListElement {
            nome: "COLORE SECONDARIO"
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
                bottomMargin: parametri_generali.larghezza_barra
                left: parent.left
                right: parent.right
            }
            id: lista_opzioni
            spacing:  parent.height*0.05

            Item
            {
                width: parent.width
                height: parent.height*0.15
                MouseArea
                {
                    anchors.fill: parent
                    onPressed: {
                        colorDialog.visible=true
                    }
                }

                Rectangle {
                    id:rect
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.margins: 2
                    height: parent.height
                    width: height
                    radius: width*0.5

                    border.color: parametri_generali.coloreBordo
                    border.width: 5
                    color: parametri_generali.coloreSfondo

                }

                Testo
                {
                    anchors.top: parent.top
                    anchors.left: rect.right
                    anchors.right: right.right
                    anchors.leftMargin: 30
                    height: parent.height


                    font.pixelSize: 35/1920*component.height
                    verticalAlignment: Text.AlignVCenter
                    text: "SFONDO"
                }

                ColorDialog {
                    title: "SELEZIONA COLORE"
                    id: colorDialog
                    onAccepted: {
                        parametri_generali.coloreSfondo=colorDialog.color
                        visible: false
                    }
                    onRejected: {
                        visible: false
                    }
                    visible: false

                }
            }

            Item
            {
                width: parent.width
                height: parent.height*0.15
                MouseArea
                {
                    anchors.fill: parent
                    onPressed: {
                        colorDialog2.visible=true
                    }
                }

                Rectangle {
                    id:rect2
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.margins: 2
                    height: parent.height
                    width: height
                    radius: width*0.5

                    border.color: parametri_generali.coloreBordo
                    border.width: 5
                    color: parametri_generali.coloreSfondo

                }

                Testo
                {
                    anchors.top: parent.top
                    anchors.left: rect2.right
                    anchors.right: right.right
                    anchors.leftMargin: 30
                    height: parent.height


                    font.pixelSize: 35/1920*component.height
                    verticalAlignment: Text.AlignVCenter
                    text: "COLORE PRINCIPALE"
                }

                ColorDialog {
                    title: "SELEZIONA COLORE"
                    id: colorDialog2
                    onAccepted: {
                        parametri_generali.coloreBordo=colorDialog2.color
                        visible: false
                    }
                    onRejected: {
                        visible: false
                    }
                    visible: false

                }
            }

            Item
            {
                width: parent.width
                height: parent.height*0.15
                MouseArea
                {
                    anchors.fill: parent
                    onPressed: {
                        colorDialog3.visible=true
                    }
                }

                Rectangle {
                    id:rect3
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.margins: 2
                    height: parent.height
                    width: height
                    radius: width*0.5

                    border.color: parametri_generali.coloreBordo
                    border.width: 5
                    color: parametri_generali.coloreSfondo

                }

                Testo
                {
                    anchors.top: parent.top
                    anchors.left: rect3.right
                    anchors.right: right.right
                    anchors.leftMargin: 30
                    height: parent.height


                    font.pixelSize: 35/1920*component.height
                    verticalAlignment: Text.AlignVCenter
                    text: "COLORE SECONDARIO"
                }

                ColorDialog {
                    title: "SELEZIONA COLORE"
                    id: colorDialog3
                    onAccepted: {
                        parametri_generali.coloreUtente=colorDialog3.color
                        visible: false
                    }
                    onRejected: {
                        visible: false
                    }
                    visible: false

                }
            }


            Item
            {
                width: parent.width
                height: parent.height*0.15
                MouseArea
                {
                    anchors.fill: parent
                    onPressed: {
                        parametri_generali.coloreTesto       =  "#473729"
                        parametri_generali.coloreTestoChiaro =  "#ffd4c9bd"
                        parametri_generali.coloreSfondo      =  "#2A211B"
                        parametri_generali.coloreBordo       =  "#D4C9BD"
                        parametri_generali.coloreBarra       =  "#2A211B"
                        parametri_generali.coloreIcona       =  "#ff9f9181"
                    }
                }

                Rectangle {
                    id:rect4
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.margins: 2
                    height: parent.height
                    width: height
                    radius: width*0.5

                    border.color: parametri_generali.coloreBordo
                    border.width: 5
                    color: parametri_generali.coloreSfondo

                }

                Testo
                {
                    anchors.top: parent.top
                    anchors.left: rect4.right
                    anchors.right: right.right
                    anchors.leftMargin: 30
                    height: parent.height


                    font.pixelSize: 35/1920*component.height
                    verticalAlignment: Text.AlignVCenter
                    text: "RIPRISTINA COLORE"
                }


            }



        }

    }
}
