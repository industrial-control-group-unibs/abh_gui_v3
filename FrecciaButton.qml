import QtQuick 2.0

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Rectangle {
    id : component
    width:80
    height: width
    radius: width*0.5
    property color colore: "#D4C9BD"
    property bool attivo: true

    border.color: colore
    border.width: 4*width/100
    color: "transparent"
    clip: true
    visible: attivo

    property double l: 0.6*component.width
    property double r: l*Math.sqrt(3./4.)

    signal press
    MouseArea
    {
        anchors.fill: parent
        onPressed: parent.press()
    }
    Shape {
        width:36
        height:22
        rotation: 180
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

//        anchors.fill: parent

        ShapePath {

            strokeColor: "transparent"
            strokeWidth:8*component.width/100
            fillColor: component.colore
            fillRule: ShapePath.WindingFill
            PathSvg {
                path: "M17.7171 21.8202C18.185 21.5677 18.4768 21.0876 18.4768 20.5655L18.4768 12.4346L34.5314 12.4346C35.3421 12.4346 36 11.7919 36 11.0001C36 10.2082 35.3421 9.56553 34.5314 9.56553L18.4768 9.56553L18.4768 1.43463C18.4768 0.910548 18.185 0.43046 17.7171 0.179896C17.2491 -0.0744932 16.6773 -0.0572789 16.225 0.220063L0.685341 9.78549C0.258472 10.0494 0 10.5066 0 11.0001C0 11.4935 0.258472 11.9507 0.685341 12.2146L16.225 21.78C16.4639 21.9254 16.736 22 17.0082 22C17.251 22 17.4958 21.9388 17.7171 21.8202Z"
            }
        }
    }

//    Shape {
//        visible: component.attivo
//        anchors.fill: parent
//        ShapePath {
//            strokeWidth: 8*component.width/100

//            strokeColor: "transparent"//component.colore
//            fillColor: component.colore
//            startX: component.width*0.5-component.r*0.33; startY: component.width*0.5-component.l*0.5
//            PathLine { x: component.width*0.5+component.r*0.66; y: component.width*0.5 }
//            PathLine { x: component.width*0.5-component.r*0.33; y: component.width*0.5+component.l*0.5 }
//        }
//    }
}


