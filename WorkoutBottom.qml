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
    height: parent.height*0.3

    property bool is_visible: true



    CSlider
    {
        id: power_settings
        width: parent.height*0.2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height*0.25
        value: selected_exercise.power
        onValueChanged: {
            selected_exercise.level=(Math.min(3,value)).toString()
        }

        z:10
        visible: parent.is_visible
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
        width: power_settings.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: parent.height*0.25
        anchors.verticalCenter: parent.verticalCenter
        ripetizioni: fb_udp.data[0]

        onRipetizioniChanged: {
            if (ripetizioni>selected_exercise.reps)
                pageLoader.source = "PaginaRiposo.qml"
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
        anchors.horizontalCenterOffset: parent.width*0.25
        anchors.verticalCenter: parent.verticalCenter
        width: power_settings.width
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
        anchors.horizontalCenterOffset: -parent.width*0.25
        anchors.verticalCenter: parent.verticalCenter
        width: power_settings.width
        id: tut
        value: timer_tut.value/1000/60-Math.floor(timer_tut.value/1000/60)
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






