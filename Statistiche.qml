

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls 2.3


import Charts 1.0

Item
{

    id: component

    property string xlabel: "SESSIONI"
    property string ylabel: "PUNTEGGIO"
    property string title: "PUNTEGGIO"
    property real xmin: 1.0
    property real xmax: 1.0
    property real ymin: 0.0
    property real ymax: 10.0
    property real xstep: 1.0
    property real ystep: 1.0
    property var xvalues
    property var yvalues
    property var yvalues2
    Component.onCompleted:
    {
        xvalues  = [0, 1, 2, 3, 4, 5, 6]
        yvalues  = [7, 8, 6, 7, 8, 8, 7]
        yvalues2 = [7, 7, 7, 7, 7, 7, 7]
    }

    Testo
    {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        //width: 40
        text: component.title
        id: titolo
    }
    Item
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: titolo.bottom
        Testo
        {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            rotation: 270
            text: component.ylabel
            id: xlab
            width: 0.05*parent.width
            fontSizeMode: Text.Fit
        }
        Testo
        {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: component.xlabel
            height: 0.05*parent*width
            id: ylab
            font.pixelSize: xlab.font.pixelSize
        }

        StatChart
        {
            id: stat
            anchors.left: xlab.right
            anchors.right: parent.right
            anchors.bottom: ylab.top
            anchors.top: parent.top

            Component.onCompleted:
            {
                setXmin(component.xmin)
                setYmin(component.ymin)
                setXmax(component.xmax)
                setYmax(component.ymax)
                setXStep(component.xstep)
                setYStep(component.ystep)
                setGridColor(parametri_generali.coloreBordo)

                addLine(component.xvalues,  component.yvalues,  parametri_generali.coloreUtente, parametri_generali.coloreUtente)
                addLine(component.xvalues,  component.yvalues2, parametri_generali.coloreBordo,"transparent")
            }
        }
    }



}

