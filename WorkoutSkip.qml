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
        text: "PASSARE ALLA SERIE SUCCESSIVA?"
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 5
        }
    }
    SiNo
    {
        onPressNo: cancel()
        onPressYes: exit()
    }

}






