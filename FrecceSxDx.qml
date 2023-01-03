import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Item {

//    property string link_sx: "PaginaMondi.qml"
//    property string link_dx: "PaginaMondi.qml"

    signal pressSx
    signal pressDx
    property bool dx_visible: true
    property bool sx_visible: true

    property string colore: parametri_generali.coloreBordo
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
        anchors
        {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 113/1080*parent.width
        }
        reverse: true
        onPressed: component.pressSx()
    }

    IconaPlus
    {
        anchors
        {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 113/1080*parent.width
        }
        onPressed: component.pressDx()
    }


}


