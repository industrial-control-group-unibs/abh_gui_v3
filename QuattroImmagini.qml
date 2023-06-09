

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2
    id: component

    property real ratio: 0.8
    property string immagine11: "place_holder_4_3.png"
    property string testo11: "ALLENAMENTO\n"
    property string link11: "PaginaAllenamento.qml"
    property string immagine12: "place_holder_4_3.png"
    property string testo12: "ALLENAMENTO2\n"
    property string link12: "PaginaAllenamento.qml"
    property string immagine21: "place_holder_4_3.png"
    property string testo21: "ALLENAMENTO\n LIBERO"
    property string link21: "PaginaAllenamento.qml"
    property string immagine22: "place_holder_4_3.png"
    property string testo22: "ALLENAMENTO\n"
    property string link22: "PaginaAllenamento.qml"

    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true


        Item {
            anchors
            {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: parent.height*.1
            }
            height: parent.height*0.9

            Icona_4_3{
                nome: component.testo11
                link: component.link11
                immagine: component.immagine11
                width: parent.width*0.5*component.ratio
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
                anchors.verticalCenterOffset: -parent.height*0.25
            }

            Icona_4_3{
                nome: component.testo12
                link: component.link12
                immagine: component.immagine12
                width: parent.width*0.5*component.ratio
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
                anchors.verticalCenterOffset: parent.height*0.25
            }

            Icona_4_3{
                nome: component.testo21
                link: component.link21
                immagine: component.immagine21
                width: parent.width*0.5*ratio
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                anchors.verticalCenterOffset: -parent.height*0.25
            }

            Icona_4_3{
                nome: component.testo22
                link: component.link22
                immagine: component.immagine22
                width: parent.width*0.5*component.ratio
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                anchors.verticalCenterOffset: parent.height*0.25
            }
        }
    }
}
