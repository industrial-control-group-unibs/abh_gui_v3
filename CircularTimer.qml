import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


CircularSlider {
    id: progressIndicator
    hideProgress: true
    hideTrack: true
    width: 120
    height: width

    property color colore: parametri_generali.coloreBordo


    interactive: false
    property int tacche: 60
    property double tempo: 0.0

    Text {
        text: time_string

        property string time_string: getTime()

        function getTime() {
            var hours   = Math.floor(tempo*.001 / 3600)
            var minutes = Math.floor((tempo*.001-hours*3600) / 60)
            var seconds = Math.floor((tempo*.001-hours*3600-minutes*60))
            return hours>0?((hours < 10 ? "0" + hours : hours)+":"):"" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds)
        }

        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        color: progressIndicator.colore
        font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 30
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
    }

    Repeater {
        model: progressIndicator.tacche

        Rectangle {
            id: indicator1
            width: 4
            height: width
            radius: width / 2
            color: indicator1.angle > progressIndicator.angle ? "transparent" : progressIndicator.colore
            readonly property real angle: index * 360/progressIndicator.tacche
            transform: [
                Translate {
                    x: progressIndicator.width / 2 - width / 2
                },
                Rotation {
                    origin.x: progressIndicator.width / 2
                    origin.y: progressIndicator.height / 2
                    angle: indicator1.angle
                }
            ]
        }
    }
}
