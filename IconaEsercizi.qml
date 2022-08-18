import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Rectangle   {


    color: "transparent"
    width: grid.cellWidth-2
    height: grid.cellHeight-2
    radius: 20
    border.color:  grid.currentIndex !== index ? parametri_generali.coloreSfondo: parametri_generali.coloreIcona
    border.width: 3


    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        onPressed: {
            mouse.accepted = false
            console.log("clicked")
            selected_exercise.name= ex_name
            selected_exercise.workout=""
            selected_exercise.sets=1
            selected_exercise.reps=5000
            grid.currentIndex=index
        }
    }


    Rectangle
    {
        id: esercizio_mask
        anchors
        {
            fill: parent
            topMargin: parent.border.width
            bottomMargin: parent.border.width
            leftMargin: parent.border.width
            rightMargin: parent.border.width
        }
        visible: false
        color: "white"
        radius: parent.radius-parent.border.width
    }

    OpacityMask {
        anchors.fill:esercizio_mask
        source: immagine_esercizio
        maskSource: esercizio_mask
    }

    Image {
        id: immagine_esercizio
        layer.enabled: true
        fillMode: Image.Stretch
        visible: false
        mipmap: true
        anchors.fill: parent
        source: "file://"+PATH+"/images/"+_esercizi.getImage(ex_name)
    }
}
