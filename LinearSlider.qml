import QtQuick 2.0
import QtGraphicalEffects 1.12


Item {
    id: component
    property real value: 10.0
    property real min: 0.0
    property real max: 20.0
    property real increment: 1.0

    implicitHeight: 10
    implicitWidth: 800



    property color color: parametri_generali.coloreBordo
    property color inner_color: parametri_generali.coloreSfondo


    signal increase
    signal decrease

    onIncrease: {
        component.value+=component.increment
        if (component.value>=component.max)
            component.value=component.max
    }

    onDecrease: {
        component.value-=component.increment
        if (component.value<=component.min)
            component.value=component.min
    }

    IconaMeno
    {
        color: parent.color
        inner_color: parent.inner_color
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        id: meno
        onPressed: component.decrease()
    }
    IconaPiu
    {
        color: parent.color
        inner_color: parent.inner_color
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        height: parent.height
        onPressed: component.increase()
        id: piu
    }

    Rectangle
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: meno.right
        anchors.right: piu.left
        anchors.leftMargin: meno.width*0.1
        anchors.rightMargin: meno.width*0.1
        height: parent.height

        //color: "white"


        RadialGradient {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: component.color}
                GradientStop { position: (component.value+component.max*0.1)/(component.max*2.0); color: "transparent" }
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onReleased: {
                if (mouse.x>width*0.5)
                {
                    component.increase()
                    console.log("più")
                }
                else
                {
                    component.decrease()
                    console.log("meno")
                }
            }
        }
    }

    Testo
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: (component.value)
        color: parametri_generali.coloreUtente

        font.pixelSize: 70// component.height
    }
}
