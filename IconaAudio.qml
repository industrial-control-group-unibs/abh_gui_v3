import QtQuick 2.0
import QtQuick.Shapes 1.12

Item {
implicitWidth: 300
height: width
property color color: "red"
property bool active: false
id: component
Rectangle {
    anchors.fill: parent
    color: "transparent"
    clip: false

    Shape
    {
        anchors.fill: parent
        scale: component.width/75
        anchors.topMargin: height*-0.3
        anchors.leftMargin: width*-0.3
        visible: !component.active
        ShapePath {

            joinStyle: ShapePath.MiterJoin
            strokeColor: component.color
            strokeWidth:4
            fillColor: "transparent"//component.color
            fillRule: ShapePath.OddEvenFill

            startX: 48
            startY: 30
            PathLine { x: 68; y: 50 }

        }
        ShapePath {

            joinStyle: ShapePath.MiterJoin
            strokeColor: component.color
            strokeWidth:4
            fillColor: "transparent"//component.color
            fillRule: ShapePath.OddEvenFill

            startX: 48
            startY: 50
            PathLine { x: 68; y: 30 }

        }
    }

    Shape {
        anchors.fill: parent
        anchors.topMargin: height*-0.3
        anchors.leftMargin: width*-0.3
        scale: component.width/75
        visible: component.active
        ShapePath {

            joinStyle: ShapePath.MiterJoin
            strokeColor:component.color
            strokeWidth:4
            fillColor: "transparent"//component.color
            fillRule: ShapePath.OddEvenFill
            PathSvg {
                path: "M48,27.6a19.5,19.5 0 0 1 0,21.4M55.1,20.5a30,30 0 0 1 0,35.6M61.6,14a38.8,38.8 0 0 1 0,48.6"
            }
        }
    }

    Shape {
        anchors.fill: parent
        scale: component.width/75
        anchors.topMargin: height*-0.3
        anchors.leftMargin: width*-0.3
        ShapePath {
            joinStyle: ShapePath.MiterJoin
            strokeColor: component.color
            strokeWidth:1
            fillColor: component.color
            fillRule: ShapePath.OddEvenFill
            PathSvg {
                path: "M39.389,13.769 L22.235,28.606 L6,28.606 L6,47.699 L21.989,47.699 L39.389,62.75 L39.389,13.769z"
            }
        }
    }
}
}
