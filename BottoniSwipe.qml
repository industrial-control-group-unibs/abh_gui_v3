import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Item {

    signal pressLeft
    signal pressRight

    state: "sx"
    id: component
//    onStateChanged:
//    {
//        if (state==="dx")
//        {
//            pressRight()
//        }
//        if (state==="sx")
//        {
//            pressLeft()
//        }
//    }

    states: [
        State {
            name: "sx"
            PropertyChanges { target: left_circle; color: "#D4C9BD"}
            PropertyChanges { target: right_circle; color: "#4E4F5075"}
        },
        State {
            name: "dx"
            PropertyChanges { target: right_circle; color: "#D4C9BD"}
            PropertyChanges { target: left_circle; color: "#4E4F5075"}
        }
    ]

    MouseArea{
        anchors.fill: parent
        onReleased: {
            if (mouse.x>width*0.5)
            {
                if (component.state==="sx")
                    component.pressRight()
                parent.state= "dx"
            }
            else
            {
                if (component.state==="dx")
                    component.pressLeft()
                parent.state= "sx"
            }
        }
    }

    z: 10
    anchors
    {
        bottom: parent.bottom
        bottomMargin: 35
        horizontalCenter: parent.horizontalCenter
    }
    width: 77+20
    height: 20

    Rectangle
    {
        id: left_circle
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: height
        radius: width*0.5
        color: "#D4C9BD"
    }

    Rectangle
    {
        id: right_circle
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: height
        radius: width*0.5
        color: "#4E4F5075"
    }

}
