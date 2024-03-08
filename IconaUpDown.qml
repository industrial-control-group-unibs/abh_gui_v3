import QtQuick 2.0

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Rectangle
{
    height: 100
    width: height
    radius: width*0.5


    id: component



    property bool down: false
    property bool black: true

    color: component.black? parametri_generali.coloreSfondo: parametri_generali.coloreBordo
    property color inner_color: component.black? parametri_generali.coloreBordo: parametri_generali.coloreSfondo
    border.color: parametri_generali.coloreBordo
    border.width: 5



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
    }


    Timer
    {
        id: repeater_timer
        interval: 200
        repeat: true
        running: false
        onTriggered:
        {
            component.pressed()

        }
    }

    onVisibleChanged:
    {
        if (!visible)
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
