import QtQuick 2.12

Item
{
    Component.onCompleted: {
    }

    anchors
    {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    height: parent.height*0.3

    property bool is_visible: true


    signal cancel
    signal exit

    Testo
    {
        text: "CALIBRAZIONE IN CORSO\nCONTINUA A ESEGUIRE L'ESERCIZIO"
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 40
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter

        }
    }


}






