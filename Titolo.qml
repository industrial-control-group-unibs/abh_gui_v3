import QtQuick 2.12

Item {
    id: component
    property string text: "TITOLO"
    property int fontSize: 70
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    anchors
    {
        left: parent.left
        right: parent.right
        top: parent.top
    }
    height: parent.height
    Item{
//        anchors
//        {
//            left: parent.left
//            right: parent.right
//            top: parent.top
//            bottom: parent.bottom
//        }
        anchors.fill: parent

        clip: true


        z: 20

        Testo
        {
            text: component.text
            font.pixelSize: component.fontSize
//            anchors
//            {
//                verticalCenter: parent.verticalCenter
//                horizontalCenter: parent.horizontalCenter
//            }
            anchors.fill: parent
            anchors.margins: 10
            fontSizeMode: Text.Fit
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

        }
    }
}
