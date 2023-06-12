import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

IconaRettangolo
{

    id:component

    property string titolo: "TITOLO"
    property string date: "01-01-2200"

    property string tempo: "15 h 30 m"
    property color color2: "blue"
    property real progress: 0.5
    property real punteggio: 8.5

    property real fontSize: 50
    text: titolo==="+"?titolo:""



    Item {
        anchors.fill: parent
        visible: titolo!=="+"

        Item {
            id: primo_terzo
            anchors
            {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width*0.4

            Item {
                id: titolo_txt
                anchors
                {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    leftMargin: parent.height*0.1
                    topMargin: parent.height*0.1
                }
                height: parent.height*0.3

                Testo
                {

                    text:component.titolo.replace("_", " ")
                    font.pixelSize: component.fontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    wrapMode: Text.WordWrap
                }
            }

            Testo
            {
                visible: component.date!==""
                id: date_txt
                text:qsTr("INIZIO")+" : "+component.date
                font.pixelSize: component.fontSize*0.3
                verticalAlignment: Text.AlignVCenter

                anchors
                {
                    left: titolo_txt.left
                    top: titolo_txt.bottom
                }
            }

            Rectangle
            {
                id: barra_tempo
                color: component.color2
                height: parent.height*0.1
                radius: height*0.5

                anchors
                {
                    left: titolo_txt.left
                    right: parent.right
                    bottom: parent.bottom
                    bottomMargin: titolo_txt.anchors.leftMargin
                    rightMargin: titolo_txt.anchors.leftMargin
                }
            }

            Testo
            {
                visible: component.tempo!==""
                id: tempo_txt
                text:qsTr("TEMPO IMPIEGATO")
                font.pixelSize: component.fontSize*0.3
                verticalAlignment: Text.AlignVCenter

                anchors
                {
                    left: date_txt.left
                    leftMargin: barra_tempo.radius
                    top: barra_tempo.top
                    bottom: barra_tempo.bottom
                    //bottom: barra_tempo.top
                    //bottomMargin: parent.height*0.1
                }
            }

            Testo
            {
                visible: component.tempo!==""
                id: tempo_txt2
                text:component.tempo
                font.pixelSize: component.fontSize*0.3
                verticalAlignment: Text.AlignVCenter

                anchors
                {
                    right: barra_tempo.right
                    rightMargin: barra_tempo.radius
                    top: barra_tempo.top
                    bottom: barra_tempo.bottom
                    //bottom: barra_tempo.top
                    //bottomMargin: parent.height*0.1

                }
            }
        }


        Item {
            id: secondo_terzo
            anchors
            {
                left: primo_terzo.right
                top: parent.top
                topMargin: parent.height*0.1
                bottom: parent.bottom
            }
            width: parent.width*0.3


            Testo
            {
                text:qsTr("AVANZAMENTO")
                font.pixelSize: component.fontSize*0.5
                verticalAlignment: Text.AlignVCenter

                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: parent.height*0.1
                }
            }

            CircularIndicator
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height*0.5
                //width: height*0.5
                stepSize: 0.01
                trackColor: component.color
                trackWidth: 0.05*width
                progressWidth: trackWidth
                handleColor: "transparent"
                progressColor: component.color2
                value: component.progress


                Testo
                {
                    text: (component.progress*100).toFixed(0).toString()
                    font.pixelSize: component.fontSize*0.3
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: component.color
                    anchors
                    {
                        fill:parent
                    }
                }
            }


        }


        Item {
            id: terzo_terzo
            anchors
            {
                left: secondo_terzo.right
                right: parent.right
                top: parent.top
                topMargin: parent.height*0.1
                bottom: parent.bottom
            }

            Testo
            {
                text:qsTr("PUNTEGGIO")
                font.pixelSize: component.fontSize*0.5
                verticalAlignment: Text.AlignVCenter

                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: parent.height*0.1
                }
            }

            CircularIndicator
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height*0.5
                //width: height*0.5
                stepSize: 0.01
                maxValue: 10
                trackColor: component.color
                trackWidth: 0.05*width
                progressWidth: trackWidth
                handleColor: "transparent"
                progressColor: component.color2
                value: component.punteggio


                Testo
                {
                    text: (component.punteggio).toFixed(1).toString()
                    font.pixelSize: component.fontSize*0.3
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: component.color
                    anchors
                    {
                        fill:parent
                    }
                }
            }
        }
    }

}
