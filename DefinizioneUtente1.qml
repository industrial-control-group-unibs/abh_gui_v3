

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
        link_dx: "DefinizioneUtente2.qml"
        state: "sx"
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

        IconaCerchioVuoto{
            id: icona_scatta_foto
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: testo_utente.bottom
                topMargin: 90
            }
            link: "PaginaLogin.qml"
        }

        Text {
            id: testo_scatta_foto
            text: "SCATTA FOTO\nPROFILO"
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: icona_scatta_foto.bottom
                topMargin: 45
            }
            color: parametri_generali.coloreBordo
            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

            font.italic: false
            font.letterSpacing: 0
            font.pixelSize: 35
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop

        }

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
                Item { //NOME
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
                            text: "NOME"
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

                Item { //COGNOME
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
                            text: "COGNOME"
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
