import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Rectangle   {


    //id: esercizio
    color: "transparent"
    width: lista_workout.width-2 //lista_workout.cellWidth-2
    //height: 400

    implicitWidth: 800
    implicitHeight: 225
    radius: 20
    border.color:  lista_workout.currentIndex !== index ? parametri_generali.coloreSfondo: parametri_generali.coloreBordo
    border.width: 5

    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        onPressed: {
//            mouse.accepted = false
            selected_exercise.workout=ex_name
            lista_workout.currentIndex=index
        }
    }

    OpacityMask {
        anchors.fill:zona_mask
        source: immagine_zona
        maskSource: zona_mask
    }

    Rectangle
    {
        id: zona_mask
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

    Testo
    {
        text:ex_name
        font.pixelSize: 70
        anchors
        {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
    }


    Image {
        id: immagine_zona
        layer.enabled: true
        fillMode: Image.Stretch
        visible: false
        mipmap: true
        asynchronous: true
        anchors
        {
            fill: parent
            leftMargin: 5
            rightMargin: 5
            topMargin: 5
            bottomMargin: 5
        }
        source: "file://"+PATH+"/allenamento_programmato/"+image_name
    }
}
