

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls 2.3



Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{id:barra}


    Tastiera
    {
        z: 4
        id: tastiera
        anchors.left: parent.left
        anchors.top: barra.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        colore: parametri_generali.coloreBordo
        font_colore: parametri_generali.coloreSfondo
    }

    Testo
    {
        id: testo

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: tastiera.testo
    }


}
