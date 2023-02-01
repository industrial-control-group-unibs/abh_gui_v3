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

    width: 220+height*2
    height: 60

    property real ratio: 0.5
    property color scuro: parametri_generali.coloreSfondo
    property color bordo: parametri_generali.coloreBordo
    property color sfondo: parametri_generali.coloreSfondo

    onStateChanged:
    {
        scuro=Qt.rgba(bordo.r* (1.0-ratio) + sfondo.r*ratio,
                   bordo.g* (1.0-ratio) + sfondo.g*ratio,
                   bordo.b* (1.0-ratio) + sfondo.b*ratio,
                   1)

    }

    states: [
        State {
            name: "sx"
            PropertyChanges { target: left_circle; color: parametri_generali.coloreBordo}
            PropertyChanges { target: right_circle; color: component.scuro}
        },
        State {
            name: "dx"
            PropertyChanges { target: right_circle; color: parametri_generali.coloreBordo}
            PropertyChanges { target: left_circle; color: component.scuro}
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
        color: parametri_generali.coloreBordo
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
