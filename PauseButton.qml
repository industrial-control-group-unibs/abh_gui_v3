import QtQuick 2.0

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Rectangle {
    id : component
    width:400
    height: width
    radius: width*0.5
    property color colore: parametri_generali.coloreBordo //"#D4C9BD"
    property bool attivo: true

    border.color: colore
    border.width: 4*width/100
    color: "transparent"
    clip: true

    property double l: 0.6*component.width

    Rectangle
    {
        visible: component.attivo
       anchors
       {
           verticalCenter: parent.verticalCenter
           horizontalCenter: parent.horizontalCenter
           horizontalCenterOffset: -parent.l*0.3/2
       }
       width: parent.l*.4/2
       height: parent.l
       color: parent.colore
    }
    Rectangle
    {
        visible: component.attivo
       anchors
       {
           verticalCenter: parent.verticalCenter
           horizontalCenter: parent.horizontalCenter
           horizontalCenterOffset: parent.l*0.3/2
       }
       width: parent.l*.4/2
       height: parent.l
       color: parent.colore
    }
}
