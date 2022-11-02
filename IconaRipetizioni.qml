import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    id: component
    signal pressed
    property color colore: "#D4C9BD"
    property int ripetizioni: 0



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

            GradientStop { position: 0.00; color: component.colore }
            GradientStop { position: 0.90; color: "transparent" }
//            GradientStop { position: 0.99; color: component.colore }
            GradientStop { position: 1.00; color: component.colore }
//            GradientStop { position: 0.00; color: "transparent" }
//            GradientStop { position: 0.95; color: component.colore }
//            GradientStop { position: 1.00; color: "black" }

        }

        Text {
            text:Number(component.ripetizioni).toFixed()
            anchors
            {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            color: parametri_generali.coloreUtente
            wrapMode: TextEdit.WordWrap
            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

            font.italic: false
            font.letterSpacing: 0
            font.pixelSize: 60
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop

        }
    }


}
