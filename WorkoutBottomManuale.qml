import QtQuick 2.12

import QtMultimedia 5.0
Item
{

    property real default_power: 0
    Component.onCompleted: {
        power_settings.value= 1
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

    property int time_manual: 0
    property int power_level: 1
    property bool stop: true
    onPower_levelChanged:
    {
        if (!stop)
            selected_exercise.power = power_level
    }
    onStopChanged:
    {
        if (!stop)
            selected_exercise.power = power_level
        else
            selected_exercise.power = 0
    }



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

    Timer{
            interval: 100
            repeat: true
            running: true
            onTriggered:
            {
                if (!component.stop)
                    component.time_manual+=interval
            }
        }




    LinearSlider
    {
        visible: true
        id: power_settings
        height: parent.height*0.20*0.66
        width: parent.width*0.5
        max: 25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height*0.2
        value: component.power_level
        onValueChanged: {
            component.power_level=value
        }
        Testo
        {
            text: qsTr("POWER")
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
        anchors.verticalCenterOffset: -parent.height*0.25
        anchors.verticalCenter: parent.verticalCenter
        width: icona_rep.width
        colore: parametri_generali.coloreUtente
        id: time
        value: component.time_manual/1000/60-Math.floor(component.time_manual/1000/60)
        tempo: component.time_manual
        visible: parent.is_visible
        dimensione_tache: 8
        tacche: 30

        Testo
        {
            text: qsTr("TIME")
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5

            }
        }
    }

    IconaBottone
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width*0.35
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height*0.25
        //anchors.verticalCenterOffset: -parent.height*0.1
        width: 100
        colore: parametri_generali.coloreUtente
        colore2: "transparent"
        onPressed: {
            component.time_manual=0
        }
        Testo
        {
            text: qsTr("RESET\nTIMER")
            color: parametri_generali.coloreBordo
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width*0.8
            height: width
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
        }
    }

    IconaBottone
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: parent.width*0.35
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height*0.25
        width: 100
        colore: parametri_generali.coloreUtente
        colore2: "transparent"
        onPressed: {
            component.stop=!component.stop
        }
        Testo
        {
            text: component.stop?qsTr("AVVIA"):qsTr("FERMA")
            color: parametri_generali.coloreBordo
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width*0.8
            height: width
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
        }
    }



}






