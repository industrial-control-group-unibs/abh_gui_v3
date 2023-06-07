import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    id: component
    signal pressed
    property color colore: parametri_generali.coloreBordo
    property color colore2: parametri_generali.coloreUtente
    property bool pieno: true
    property real bordo: 5


    MouseArea
    {
        anchors.fill: parent
        onClicked: parent.pressed()
    }

    width:100
    height:width

    Rectangle {
        id:rect
        anchors.fill: parent
        anchors.margins: 2
        radius: width*0.5
        border.color: component.colore
        border.width: parent.bordo*width/100
        color: component.colore2
    }



}
