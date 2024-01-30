

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    QuattroImmagini
    {
        immagine11: "mondi1.png"
        testo11: "ALLENAMENTO\n"
        link11: "PaginaAllenamento.qml"
        immagine12: "mondi2.png"
        testo12: "NUTRIZIONE\n"
        link12: "PaginaLogin.qml"
        immagine21: "mondi3.png"
        testo21: "PSICHE\n"
        link21: "PaginaLogin.qml"
        immagine22: "mondi4.png"
        testo22: "MEDITAZIONE\n"
        link22: "PaginaLogin.qml"
    }

//    Rectangle{
//        anchors.fill: parent
//        anchors.topMargin: parametri_generali.larghezza_barra
//        color: "transparent"//parametri_generali.coloreSfondo

//        clip: true


//            GridLayout {
//                id: mondi_layout
//                anchors.left: parent.left
//                anchors.right: parent.right
//                anchors.verticalCenter: parent.verticalCenter
//                columns: 2

//                Icona_4_3{
//                    nome: "ALLENAMENTO\n"
//                    link: "PaginaAllenamento.qml"
//                    immagine: "place_holder_4_3.png"
//                }

//                Icona_4_3{
//                    nome: "NUTRIZIONE\n"
//                    link: "PaginaLogin.qml"
//                    immagine: "place_holder_4_3.png"
//                }

//                Icona_4_3{
//                    nome: "PSICHE\n"
//                    link: "PaginaLogin.qml"
//                    immagine: "place_holder_4_3.png"
//                }

//                Icona_4_3{
//                    nome: "ALIMENTAZIONE\n"
//                    link: "PaginaLogin.qml"
//                    immagine: "place_holder_4_3.png"
//                }
//            }


//    }
}
