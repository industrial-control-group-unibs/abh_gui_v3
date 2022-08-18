import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12
import QtQml 2.12

CircularSlider {
    id: circularSlider
    anchors.centerIn: parent

    y: 800
    width: 100
    height: width

    trackWidth: 2
    progressWidth: 3
    handleWidth: 13
    handleHeight: handleWidth
    handleRadius: handleWidth*.5
    handleVerticalOffset: 0

    startAngle: 0
    endAngle: 360
    minValue: 0
    maxValue: 10
    snap: true
    stepSize: 1
    value: 1

    handleColor: "#4E4F50"
    trackColor: "#4E4F50"
    progressColor: "#D4C9BD"
    rotation: 0

    hideTrack: false
    hideProgress: false


    Text {
        text:Number(circularSlider.value).toFixed()
        anchors
        {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        color: parametri_generali.coloreBordo
        wrapMode: TextEdit.WordWrap
        font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 30
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignTop

    }
}
