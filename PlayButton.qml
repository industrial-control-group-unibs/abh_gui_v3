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
    property color colore: parametri_generali.coloreBordo
    property bool attivo: true

    border.color: colore
    border.width: 4*width/100
    color: "transparent"
    clip: true
    visible: attivo

    property double l: 0.6*component.width
    property double r: l*Math.sqrt(3./4.)



    Shape {
        visible: component.attivo
        anchors.fill: parent
        ShapePath {
            strokeWidth: 8*component.width/100

            strokeColor: "transparent"//component.colore
            fillColor: component.colore
            startX: component.width*0.5-component.r*0.33; startY: component.width*0.5-component.l*0.5
            PathLine { x: component.width*0.5+component.r*0.66; y: component.width*0.5 }
            PathLine { x: component.width*0.5-component.r*0.33; y: component.width*0.5+component.l*0.5 }
        }
    }
}
