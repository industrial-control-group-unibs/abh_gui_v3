import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12



Item {
    id: riga
    property real value: 0.8
    property real label: riga.motore? 100.0*(-1+2*riga.value):100.0*riga.value
    property bool motore: false
    property real larghezza: 100
    property real altezza: 100
    Testo
    {
        anchors.top: parent.top
        anchors.leftMargin: parent.width*0.1
        anchors.topMargin: parent.height*(1-riga.value)-height*0.5
        anchors.right: parent.left
        anchors.rightMargin: parent.width*0.02
        height: parent.height*0.1
        width: parent.width*0.1
        font.pixelSize: 20
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        text: riga.label.toFixed(0).toString()
        color: parametri_generali.coloreUtente
    }

    Shape {
        anchors.fill: parent
        ShapePath {
            strokeColor: parametri_generali.coloreBordo
            strokeWidth: 2.0
            startX: 0
            startY: riga.altezza*(1.0-riga.value)
            PathLine { x: riga.larghezza; y: riga.altezza*(1.0-riga.value) }
        }
    }
}
