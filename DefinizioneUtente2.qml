

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    BottoniSwipe{
        onPressLeft: pageLoader.source="DefinizioneUtente1.qml"
        state: "dx"
    }


    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        Text {
            text: "UTENTE"
            id: testo_utente
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 20
            }
            color: parametri_generali.coloreBordo
            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

            font.italic: false
            font.letterSpacing: 0
            font.pixelSize: 70
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop

        }

        Image {

            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 180
            }
            width: 300
            height: width

            id: img_utente
            property string img_name: "pic_foto.jpg"
            layer.enabled: true
            fillMode: Image.PreserveAspectCrop
            visible: true
            mipmap: true

            source: "file://"+PATH+"/images/"+img_name

            layer.effect: OpacityMask {
                maskSource: Item {
                    width: img_utente.width
                    height: img_utente.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: img_utente.adapt ? img_utente.width : Math.min(img_utente.width, img_utente.height)
                        height: img_utente.adapt ? img_utente.height : width
                        radius: Math.min(width, height)
                    }
                }
            }
        }


//        IconaCerchio{
//            anchors{
//                bottom: parent.bottom
//                right: parent.right

//                bottomMargin: 260-height*0.5
//                rightMargin: 182-width*0.5
//            }
//            link: "PaginaLogin.qml"
//        }

        Item
        {
            anchors
            {
//                horizontalCenter: parent.horizontalCenter
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                topMargin: 570
            }
            ColumnLayout
            {
                spacing: 20
                Item { //TELEFONO
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 80

                    Item
                    {
                        anchors
                        {
                            top:parent.top
                            bottom:parent.bottom
                            left:parent.left
                            leftMargin: 70
                        }
                        width: 400-anchors.leftMargin

                        Text {
                            text: "TELEFONO"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: parametri_generali.coloreBordo
                            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                            font.italic: false
                            font.letterSpacing: 0
                            font.pixelSize: 35
                            font.weight: Font.Normal
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignTop

                        }
                    }
                    Rectangle
                    {
                        anchors
                        {
                            top:parent.top
                            bottom:parent.bottom
                            left:parent.right
                            leftMargin: 398
                        }
                        width: 447
                        radius: 20
                        color: "transparent"
                        border.color: parametri_generali.coloreBordo

                        TextInput {
                            id: input_nome
                            anchors.left:parent.left
                            anchors.right: parent.right
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter

                            text: ""
                            cursorVisible: false

                            color: parametri_generali.coloreBordo
                            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                            font.italic: false
                            font.letterSpacing: 0
                            font.pixelSize: 35
                            font.weight: Font.Normal
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignTop
                        }
                    }

                }

                Item { //INDIRIZZO
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 80

                    Item
                    {
                        anchors
                        {
                            top:parent.top
                            bottom:parent.bottom
                            left:parent.left
                            leftMargin: 70
                        }
                        width: 400-anchors.leftMargin

                        Text {
                            text: "INDIRIZZO"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: parametri_generali.coloreBordo
                            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                            font.italic: false
                            font.letterSpacing: 0
                            font.pixelSize: 35
                            font.weight: Font.Normal
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignTop

                        }
                    }
                    Rectangle
                    {
                        anchors
                        {
                            top:parent.top
                            bottom:parent.bottom
                            left:parent.right
                            leftMargin: 398
                        }
                        width: 447
                        radius: 20
                        color: "transparent"
                        border.color: parametri_generali.coloreBordo

                        TextInput {
                            id: input_cognome
                            anchors.left:parent.left
                            anchors.right: parent.right
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter

                            text: ""
                            cursorVisible: false

                            color: parametri_generali.coloreBordo
                            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                            font.italic: false
                            font.letterSpacing: 0
                            font.pixelSize: 35
                            font.weight: Font.Normal
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignTop
                        }
                    }

                }


            }
        }
    }
}
