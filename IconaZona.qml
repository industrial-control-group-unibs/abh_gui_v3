import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Item {
    width: lista_zona.width-2 //lista_zona.cellWidth-2
    implicitWidth: 800
    implicitHeight: 225
    property bool highlighted: false //lista_zona.currentIndex === index

    id: component


Rectangle   {


    //id: esercizio
    color: "transparent"
    //width: lista_zona.width-2 //lista_zona.cellWidth-2
    //height: 400

    anchors.fill: parent
    anchors.margins: 2



    implicitWidth: 800
    implicitHeight: 225
    radius: 20
    border.color: parametri_generali.coloreBordo
    border.width: component.highlighted? 8: 2


    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        onPressed: {
            mouse.accepted = false
            selected_exercise.name="unselected"
            zona_allenamento.gruppo=ex_name
            lista_zona.currentIndex=index
        }
    }



    Rectangle
    {
        visible: component.highlighted
        radius: parent.radius-parent.border.width
        anchors.fill: parent
        z: immagine_zona.z+1
        color: parametri_generali.coloreBordoTrasparent

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
        anchors
        {
            fill: parent
            leftMargin: 5
            rightMargin: 5
            topMargin: 5
            bottomMargin: 5
        }
        source: "file://"+PATH+"/zone/"+image_name
    }
}
}
