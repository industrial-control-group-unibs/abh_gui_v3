

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

    Component.onDestruction:
    {
        _utenti.saveColor(impostazioni_utente.identifier,parametri_generali.coloreBordo,parametri_generali.coloreSfondo,parametri_generali.coloreUtente)
    }

//    property variant internalModel: ListModel {
//        ListElement {
//            nome: "SFONDO"
//        }
//        ListElement {
//            nome: "COLORE PRINCIPALE"
//        }
//        ListElement {
//            nome: "COLORE SECONDARIO"
//        }
//    }

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
                _history.pop()
                pageLoader.source=_history.pop()
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
                topMargin: 0.5*parametri_generali.larghezza_barra
                bottom: parent.bottom
                bottomMargin: 0.5*parametri_generali.larghezza_barra
                left: parent.left
                right: parent.right
            }
            id: lista_opzioni
            spacing:  parent.height*0.05

            Item
            {
                width: parent.width
                height: 80
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
                    text: qsTr("SFONDO")
                }

                ColorDialog {
                    title: qsTr("SELEZIONA COLORE")
                    id: colorDialog
                    onAccepted: {
                        parametri_generali.coloreSfondo=colorDialog.color
                        rect.color= parametri_generali.coloreSfondo
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
                height: 80
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
                    color: parametri_generali.coloreBordo

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
                    title: qsTr("SELEZIONA COLORE")
                    id: colorDialog2
                    onAccepted: {
                        if (colorDialog2.color!==parametri_generali.coloreSfondo)
                        {
                            parametri_generali.coloreBordo=colorDialog2.color
                            rect2.color= parametri_generali.coloreBordo
                        }
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
                height: 80
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
                    color: parametri_generali.coloreUtente

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
                    text: qsTr("COLORE SECONDARIO")
                }

                ColorDialog {
                    title: qsTr("SELEZIONA COLORE")
                    id: colorDialog3
                    modality: Qt.NonModal
                    onAccepted: {
                        if (colorDialog3.color!==parametri_generali.coloreSfondo)
                        {
                            parametri_generali.coloreUtente=colorDialog3.color
                            rect3.color= parametri_generali.coloreUtente
                        }
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
                height: 80
                MouseArea
                {
                    anchors.fill: parent
                    onPressed: {
                        colorDialogLed.visible=true
                    }
                }

                Rectangle {
                    id:rect_led
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.margins: 2
                    height: parent.height
                    width: height
                    radius: width*0.5

                    border.color: parametri_generali.coloreBordo
                    border.width: 5
                    color: parametri_generali.coloreLed

                }

                Testo
                {
                    anchors.top: parent.top
                    anchors.left: rect_led.right
                    anchors.right: right.right
                    anchors.leftMargin: 30
                    height: parent.height


                    font.pixelSize: 35/1920*component.height
                    verticalAlignment: Text.AlignVCenter
                    text: qsTr("COLORE LED")
                }

                ColorDialog {
                    title: qsTr("SELEZIONA COLORE")
                    id: colorDialogLed
                    onAccepted: {
                        parametri_generali.coloreLed=colorDialogLed.color
                        rect_led.color= parametri_generali.coloreLed
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
                id: ripristina
                width: parent.width
                height: 80
                property color sfondo: rect.color
                property color colore: Qt.rgba(1.0-sfondo.r, 1.0-sfondo.g, 1.0-sfondo.b)

                Component.onCompleted: colore=Qt.rgba(1.0-sfondo.r, 1.0-sfondo.g, 1.0-sfondo.b,1.0)

                onSfondoChanged:
                {
                    colore=Qt.rgba(1.0-sfondo.r, 1.0-sfondo.g, 1.0-sfondo.b,1.0)
                }

                MouseArea
                {
                    anchors.fill: parent
                    onPressed: {
                        parametri_generali.coloreBordo     = _default[0]
                        parametri_generali.coloreSfondo    = _default[1]
                        parametri_generali.coloreUtente    = _default[2]
                        parametri_generali.coloreLed       = _default[3]

                        rect.color     = parametri_generali.coloreSfondo
                        rect2.color    = parametri_generali.coloreBordo
                        rect3.color    = parametri_generali.coloreUtente
                        rect_led.color = parametri_generali.coloreLed
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

                    border.color:  parametri_generali.coloreBordo
                    border.width: 5
                    color: ripristina.colore

                }

                Testo
                {
                    anchors.top: parent.top
                    anchors.left: rect4.right
                    anchors.right: right.right
                    anchors.leftMargin: 30
                    height: parent.height
                    color: parent.colore


                    font.pixelSize: 35/1920*component.height
                    verticalAlignment: Text.AlignVCenter
                    text: qsTr("RIPRISTINA COLORI")
                }
            }
        }
    }
}
