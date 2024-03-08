import QtQuick 2.0

Rectangle {
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: parametri_generali.larghezza_barra

    color:parametri_generali.coloreSfondo
    id: component
    signal pressSx
    signal pressDx
    signal pressUp
    signal pressDown
    signal swipeSx
    signal swipeDx
    property bool dx_visible: true
    property bool sx_visible: true
    property bool up_visible: true
    property bool down_visible: true
    property bool swipe_sx: true
    property bool swipe_visible: true

FrecceSxDx
{
    onPressSx: component.pressSx()
    onPressDx: component.pressDx()
    dx_visible: component.dx_visible
    sx_visible: component.sx_visible
    colore: parametri_generali.coloreBordo
}
BottoniUpDown
{
    anchors
    {
        top: parent.top
        topMargin: 20
        horizontalCenter: parent.horizontalCenter
    }
    width: 0.4*parent.width

    up: component.up_visible
    down: component.down_visible
    onPressDown: component.pressDown()
    onPressUp: component.pressUp()
}


BottoniSwipe2{
    visible: component.swipe_visible
    z:5
    bordo: parametri_generali.coloreUtente
    onPressLeft: component.swipeSx()
    onPressRight: component.swipeDx()
    state: component.swipe_sx?"sx":"dx"
}


}
