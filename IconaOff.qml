import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12


Item
{
    height: 80
    width: height
    property color colore: parametri_generali.coloreBordo
    id: component

    property double strokeWidth: 5
    property double raggio: 0.5*(width-strokeWidth)
    signal pressed
    Shape {
        anchors.fill: parent




        ShapePath {
            strokeColor: component.colore
            strokeWidth: component.strokeWidth
            capStyle: ShapePath.RoundCap
            fillColor: "transparent"
            startX: component.width*0.5+component.raggio*Math.sin(.5)
            startY: component.width*0.5-component.raggio*Math.cos(.5)
            PathArc {
                x: component.width*0.5-component.raggio*Math.sin(.5)
                y: component.width*0.5-component.raggio*Math.cos(.5)
                radiusX: component.raggio
                radiusY: radiusX
                useLargeArc: true
            }
        }

        ShapePath {
            strokeColor: component.colore
            strokeWidth: component.strokeWidth
            capStyle: ShapePath.RoundCap
            fillColor: "transparent"
            startX: component.width*0.5
            startY: component.height*0.4
            PathLine { x: component.width*0.5; y: component.width*0.5-component.raggio }

        }
    }

    MouseArea
    {
        anchors.fill: parent
        onPressed: component.pressed()
    }
}
