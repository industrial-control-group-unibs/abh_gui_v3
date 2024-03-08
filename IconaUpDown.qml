import QtQuick 2.0

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Item
{
    height: 100
    width: height



    id: component



    property bool down: false
    property bool black: true
    property bool visibile: true
    property color inner_color: component.black? parametri_generali.coloreBordo: parametri_generali.coloreSfondo

    Rectangle
    {
        visible: component.visibile
        radius: width*0.5
        anchors.fill: parent
        border.color: parametri_generali.coloreBordo
        border.width: 5
        color: component.black? parametri_generali.coloreSfondo: parametri_generali.coloreBordo

    }

    signal pressed

    Testo
    {
        text: component.down?"↓":"↑"
        font.pixelSize: 60
        color: component.inner_color
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.bold: true
        visible: component.visibile
    }


    Timer
    {
        id: repeater_timer
        interval: 200
        repeat: true
        running: false
        onTriggered:
        {
            if (component.visibile)
                component.pressed()

        }
    }

    onVisibileChanged:
    {
        if (!component.visibile)
        {
            repeater_timer.running=false
            repeater_timer.repeat=false
        }
        else
        {
            repeater_timer.repeat=true
        }
    }

    MouseArea
    {
        anchors.fill: parent

        onPressed:
        {
            component.pressed()

        }

        onPressAndHold:
        {
            if (parent.visible)
            {
                repeater_timer.repeat=true
                repeater_timer.running=true
            }
        }

        onReleased:
        {
            repeater_timer.running=false
            repeater_timer.repeat=false
        }
    }
}
