import QtQuick 2.12

Item
{

    property real default_power: 0
    Component.onCompleted: {
        power_settings.value= selected_exercise.power
        if (selected_exercise.workout==="")
            default_power=selected_exercise.default_power
        else
            default_power=_workout.power
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
    id: component

    Timer{
        id: conto_alla_rovescia
        interval: 1000*60*5
        repeat: false
        running: parent.visible
        onTriggered:
        {
            timeout()
        }
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
        id: power_settings
        height: parent.height*0.20
        width: parent.width*0.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height*0.2
        value: selected_exercise.power
        onValueChanged: {
            selected_exercise.power=value
        }
        Testo
        {
            text: "POWER"
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5

            }
        }
    }



    IconaRipetizioni
    {
        id: icona_rep

        width: parent.height*0.35
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -parent.height*0.25
        anchors.verticalCenter: parent.verticalCenter
        colore: parametri_generali.coloreBordo
        ripetizioni: fb_udp.data[0]

        onRipetizioniChanged: {
            conto_alla_rovescia.restart()
            if (selected_exercise.type<3)
            {
                if (ripetizioni>1)
                {
                    selected_exercise.completamento+=1.0/(selected_exercise.reps*selected_exercise.sets)
                    selected_exercise.score+=selected_exercise.power/(component.default_power*selected_exercise.reps*selected_exercise.sets)
                    console.log("score=",selected_exercise.completamento,"completamento",selected_exercise.completamento)
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
                else
                {
                    selected_exercise.score+=1.0/(selected_exercise.reps*selected_exercise.sets)
                    selected_exercise.completamento+=1.0/(selected_exercise.reps*selected_exercise.sets)
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
        anchors.horizontalCenterOffset: parent.width*0.35
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height*0.1
        width: icona_rep.width
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
        anchors.horizontalCenterOffset: -parent.width*0.35
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height*0.1
        width: icona_rep.width
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

    Testo
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 30
        text: "completamento = "+selected_exercise.completamento+" score ="+selected_exercise.score
    }


}






