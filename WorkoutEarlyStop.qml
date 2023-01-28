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
        text: "INTERROMPERE?"
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


    Timer{
        id: conto_alla_rovescia
        interval: 1000*60
        repeat: false
        running: parent.visible
        onTriggered:
        {
            exit()
        }
    }

}






