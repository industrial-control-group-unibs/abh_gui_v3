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
    property string tut: "10 h 00 m"
    property color color2: "blue"
    property real progress: 0.5
    property real punteggio: 8.5

    property real fontSize: 50
    text: titolo==="+"?titolo:""

    signal seeStat


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
                text:"INIZIO: "+component.date
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
                width: parent.width*0.4
                anchors
                {
                    left: titolo_txt.left

                    bottom: parent.bottom
                    bottomMargin: titolo_txt.anchors.leftMargin
                    rightMargin: titolo_txt.anchors.leftMargin
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
                        fill: parent
                    }
                }
            }

            Testo
            {
                visible: component.tempo!==""
                id: tempo_txt
                text:"DURATA SESSIONE"
                font.pixelSize: component.fontSize*0.3
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors
                {
                    left: barra_tempo.left
                    right: barra_tempo.right
                    bottom: barra_tempo.top
                    bottomMargin: parent.height*0.1
                }
            }

            Rectangle
            {
                id: barra_tut
                color: component.color2
                height: parent.height*0.1
                radius: height*0.5
                width: parent.width*0.4
                anchors
                {
                    right: parent.right

                    bottom: parent.bottom
                    bottomMargin: titolo_txt.anchors.leftMargin
                    rightMargin: titolo_txt.anchors.leftMargin
                }
                Testo
                {
                    visible: component.tempo!==""
                    text:component.tut
                    font.pixelSize: component.fontSize*0.3
                    verticalAlignment: Text.AlignVCenter

                    anchors
                    {
                        fill: parent
                    }
                }
            }

            Testo
            {
                visible: component.tempo!==""
                text:"TUT"
                font.pixelSize: component.fontSize*0.3
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors
                {
                    left: barra_tut.left
                    right: barra_tut.right
                    bottom: barra_tut.top
                    bottomMargin: parent.height*0.1
                }
            }


        }


        Item {
            id: secondo_terzo
            anchors
            {
                left: primo_terzo.right
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width*0.2


            Testo
            {
                text:"AVANZAMENTO"
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
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width*0.2

            Testo
            {
                text:"PUNTEGGIO"
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


        Item {
            id: quarto_terzo
            anchors
            {
                left: terzo_terzo.right
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width*0.2

            Testo
            {
                text:"GRAFICI"
                font.pixelSize: component.fontSize*0.5
                verticalAlignment: Text.AlignVCenter

                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: parent.height*0.1
                }
            }

            Rectangle
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height*0.5
                width: height
                radius: 0.5*width
                color: "transparent"
                border.color: component.color
                border.width: 0.05*width
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        component.pressed()
                        component.seeStat()
                    }
                }
                id: icona_stats



                Shape {
                    anchors.fill: parent



                    ShapePath {
                        strokeColor: component.color
                        strokeWidth: 5
                        startX: icona_stats.height*0.25
                        startY: icona_stats.height*0.75
                        PathLine { x: icona_stats.height*0.75; y: icona_stats.height*0.75}
                    }
                    ShapePath {
                        strokeColor: component.color
                        strokeWidth: 5
                        startX: icona_stats.height*0.25
                        startY: icona_stats.height*0.75
                        PathLine { x: icona_stats.height*0.25; y: icona_stats.height*0.25}
                    }

                    ShapePath {
                        strokeColor: component.color
                        strokeWidth: 5
                        startX: icona_stats.height*0.36
                        startY: icona_stats.height*0.75
                        PathLine { x: icona_stats.height*0.36; y: icona_stats.height*0.5}
                    }


                    ShapePath {
                        strokeColor: component.color
                        strokeWidth: 5
                        startX: icona_stats.height*0.47
                        startY: icona_stats.height*0.75
                        PathLine { x: icona_stats.height*0.47; y: icona_stats.height*0.4}
                    }


                    ShapePath {
                        strokeColor: component.color
                        strokeWidth: 5
                        startX: icona_stats.height*0.58
                        startY: icona_stats.height*0.75
                        PathLine { x: icona_stats.height*0.58; y: icona_stats.height*0.55}
                    }

                    ShapePath {
                        strokeColor: component.color
                        strokeWidth: 5
                        startX: icona_stats.height*0.69
                        startY: icona_stats.height*0.75
                        PathLine { x: icona_stats.height*0.69; y: icona_stats.height*0.65}
                    }
                }

                Shape {
                    anchors.fill: parent

                    ShapePath
                    {
                        strokeColor: component.color
                        fillColor: "transparent"
                        strokeWidth: 5
                        startX: icona_stats.height*0.25
                        startY: icona_stats.height*0.45
                        PathLine { x: icona_stats.height*0.30; y: icona_stats.height*0.45}
                        PathLine { x: icona_stats.height*0.35; y: icona_stats.height*0.38}
                    }
                    ShapePath
                    {
                        strokeColor: component.color
                        fillColor: "transparent"
                        strokeWidth: 5
                        startX: icona_stats.height*0.35
                        startY: icona_stats.height*0.38
                        PathLine { x: icona_stats.height*0.40; y: icona_stats.height*0.32}
                        PathLine { x: icona_stats.height*0.45; y: icona_stats.height*0.30}
                    }
                    ShapePath
                    {
                        strokeColor: component.color
                        fillColor: "transparent"
                        strokeWidth: 5
                        startX: icona_stats.height*0.45
                        startY: icona_stats.height*0.30
                        PathLine { x: icona_stats.height*0.50; y: icona_stats.height*0.32}
                        PathLine { x: icona_stats.height*0.55; y: icona_stats.height*0.38}
                    }
                    ShapePath
                    {
                        strokeColor: component.color
                        fillColor: "transparent"
                        strokeWidth: 5
                        startX: icona_stats.height*0.55
                        startY: icona_stats.height*0.38
                        PathLine { x: icona_stats.height*0.60; y: icona_stats.height*0.45}
                        PathLine { x: icona_stats.height*0.65; y: icona_stats.height*0.45}
                    }

                }
            }


        }

    }

}
