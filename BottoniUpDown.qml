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

    width: 340

    property real icon_width: (width-20)/2

    IconaUpDown
    {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        width: component.icon_width
        down: true
        visible: component.down
        onPressed: component.pressDown()
    }
    IconaUpDown
    {
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }
        width: component.icon_width
        down: false
        visible: component.up
        onPressed: component.pressUp()
    }


}
