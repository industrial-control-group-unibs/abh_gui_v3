

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    id: component

    signal press

    onPress:
    {
        selected_exercise.current_set=0

        if (_workout.endWorkout)
        {
            selected_exercise.workout_finito=true
            pageLoader.source = "PaginaCoppa.qml"
        }
        else
            pageLoader.source = "PaginaAllenamento.qml"
    }

    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    property int sessione: 0
    Component.onCompleted:
    {
        sessione=_workout.getActiveSession()
        timer_tut.stop()
        timer_tut.active=false
        timer_tempo.stop()
        startstop_udp.string="rewire"
    }
    Component.onDestruction:
    {
        startstop_udp.string="stop_rewire"
    }

    Barra_superiore{}

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true


        Item {
            anchors
            {
                left: parent.left
                right: parent.right
                top:parent.top
                topMargin: 10
            }
            height: parent.height*0.2
            id: titolo
            Titolo
            {
                text: selected_exercise.workout.replace("_", " ")
            }
        }

        Item {
            anchors
            {
                left: parent.left
                right: parent.right
                top:titolo.bottom
                bottom: avanti.top
                bottomMargin: 10
            }

            id: indicatori
            property real spacing: 10
            property real h:  (height-spacing*3)/3
            property real w: width

            Column {
                spacing: indicatori.spacing
                Item {
                    width: indicatori.w;
                    height: indicatori.h

                    CircularIndicator
                    {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.7
                        width: height

                        stepSize: 0.01
                        trackColor: parametri_generali.coloreBordo
                        trackWidth: 0.1*width
                        progressWidth: trackWidth
                        handleColor: "transparent"
                        progressColor: parametri_generali.coloreUtente
                        value: _workout.getSessionScore(_workout.getActiveSession())


                        Testo
                        {
                            text: (parent.value*10).toFixed(1).toString()
                            font.pixelSize: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: parametri_generali.coloreBordo
                            anchors
                            {
                                fill:parent
                            }
                        }
                    }
                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.15*parent.height
                        text: qsTr("PUNTEGGIO")
                    }
                }
                Item {
                    width: indicatori.w;
                    height: indicatori.h

                    CircularIndicator
                    {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.7
                        width: height

                        stepSize: 0.01
                        trackColor: parametri_generali.coloreBordo
                        trackWidth: 0.1*width
                        progressWidth: trackWidth
                        handleColor: "transparent"
                        progressColor: parametri_generali.coloreUtente
                        value: _workout.getProgess()


                        Testo
                        {
                            text: (parent.value*100).toFixed(0).toString()+"%"
                            font.pixelSize: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: parametri_generali.coloreBordo
                            anchors
                            {
                                fill:parent
                            }
                        }
                    }
                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.15*parent.height
                        text: qsTr("AVANZAMENTO")
                    }
                }
                Item {
                    width: indicatori.w;
                    height: indicatori.h*0.5

                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.5*parent.height
                        text: qsTr("DURATA SESSIONE")
                        font.pixelSize: 50
                    }
                    Rectangle
                    {
                        anchors
                        {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                        }
                        height: 0.5*parent.height
                        radius: 0.5*height
                        width: parent.width*0.8
                        color: parametri_generali.coloreUtente
                        Testo
                        {
                            anchors.fill: parent
                            font.pixelSize: 50
                            font.bold: true
                            text: _workout.getSessionTimeString(_workout.getActiveSession())
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
                Item {
                    width: indicatori.w;
                    height: indicatori.h*0.5

                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.5*parent.height
                        text: "TU"
                        font.pixelSize: 50
                    }

                    Rectangle
                    {
                        anchors
                        {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                        }
                        height: 0.5*parent.height
                        radius: 0.5*height
                        width: parent.width*0.8
                        color: parametri_generali.coloreUtente
                        Testo
                        {
                            anchors.fill: parent
                            font.pixelSize: 50
                            font.bold: true
                            text: _workout.getSessionTutString(_workout.getActiveSession())
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }



        IconaPlus
        {
            id: avanti
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.1
            width: 100
            onPressed: component.press()

        }


    }
}


//import QtGraphicalEffects 1.12
//import QtQuick 2.12
//import QtQuick.Shapes 1.12

//import QtQuick.Layouts 1.1

//import QtMultimedia 5.0


//Item {
//    anchors.fill: parent

//    implicitHeight: 1920/2
//    implicitWidth: 1080/2

//    Component.onCompleted:
//    {
//        timer_tut.stop()
//        timer_tut.active=false
//        timer_tempo.stop()
//        startstop_udp.string="rewire"
//    }
//    Component.onDestruction:
//    {
//        startstop_udp.string="stop_rewire"
//        selected_exercise.score=0
//    }

//    Barra_superiore{}



//    Item{
//        anchors.fill: parent
//        anchors.topMargin: parametri_generali.larghezza_barra
//        clip: true


//        Item {
//            id: titolo
//            anchors
//            {
//                left: parent.left
//                right: parent.right
//                top:parent.top
//                topMargin: 10
//            }
//            height: parent.height*0.2
//            Titolo
//            {
//                text:"ESERCIZIO COMPLETATO"
//                fontSize: 60
//            }

//        }
//        Item {
//            property int size_circle: 100
//            id: indicatori
//            anchors
//            {
//                left: parent.left
//                right: parent.right
//                top:titolo.bottom
//                topMargin: 10
//            }
//            height: parent.height*0.5

//            Rectangle
//            {
//                width: indicatori.size_circle
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.verticalCenterOffset: -parent.height*0.25
//                height: width
//                radius: 0.5*width
//                border.color: parametri_generali.coloreBordo
//                border.width: 5
//                color: "transparent"

//                Text {
//                    text: (selected_exercise.score*10).toFixed(1).toString()


//                    anchors
//                    {
//                        horizontalCenter: parent.horizontalCenter
//                        verticalCenter: parent.verticalCenter
//                    }
//                    color:  parametri_generali.coloreBordo
//                    font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

//                    font.italic: false
//                    font.letterSpacing: 0
//                    font.pixelSize: 30
//                    font.weight: Font.Normal
//                    horizontalAlignment: Text.AlignHCenter
//                    verticalAlignment: Text.AlignTop
//                }

//                Testo
//                {
//                    text: "PUNTEGGIO"
//                    anchors
//                    {
//                        horizontalCenter: parent.horizontalCenter
//                        top: parent.bottom
//                        topMargin: 5

//                    }
//                }
//            }

//            CircularTimer {
//                width: indicatori.size_circle
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.verticalCenterOffset: parent.height*0.25
//                height: width
//                tacche: 120
//                value: 1-conto_alla_rovescia.position/conto_alla_rovescia.duration
//                tempo: (conto_alla_rovescia.duration-conto_alla_rovescia.position) //timerino.remaining_time
//                colore: (tempo<5000)?"red":parametri_generali.coloreBordo

//                MouseArea
//                {
//                    anchors.fill: parent
//                    onClicked: {
//                        conto_alla_rovescia.position=conto_alla_rovescia.duration
//                    }
//                }

//                Timer{
//                    id: conto_alla_rovescia
//                    interval: 500
//                    repeat: true
//                    running: true
//                    property int position: 0
//                    property int duration: selected_exercise.rest_set_time*1000
//                    onTriggered: {
//                        if (position<duration)
//                        {
//                            position+=interval
//                        }
//                        else
//                        {
//                            selected_exercise.current_set=0
//                            pageLoader.source = "PaginaPreparati.qml"
//                        }
//                    }
//                }
//            }


//            Rectangle
//            {
//                width: indicatori.size_circle
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.horizontalCenterOffset: -parent.width*0.25
//                height: width
//                radius: 0.5*width
//                border.color: parametri_generali.coloreBordo
//                border.width: 5
//                color: "transparent"

//                Text {
//                    text: time_string

//                    property string time_string: getTime()
//                    property int tempo: timer_tut.value

//                    function getTime() {
//                        var hours   = Math.floor(tempo*0.001/ 3600)
//                        var minutes = Math.floor((tempo*.001-hours*3600) / 60)
//                        var seconds = Math.floor((tempo*.001-hours*3600-minutes*60))
//                        return hours>0?((hours < 10 ? "0" + hours : hours)+":"):"" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds)
//                    }

//                    anchors
//                    {
//                        horizontalCenter: parent.horizontalCenter
//                        verticalCenter: parent.verticalCenter
//                    }
//                    color:  parametri_generali.coloreBordo
//                    font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

//                    font.italic: false
//                    font.letterSpacing: 0
//                    font.pixelSize: 30
//                    font.weight: Font.Normal
//                    horizontalAlignment: Text.AlignHCenter
//                    verticalAlignment: Text.AlignTop
//                }

//                Testo
//                {
//                    text: "TU"


//                    anchors
//                    {
//                        horizontalCenter: parent.horizontalCenter
//                        top: parent.bottom
//                        topMargin: 5

//                    }
//                }
//            }
//            Rectangle
//            {
//                width: indicatori.size_circle
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.horizontalCenterOffset: parent.width*0.25
//                height: width
//                radius: 0.5*width
//                border.color: parametri_generali.coloreBordo
//                border.width: 5
//                color: "transparent"

//                Text {
//                    text: time_string

//                    property string time_string: getTime()
//                    property int tempo: timer_tempo.value

//                    function getTime() {
//                        var hours   = Math.floor(tempo*0.001/ 3600)
//                        var minutes = Math.floor((tempo*.001-hours*3600) / 60)
//                        var seconds = Math.floor((tempo*.001-hours*3600-minutes*60))
//                        return hours>0?((hours < 10 ? "0" + hours : hours)+":"):"" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds)
//                    }

//                    anchors
//                    {
//                        horizontalCenter: parent.horizontalCenter
//                        verticalCenter: parent.verticalCenter
//                    }
//                    color:  parametri_generali.coloreBordo
//                    font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

//                    font.italic: false
//                    font.letterSpacing: 0
//                    font.pixelSize: 30
//                    font.weight: Font.Normal
//                    horizontalAlignment: Text.AlignHCenter
//                    verticalAlignment: Text.AlignTop
//                }
//                Testo
//                {
//                    text: "TIME"
//                    anchors
//                    {
//                        horizontalCenter: parent.horizontalCenter
//                        top: parent.bottom
//                        topMargin: 5

//                    }
//                }
//            }
//        }

//        Item {
//            id: avanti
//            anchors
//            {
//                left: parent.left
//                right: parent.right
//                top:indicatori.bottom
//                bottom: parent.bottom
//                topMargin: 10
//            }

//            IconaPlus
//            {
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter
//                width: 100
//                onPressed:
//                {
//                    selected_exercise.current_set=0
//                    pageLoader.source = "PaginaPreparati.qml"
//                }
//                Testo
//                {
//                    text: "CONTINUA"
//                    anchors
//                    {
//                        horizontalCenter: parent.horizontalCenter
//                        top: parent.bottom
//                        topMargin: 5
//                    }
//                }
//            }
//        }
//    }
//}
