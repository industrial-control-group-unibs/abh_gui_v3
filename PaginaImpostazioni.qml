

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        Text {
            text: "IMPOSTAZIONI"
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

        GridLayout {
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.verticalCenter: parent.verticalCenter
            columns: 2

            Icona_4_3{
                nome: "UTENTE\n"
                link: "PaginaLogin.qml"
                immagine: "place_holder_4_3.png"
            }

            Icona_4_3{
                nome: "CONNETIVITÀ\n"
                link: "PaginaLogin.qml"
                immagine: "place_holder_4_3.png"
            }

            Icona_4_3{
                nome: "SCHERMO-AUDIO\n"
                link: "PaginaLogin.qml"
                immagine: "place_holder_4_3.png"
            }

            Icona_4_3{
                nome: "LOG OUT\n"
                link: "PaginaLogin.qml"
                immagine: "place_holder_4_3.png"
            }
        }

    }
}
