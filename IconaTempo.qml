import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    id: component
    signal pressed
    property color colore: parametri_generali.coloreBordo
    property int tempo: 0

    property string time_string: getTime()

    onTempoChanged:
    {
        console.log("time: ",tempo)
        time_string= getTime()
    }
    onTime_stringChanged: console.log("time: ",time_string)



    MouseArea
    {
        anchors.fill: parent
        onClicked: parent.pressed()
    }

    width:100
    height:width

    Rectangle {
        id:rect
        anchors.fill: parent
        anchors.margins: 2
        radius: width*0.5
        border.color: colore
        border.width: parent.bordo*width/100
        visible: false

    }

    RadialGradient {
        source: rect
        anchors.fill: parent
        horizontalRadius: width*.5
        verticalRadius: width*.5
        gradient: Gradient {

            GradientStop { position: 0.00; color: component.colore }
            GradientStop { position: 0.90; color: "transparent" }
            GradientStop { position: 1.00; color: component.colore }

        }

        Text {
            text:component.time_string
            anchors.fill: parent
            anchors.margins: parent.height*0.1
            color: parametri_generali.coloreUtente
            wrapMode: TextEdit.WordWrap
            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

            font.italic: false
            font.letterSpacing: 0
            font.pixelSize: 60
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit

        }
    }


    function getTime() {
        var hours   = Math.floor(tempo / 3600)
                                 var minutes = Math.floor((tempo-hours*3600) / 60)
                                 var seconds = Math.floor((tempo-hours*3600-minutes*60))
                                 return (hours>0?((hours < 10 ? "0" + hours : hours)+":"):"") +
                                 (minutes < 10 ? "0" + minutes : minutes) + ":" +
                                 (seconds < 10 ? "0" + seconds : seconds)
    }
}
