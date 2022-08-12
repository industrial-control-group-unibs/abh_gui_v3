import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Item {

    property string link_sx: "PaginaMondi.qml"
    property string link_dx: "PaginaMondi.qml"

    anchors
    {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    height: 274+50
    z: 5

    Item {
        layer.enabled:true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }

        anchors
        {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 113
        }

        width:80
        height:80

        Rectangle
        {
            anchors.fill: parent
            border.color: parametri_generali.coloreIcona
            border.width: 8
            radius: width*0.5
            color: "transparent"

            MouseArea
            {
                anchors.fill: parent
                onClicked: pageLoader.source=  link_sx
            }
        }


        Shape {
            width:36
            height:22
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            ShapePath {
                strokeColor: "transparent"
                strokeWidth:1
                fillColor:parametri_generali.coloreIcona
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M17.7171 21.8202C18.185 21.5677 18.4768 21.0876 18.4768 20.5655L18.4768 12.4346L34.5314 12.4346C35.3421 12.4346 36 11.7919 36 11.0001C36 10.2082 35.3421 9.56553 34.5314 9.56553L18.4768 9.56553L18.4768 1.43463C18.4768 0.910548 18.185 0.43046 17.7171 0.179896C17.2491 -0.0744932 16.6773 -0.0572789 16.225 0.220063L0.685341 9.78549C0.258472 10.0494 0 10.5066 0 11.0001C0 11.4935 0.258472 11.9507 0.685341 12.2146L16.225 21.78C16.4639 21.9254 16.736 22 17.0082 22C17.251 22 17.4958 21.9388 17.7171 21.8202Z"
                }
            }
        }

    }

    Item {
        layer.enabled:true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }



        anchors
        {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 113
        }

        width:80
        height:80

        Rectangle
        {
            anchors.fill: parent
            border.color: parametri_generali.coloreIcona
            border.width: 8
            radius: width*0.5
            color: "transparent"

            MouseArea
            {
                anchors.fill: parent
                onClicked: pageLoader.source=  link_dx
            }
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

            ShapePath {

                strokeColor: "transparent"
                strokeWidth:8
                fillColor:parametri_generali.coloreIcona
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M17.7171 21.8202C18.185 21.5677 18.4768 21.0876 18.4768 20.5655L18.4768 12.4346L34.5314 12.4346C35.3421 12.4346 36 11.7919 36 11.0001C36 10.2082 35.3421 9.56553 34.5314 9.56553L18.4768 9.56553L18.4768 1.43463C18.4768 0.910548 18.185 0.43046 17.7171 0.179896C17.2491 -0.0744932 16.6773 -0.0572789 16.225 0.220063L0.685341 9.78549C0.258472 10.0494 0 10.5066 0 11.0001C0 11.4935 0.258472 11.9507 0.685341 12.2146L16.225 21.78C16.4639 21.9254 16.736 22 17.0082 22C17.251 22 17.4958 21.9388 17.7171 21.8202Z"
                }
            }
        }

    }

}


