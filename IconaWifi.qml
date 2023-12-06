import QtQuick 2.0
import QtQuick.Shapes 1.12

Item {
implicitWidth: 300
height: width
property color color: "red"
property bool connesso: false
id: component

Shape {
    anchors.fill: parent
    scale: component.width/288/1.5

    ShapePath {

        joinStyle: ShapePath.MiterJoin
        strokeColor: component.color
        strokeWidth: 2
        fillColor: component.color
        fillRule: ShapePath.WindingFill
        PathSvg {
            path: "M144 174c-17 0-34 7-45 20-10 12-28-4-18-16 16-18 39-28 63-28s47 10 63 28c10 12-8 28-18 16-11-13-28-20-45-20zm0 84c-13 0-24-11-24-24s11-24 24-24 24 11 24 24-11 24-24 24zm0-144c-32 0-61 11-84 34-10 10-29-5-17-17 27-27 63-41 101-41s74 14 101 41c12 12-7 27-17 17-23-23-52-34-84-34zm0-60c-46 0-89 17-122 48-12 11-29-6-17-17 39-36 87-55 139-55s100 19 139 55c12 11-5 28-17 17-33-31-76-48-122-48z"
        }
    }
}

Shape
{
    anchors.fill: parent
    scale: component.width/288/1.5
    visible: !component.connesso
    ShapePath {

        joinStyle: ShapePath.MiterJoin
        strokeColor: component.color
        strokeWidth: 32
        fillColor: "transparent"//component.color
        fillRule: ShapePath.OddEvenFill

        startX: 30
        startY: 30
        PathLine { x: 258; y: 258 }

    }
}

//Rectangle
//{
//    visible: !component.connesso
//    width: 9*component.width*0.1
//    radius: 0.5*width
//    height: component.width*0.1
//    color:  component.color
//    transform: Rotation { origin.x: component.width*0.3; origin.y: component.width*0.1; angle: 45}
//    z: 15
//    anchors.horizontalCenter: parent.horizontalCenter
//    anchors.verticalCenter: parent.verticalCenter

//}


//Rectangle
//{
//    width: component.width*0.1
//    radius: 0.5*width
//    height: component.width*0.1
//    color:  component.color
//    z: 15
//    anchors.horizontalCenter: parent.horizontalCenter
//    anchors.bottom: parent.bottom
//    anchors.bottomMargin: 0.1*parent.width
//}
//Rectangle
//{
//    width: 3*component.width*0.1
//    radius: 0.5*width
//    height: component.width*0.1
//    color:  component.color
//    z: 15
//    anchors.horizontalCenter: parent.horizontalCenter
//    anchors.bottom: parent.bottom
//    anchors.bottomMargin: 0.1*parent.width+component.width*0.1*2
//}
//Rectangle
//{
//    width: 5*component.width*0.1
//    radius: 0.5*width
//    height: component.width*0.1
//    color:  component.color
//    z: 15
//    anchors.horizontalCenter: parent.horizontalCenter
//    anchors.bottom: parent.bottom
//    anchors.bottomMargin: 0.1*parent.width+component.width*0.1*4
//}


}
