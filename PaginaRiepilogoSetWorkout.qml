

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Component.onCompleted:
    {
        timer_tut.stop()
        timer_tut.active=false
        timer_tempo.stop()
        startstop_udp.string="rewire"
//        _workout.setScore(selected_exercise.score)
    }
    Component.onDestruction:
    {
        startstop_udp.string="stop_rewire"
        selected_exercise.score=0
    }

    Barra_superiore{}



    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true


        Item {
            id: titolo
            anchors
            {
                left: parent.left
                right: parent.right
                top:parent.top
                topMargin: 10
            }
            height: parent.height*0.2
            Titolo
            {
                text:"ESERCIZIO COMPLETATO"
                fontSize: 60
            }

        }
        Item {
            property int size_circle: 100
            id: indicatori
            anchors
            {
                left: parent.left
                right: parent.right
                top:titolo.bottom
                topMargin: 10
            }
            height: parent.height*0.5

            Rectangle
            {
                width: indicatori.size_circle
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -parent.height*0.25
                height: width
                radius: 0.5*width
                border.color: parametri_generali.coloreBordo
                border.width: 5
                color: "transparent"

                Text {
                    text: (selected_exercise.score*10).toFixed(1).toString()


                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    color:  parametri_generali.coloreBordo
                    font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                    font.italic: false
                    font.letterSpacing: 0
                    font.pixelSize: 30
                    font.weight: Font.Normal
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                }

                Testo
                {
                    text: "PUNTEGGIO"
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5

                    }
                }
            }

            CircularTimer {
                width: indicatori.size_circle
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: parent.height*0.25
                height: width
                tacche: 120
                value: 1-conto_alla_rovescia.position/conto_alla_rovescia.duration
                tempo: (conto_alla_rovescia.duration-conto_alla_rovescia.position) //timerino.remaining_time
                colore: (tempo<5000)?"red":parametri_generali.coloreBordo

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        conto_alla_rovescia.position=conto_alla_rovescia.duration
                    }
                }

                Timer{
                    id: conto_alla_rovescia
                    interval: 500
                    repeat: true
                    running: true
                    property int position: 0
                    property int duration: selected_exercise.rest_set_time*1000
                    onTriggered: {
                        if (position<duration)
                        {
                            position+=interval
                        }
                        else
                        {
                            console.log("fine timer");
                            selected_exercise.current_set=0
                            pageLoader.source = "PaginaPreparati.qml"
                            console.log("fatto");
                        }
                    }
                }
            }


            Rectangle
            {
                width: indicatori.size_circle
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
                height: width
                radius: 0.5*width
                border.color: parametri_generali.coloreBordo
                border.width: 5
                color: "transparent"

                Text {
                    text: time_string

                    property string time_string: getTime()
                    property int tempo: timer_tut.value

                    function getTime() {
                        var hours   = Math.floor(tempo*0.001/ 3600)
                        var minutes = Math.floor((tempo*.001-hours*3600) / 60)
                        var seconds = Math.floor((tempo*.001-hours*3600-minutes*60))
                        return hours>0?((hours < 10 ? "0" + hours : hours)+":"):"" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds)
                    }

                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    color:  parametri_generali.coloreBordo
                    font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                    font.italic: false
                    font.letterSpacing: 0
                    font.pixelSize: 30
                    font.weight: Font.Normal
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                }

                Testo
                {
                    text: "TUT"


                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5

                    }
                }
            }
            Rectangle
            {
                width: indicatori.size_circle
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                height: width
                radius: 0.5*width
                border.color: parametri_generali.coloreBordo
                border.width: 5
                color: "transparent"

                Text {
                    text: time_string

                    property string time_string: getTime()
                    property int tempo: timer_tempo.value

                    function getTime() {
                        var hours   = Math.floor(tempo*0.001/ 3600)
                        var minutes = Math.floor((tempo*.001-hours*3600) / 60)
                        var seconds = Math.floor((tempo*.001-hours*3600-minutes*60))
                        return hours>0?((hours < 10 ? "0" + hours : hours)+":"):"" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds)
                    }

                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    color:  parametri_generali.coloreBordo
                    font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                    font.italic: false
                    font.letterSpacing: 0
                    font.pixelSize: 30
                    font.weight: Font.Normal
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                }
                Testo
                {
                    text: "TIME"
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5

                    }
                }
            }
        }

        Item {
            id: avanti
            anchors
            {
                left: parent.left
                right: parent.right
                top:indicatori.bottom
                bottom: parent.bottom
                topMargin: 10
            }

            IconaPlus
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 100
                onPressed:
                {
                    selected_exercise.current_set=0
                    pageLoader.source = "PaginaPreparati.qml"
                }
                Testo
                {
                    text: "CONTINUA"
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5
                    }
                }
            }
        }
    }
}
