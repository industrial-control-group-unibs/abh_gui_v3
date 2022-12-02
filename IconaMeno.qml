import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12


Rectangle
{
    height: 100
    width: height
    radius: width*0.5
    border.color: parametri_generali.coloreBordo
    color: "transparent"
    border.width: 5
    id: icona_meno

    signal pressed
    Shape {
        anchors.fill: parent


        ShapePath {
            strokeColor: parametri_generali.coloreBordo
            strokeWidth: 5
            startX: icona_meno.width*0.3
            startY: icona_meno.height*0.5
            PathLine { x: icona_meno.width*0.7; y: icona_meno.height*0.5 }
        }
    }


    Timer
    {
        id: repeater_timer
        interval: 200
        repeat: true
        running: false
        onTriggered:
        {
            icona_piu.pressed()
        }
    }

    MouseArea
    {
        anchors.fill: parent

        onPressed:
        {
            icona_meno.pressed()

        }
        onPressAndHold: repeater_timer.running=true
        onReleased:
        {
            repeater_timer.running=false
        }
    }
}
