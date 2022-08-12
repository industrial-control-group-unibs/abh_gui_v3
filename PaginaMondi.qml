

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


            GridLayout {
                id: mondi_layout
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                columns: 2

                Icona_4_3{
                    nome: "ALLENAMENTO\n"
                    link: "PaginaAllenamento.qml"
                    immagine: "place_holder_4_3.png"
                }

                Icona_4_3{
                    nome: "NUTRIZIONE\n"
                    link: "PaginaLogin.qml"
                    immagine: "place_holder_4_3.png"
                }

                Icona_4_3{
                    nome: "PSICHE\n"
                    link: "PaginaLogin.qml"
                    immagine: "place_holder_4_3.png"
                }

                Icona_4_3{
                    nome: "ALIMENTAZIONE\n"
                    link: "PaginaLogin.qml"
                    immagine: "place_holder_4_3.png"
                }
            }


    }
}
