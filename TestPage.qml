

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls 2.3


import Charts 1.0

Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{id:barra}


    Rectangle
    {
        color: "transparent"
        border.color: parametri_generali.coloreBordo
        anchors.fill: parent
        anchors.margins: 60

        StatChart
        {
            id: stat

            anchors.fill: parent
            Component.onCompleted:
            {
                setYmax(10)
                addLine([0, 1, 2, 3, 3.5],[1, 5, 4, 5, 8],parametri_generali.coloreUtente,parametri_generali.coloreUtenteTrasparent)
                addLine([0, 1, 2, 3, 4],[3, 2, 1, 2, 2],"red","blue")
                addLine([0, 1, 2, 3, 4],[1, 2, 3, 4, 3],"yellow","transparent")

            }
        }

    }


}
