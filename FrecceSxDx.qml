import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Item {

    signal pressSx
    signal pressDx
    property bool dx_visible: true
    property bool sx_visible: true

    property string colore: parametri_generali.coloreBordo

    property bool black: false

    id: component

    anchors
    {
        left: parent.left
        right: parent.right
        verticalCenter: parent.verticalCenter
//        bottom: parent.bottom
    }
    height: 274+50
    z: 5

    IconaPlus
    {
        visible: component.sx_visible
        anchors
        {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 113/1080*parent.width
        }
        black: component.black
        reverse: true
        onPressed: component.pressSx()
    }

    IconaPlus
    {
        visible: component.dx_visible
        anchors
        {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 113/1080*parent.width
        }
        black: component.black
        onPressed: component.pressDx()
    }


}


