import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Item {

    signal pressLeft
    signal pressRight

    state: "sx"
    id: component

    z: 10
    anchors
    {
        bottom: parent.bottom
        bottomMargin: 35
        horizontalCenter: parent.horizontalCenter
    }
    width: 220+height*2
    height: 60


    states: [
        State {
            name: "sx"
            PropertyChanges { target: left_circle; color: parametri_generali.coloreBordo}
            PropertyChanges { target: right_circle; color: parametri_generali.coloreBordo+"55"}
        },
        State {
            name: "dx"
            PropertyChanges { target: right_circle; color: parametri_generali.coloreBordo+"55"}
            PropertyChanges { target: left_circle; color: parametri_generali.coloreBordo}
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



    Rectangle
    {
        id: left_circle
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: height
        height: parent.height
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
        height: parent.height
        radius: width*0.5
        color: "#4E4F5075"
    }

}
