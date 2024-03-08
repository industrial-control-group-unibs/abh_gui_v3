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
        top: parent.top
        horizontalCenter: parent.horizontalCenter
    }
    width: parent.width
    height: 30

    property real margine: 4

    property real size: (width-3*margine)/2.0

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
            PropertyChanges { target: left_circle; color: component.bordo}
            PropertyChanges { target: right_circle; color: component.scuro}
        },
        State {
            name: "dx"
            PropertyChanges { target: right_circle; color: component.bordo}
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
        anchors.leftMargin: component.margine
        width: component.size
        radius: width*0.5
        color: parametri_generali.coloreBordo
    }

    Rectangle
    {
        id: right_circle
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: component.margine
        width: component.size
        radius: width*0.5
        color: "#4E4F5075"
    }

}
