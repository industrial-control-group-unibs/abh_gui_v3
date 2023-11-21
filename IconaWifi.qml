import QtQuick 2.0
import QtQuick.Shapes 1.12

Item {
implicitWidth: 300
height: width
property color color: "red"
property bool connesso: false
id: component
Rectangle
{
    width: component.width*0.1
    radius: 0.5*width
    height: component.width*0.1
    color:  component.color
    z: 15
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 0.1*parent.width
}
Rectangle
{
    width: 3*component.width*0.1
    radius: 0.5*width
    height: component.width*0.1
    color:  component.color
    z: 15
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 0.1*parent.width+component.width*0.1*2
}
Rectangle
{
    width: 5*component.width*0.1
    radius: 0.5*width
    height: component.width*0.1
    color:  component.color
    z: 15
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 0.1*parent.width+component.width*0.1*4
}

Rectangle
{
    visible: !component.connesso
    width: 9*component.width*0.1
    radius: 0.5*width
    height: component.width*0.1
    color:  component.color
    transform: Rotation { origin.x: component.width*0.3; origin.y: component.width*0.1; angle: 45}
    z: 15
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

}
}
