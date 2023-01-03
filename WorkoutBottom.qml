import QtQuick 2.12

Item
{
    Component.onCompleted: {
        power_settings.value= selected_exercise.power
        if (selected_exercise.type===3)
        {
            icona_rep.ripetizioni=selected_exercise.reps
        }
    }

    anchors
    {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    height: parent.height*0.3

    property bool is_visible: true

    signal timeout

    Timer{
        id: conto_alla_rovescia
        interval: 1000*60*5
        repeat: false
        running: parent.visible
        onTriggered: timeout()
    }


    Timer
    {
        property int value: 0
        interval: 500
        id: timer_esercizio
        repeat: true
        running: selected_exercise.type===3
        onTriggered:
        {
            value+=interval
            if (selected_exercise.type===3)
            {
                icona_rep.ripetizioni=selected_exercise.reps-value*0.001
            }
        }
    }


    LinearSlider
    {
        height: parent.height*0.10
        width: parent.width*0.3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height*0.1
        value: selected_exercise.power
        onValueChanged: {
            selected_exercise.power=value
        }
        Testo
        {
            font.pixelSize: parent.height
            text: "POWER"
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5

            }
        }
    }


//    CSlider
//    {
//        id: power_settings
//        width: parent.height*0.35
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.verticalCenterOffset: -parent.height*0.25
//        value: selected_exercise.power
//        progressColor: parametri_generali.coloreUtente
//        handleColor: parametri_generali.coloreBordo
//        trackColor: parametri_generali.coloreBordo
//        onValueChanged: {
//            selected_exercise.power=value
//        }

//        z:10
//        visible: parent.is_visible
//        Testo
//        {
//            text: "POWER"
//            anchors
//            {
//                horizontalCenter: parent.horizontalCenter
//                top: parent.bottom
//                topMargin: 5

//            }
//        }

//    }

    IconaRipetizioni
    {
        id: icona_rep

        width: power_settings.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -parent.height*0.25
        anchors.verticalCenter: parent.verticalCenter
        colore: parametri_generali.coloreBordo
        ripetizioni: fb_udp.data[0]

        onRipetizioniChanged: {
            conto_alla_rovescia.restart()
            if (selected_exercise.type<3)
            {
                if (selected_exercise.workout!=="")
                {
                    selected_exercise.score+=selected_exercise.power*(1.0/_workout.power*selected_exercise.reps)
                }
                if (ripetizioni>selected_exercise.reps)
                    pageLoader.source = "PaginaRiposo.qml"
            }
            else
            {
                if (ripetizioni<=0)
                {
                    pageLoader.source = "PaginaRiposo.qml"
                }
            }
        }
        visible: parent.is_visible
        Testo
        {
            text: "RIPETIZIONI"
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5

            }
        }
    }

    CircularTimer {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: parent.width*0.20
        anchors.verticalCenter: parent.verticalCenter
        width: power_settings.width
        colore: parametri_generali.coloreUtente
        id: time
        value: timer_tempo.value/1000/60-Math.floor(timer_tempo.value/1000/60)
        tempo: timer_tempo.value
        visible: parent.is_visible
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

    CircularTimer {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width*0.20
        anchors.verticalCenter: parent.verticalCenter
        width: power_settings.width
        colore: parametri_generali.coloreUtente
        id: tut
        value: timer_tut.value/1000.0/60.0-Math.floor(timer_tut.value/1000.0/60.0)
        tempo: timer_tut.value
        visible: parent.is_visible
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


}






