import QtQuick 2.0

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Rectangle
{
    height: 100
    width: height
    radius: width*0.5


    id: component




    property real size: height*0.2
    property bool reverse: false

    property real sign: reverse? -1.0: 1.0

    property bool black: true

    color: component.black? parametri_generali.coloreSfondo: parametri_generali.coloreBordo
    property color inner_color: component.black? parametri_generali.coloreBordo: parametri_generali.coloreSfondo
    border.color: parametri_generali.coloreBordo
    border.width: 5



    signal pressed

    Testo
    {
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        text: "LOGOUT"
    }

//    Shape {

//        width:53.68
//        height:63
//        anchors
//        {
//            horizontalCenter: parent.horizontalCenter
//            verticalCenter: parent.verticalCenter
//        }

//        ShapePath {
//            strokeColor: "transparent"
//            strokeWidth:1
//            fillColor: "red" //component.color

//            PathSvg {
//                path: "M23.625 41.4977C36.4354 41.4977 47.25 43.7166 47.25 52.2859C47.25 60.8552 36.366 63 23.625 63C10.8146 63 0 60.7778 0 52.2119C0 43.6426 10.8808 41.4977 23.625 41.4977ZM53.5468 16.5789C55.1099 16.5789 56.3785 17.9366 56.3785 19.6017L56.3785 23.5019L60.1682 23.5019C61.7281 23.5019 63 24.8595 63 26.5246C63 28.1897 61.7281 29.5473 60.1682 29.5473L56.3785 29.5473L56.3785 33.451C56.3785 35.116 55.1099 36.4737 53.5468 36.4737C51.9869 36.4737 50.715 35.116 50.715 33.451L50.715 29.5473L46.9318 29.5473C45.3686 29.5473 44.1 28.1897 44.1 26.5246C44.1 24.8595 45.3686 23.5019 46.9318 23.5019L50.715 23.5019L50.715 19.6017C50.715 17.9366 51.9869 16.5789 53.5468 16.5789ZM23.625 0C32.3019 0 39.2573 7.41619 39.2573 16.6679C39.2573 25.9197 32.3019 33.3359 23.625 33.3359C14.9481 33.3359 7.99271 25.9197 7.99271 16.6679C7.99271 7.41619 14.9481 0 23.625 0Z"
//            }
//        }
//    }

    Timer
    {
        id: repeater_timer
        interval: 200
        repeat: true
        running: false
        onTriggered:
        {
            component.pressed()

        }
    }

    onVisibleChanged:
    {
        if (!visible)
        {
            repeater_timer.running=false
            repeater_timer.repeat=false
        }
        else
        {
            repeater_timer.repeat=true
        }
    }

    MouseArea
    {
        anchors.fill: parent

        onPressed:
        {
            component.pressed()

        }

        onPressAndHold:
        {
            if (parent.visible)
            {
                repeater_timer.repeat=true
                repeater_timer.running=true
            }
        }

        onReleased:
        {
            repeater_timer.running=false
            repeater_timer.repeat=false
        }
    }
}

/*##^##
Designer {
    D{i:5;invisible:true}
}
##^##*/
