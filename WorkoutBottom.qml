import QtQuick 2.12

Item
{
    Component.onCompleted: {
        //timer_tempo.start()
        power_settings.value= selected_exercise.power
        //            timer_tut.start()
    }

    anchors
    {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    height: parent.height*0.4




    CSlider
    {
        id: power_settings
        width: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height*0.25
        value: 1
        z:10
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
        width: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: parent.height*0.25
        anchors.verticalCenter: parent.verticalCenter
        ripetizioni: fb_udp.data[0]

        onRipetizioniChanged: {
            if (ripetizioni>selected_exercise.reps)
                pageLoader.source = "PaginaRiposo.qml"
        }

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
        anchors.horizontalCenterOffset: parent.width*0.25
        anchors.verticalCenter: parent.verticalCenter
        width: 100
        id: time
        value: timer_tempo.value/1000/60-Math.floor(timer_tempo.value/1000/60)
        tempo: timer_tempo.value

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
        anchors.horizontalCenterOffset: -parent.width*0.25
        anchors.verticalCenter: parent.verticalCenter
        width: 100
        id: tut
        value: timer_tut.value/1000/60-Math.floor(timer_tut.value/1000/60)
        tempo: timer_tut.value

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






