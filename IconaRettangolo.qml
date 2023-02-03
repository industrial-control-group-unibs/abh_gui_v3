import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Item {
    implicitWidth: 800
    implicitHeight: 225

    property bool highlighted: true

    property real margin: 2
    property real bordo: component.highlighted? 8: 2
    property real radius: 20

    property color color: parametri_generali.coloreBordo
    property color colorTransparent: Qt.rgba(color.r, color.g, color.b, 0.440)
    id: component

    signal pressed
    signal pressAndHold

    property string text: ""

    Item {
        visible: component.text==="+"
        anchors.fill: parent
        Rectangle
        {
            color: component.color
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 0.5*parent.height
            width: 0.1*height
            radius: width*0.5
        }
        Rectangle
        {
            color: component.color
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: 0.5*parent.height
            height: 0.1*width
            radius: width*0.5
        }
    }

    Testo
    {
        visible: component.text!=="+"
        text:component.text
        font.pixelSize: 70
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors
        {
            //verticalCenter: parent.verticalCenter
            //horizontalCenter: parent.horizontalCenter
            fill: parent
        }
    }

    Rectangle   {

        id: icona
        color: "transparent"
        anchors.fill: parent
        anchors.margins: component.margin

        radius: component.radius
        border.color: component.color
        border.width: component.bordo

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onPressed: {
                component.pressed()
            }
            onPressAndHold: component.pressAndHold()
        }

        Rectangle
        {
            visible: component.highlighted
            radius: parent.radius
            anchors.fill: icona
            z: component.z+4
            color: component.colorTransparent
        }
    }



}