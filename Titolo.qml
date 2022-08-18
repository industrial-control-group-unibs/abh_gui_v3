import QtQuick 2.12

Item {
    anchors.fill: parent
    id: component
    property string text: "TITOLO"
    implicitHeight: 1920/2
    implicitWidth: 1080/2


    Item{
        anchors
        {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        clip: true


        height: parent.height*0.1

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
