import QtQuick 2.0
import QtGraphicalEffects 1.12


Item {
    id: component
    property real min: 0.0
    property real max: 20.0

    property var lista: [qsTr("ESORDIENTE"), qsTr("INTERMEDIO"), qsTr("ESPERTO")]
    property int index: 0
    property string value: lista[index]

    implicitHeight: 10
    implicitWidth: 800



    property color color: parametri_generali.coloreUtente

    property color text_color: parametri_generali.coloreBordo


    signal increase
    signal decrease

    onIncrease: {
        component.index+=1
        if (component.index>=component.lista.length)
            component.index=component.lista.length-1
    }

    onDecrease: {
        component.index-=1
        if (component.index<0)
            component.index=0
    }

    IconaMeno
    {
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        id: meno
        black: true
        onPressed: component.decrease()
    }

    IconaPlus
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        height: parent.height
        onPressed: component.increase()
        black: true
        id: piu
    }

    Item
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: meno.right
        anchors.right: piu.left
        anchors.leftMargin: meno.width*0.1
        anchors.rightMargin: meno.width*0.1
        height: parent.height*0.75

        RadialGradient {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: component.color}
                GradientStop { position: (component.index+1 +component.lista.length*0.4)/(component.lista.length*3.0); color: "transparent" }
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onReleased: {
                if (mouse.x>width*0.5)
                {
                    component.increase()
                }
                else
                {
                    component.decrease()
                }
            }
        }
    }

    Testo
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: component.lista[component.index]
        color: component.text_color

        font.pixelSize: 30// component.height
    }
}
