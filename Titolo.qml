import QtQuick 2.12

Item {
//    anchors.fill: parent
    id: component
    property string text: "TITOLO"
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    anchors
    {
        left: parent.left
        right: parent.right
        top: parent.top
//        bottom: parent.bottom
    }
    height: parent.height
    Item{
        anchors
        {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        clip: true


//        height: parent.height
        z: 20

        Testo
        {
            text: component.text
            font.pixelSize: 70
            anchors
            {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
