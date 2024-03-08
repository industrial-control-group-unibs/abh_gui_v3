import QtQuick 2.0

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Item
{
    height: 100
    width: height


    id: component





    property real size: height*0.2
    property bool reverse: false

    property real sign: reverse? -1.0: 1.0

    property bool black: false
    property bool visibile: true


    property color inner_color: component.black? parametri_generali.coloreBordo: parametri_generali.coloreSfondo



    signal pressed

    Rectangle
    {
        anchors.fill: parent
        radius: width*0.5
        color: component.black? parametri_generali.coloreSfondo: parametri_generali.coloreBordo
        border.color: parametri_generali.coloreBordo
        border.width: 5
        visible: component.visibile

        Shape {
            anchors.fill: parent

            ShapePath {
                strokeColor: component.inner_color
                strokeWidth: 5
                startX: component.height*0.5 + component.sign*component.size*0.5
                startY: component.height*0.5
                PathLine { x: component.height*0.5 - component.sign*component.size*0.5; y: component.height*0.5 - component.size}
            }
            ShapePath {
                strokeColor: component.inner_color
                strokeWidth: 5
                startX: component.height*0.5 + component.sign*component.size*0.5
                startY: component.height*0.5
                PathLine { x: component.height*0.5 - component.sign*component.size*0.5; y: component.height*0.5 + component.size}
            }
        }

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
    }

    onVisibleChanged:
    {
        if (!visibile)
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
