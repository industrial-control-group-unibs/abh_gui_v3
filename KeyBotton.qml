import QtQuick 2.0

Rectangle {

    property string font_colore: component.font_colore
    property string text: "A"
    color: component.colore;
    radius: width*0.1
    width: component.keysize;
    height: width
    Text {
        anchors.centerIn: parent
        font.pointSize: 24;
        font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

        text: parent.text
        color: parent.font_colore
    }
    MouseArea
    {
        anchors.fill: parent
        onPressed: {
            component.testo+=parent.text
            component.lettera=parent.text
        }
    }
}
