import QtQuick 2.0
import QtQuick.Shapes 1.12
Item
{

    id: component

    property real value: 1.0
    property real step: 0.1
    property string name: "POSITIVE VELOCITY THRESHOLD"
    Item
    {   anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width*0.6

        Testo
        {
            anchors.fill: parent
            font.pixelSize: 20
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            text: component.name
            color: parametri_generali.coloreUtente
        }
    }
    Item
    {   anchors.right: parent.right
        anchors.rightMargin: parent.height*0.05
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width*0.3
        IconaMeno
        {
            height: parent.height*0.5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            black: true
            onPressed:
            {
                component.value-=component.step
                if (component.value<1e-4)
                    component.value=0

            }
        }
        IconaPlus
        {
            height: parent.height*0.5
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            black: true
            onPressed:
            {
                component.value+=component.step
            }
        }
        Testo
        {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            font.pixelSize: 20
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            text: component.value.toPrecision(2)
            color: parametri_generali.coloreUtente
        }
    }
}
