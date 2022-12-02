import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    id: component
    signal pressed
    property color colore: parametri_generali.coloreSfondo
    property bool pieno: true

    state: "vuoto"
    states: [
        State {
            name: "pieno"
            PropertyChanges { target: component; pieno: true}
        },
        State {
            name: "vuoto"
            PropertyChanges { target: component; pieno: false}
        }
    ]

    MouseArea
    {
        anchors.fill: parent
        onClicked: parent.pressed()
    }

    width:100
    height:width

    Rectangle {
        id:rect
        anchors.fill: parent
        anchors.margins: 2
        radius: width*0.5
        border.color: colore
        border.width: parent.bordo*width/100
        visible: false

    }

    RadialGradient {
        source: rect
        anchors.fill: parent
        horizontalRadius: width*.5
        verticalRadius: width*.5
        gradient: Gradient {

            GradientStop { position: 0.00; color: "transparent" }
            GradientStop { position: 0.80; color: "transparent" }
            GradientStop { position: 0.81; color: "black" }
            GradientStop { position: 0.85; color: component.colore }
            GradientStop { position: 0.95; color: component.colore }
            GradientStop { position: 0.99; color: "black" }
            GradientStop { position: 1.00; color: "transparent" }
        }
    }
    RadialGradient {
        source: rect
        anchors.fill: parent
        horizontalRadius: width*.5
        verticalRadius: width*.5
        visible: component.pieno
        gradient: Gradient {
            GradientStop { position: 0.00; color: component.colore }
            GradientStop { position: 0.65; color: component.colore }
            GradientStop { position: 0.70; color: "black" }
            GradientStop { position: 0.7001; color: "transparent" }
            GradientStop { position: 1.00; color: "transparent" }
        }
    }

}
