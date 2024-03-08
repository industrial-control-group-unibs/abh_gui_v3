import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Item {

    signal pressUp
    signal pressDown

    property bool up: true
    property bool down: true
    id: component

    z: 10

    anchors
    {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
    }
    width: 0.4*parent.width

    height: 60
    property real margine: 2

    IconaUpDown
    {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        down: true

        visibile: component.down
        onPressed: {
            if (component.down)
                component.pressDown()
        }
    }
    IconaUpDown
    {
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }
        down: false
        visibile: component.up
        onPressed: {
            if (component.up)
                component.pressUp()
        }
    }


}
