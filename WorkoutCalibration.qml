import QtQuick 2.12

Item
{
    Component.onCompleted: {
    }

    anchors
    {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    height: parent.height*0.3

    id: component
    property bool is_visible: true
    property bool is_timeout: false
    property double ripetizioni: fb_udp.data[0]

    onVisibleChanged: console.log("calibration visible = ", visible)
    onRipetizioniChanged: timer_timeout.restart()
    signal cancel
    signal exit

    Timer
    {
        interval: 5000
        id: timer_timeout
        repeat: true
        running: true//component.is_visible
        property int stato: 0
        onTriggered:
        {
            if (component.is_visible)
            {
                if (stato===0)
                {
                    console.log("Stop visione")
                    component.is_timeout=true
                    startstop_udp.string="stop"
                    timer_timeout.running=false
                    stato=1
                    exercise_udp.send()
                }
                else if (stato===1)
                {
                    console.log("Riavvio dell'esercizio")
                    startstop_udp.string="start"
                    component.is_timeout=false
                    stato=0
                }
            }
            else
            {
                console.log("timer attivo fuori dalla fase di calibrazione")
            }
        }
    }

    Testo
    {
        id: testo1
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height*0.3

        text: component.is_timeout?qsTr("RIAVVIO ANALISI IN CORSO"):qsTr("ANALISI IN CORSO")
        color: parametri_generali.coloreUtente
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 60
//        anchors
//        {
//            horizontalCenter: parent.horizontalCenter
//            verticalCenter: parent.verticalCenter

//        }
    }

    Testo
    {
        visible: !component.is_timeout
        anchors.top: testo1.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height*0.5
        text: qsTr("CONTINUA AD ESEGUIRE\n L'ESERCIZIO")
        color: parametri_generali.coloreUtente
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 40
//        anchors
//        {
//            horizontalCenter: parent.horizontalCenter
//            verticalCenter: parent.verticalCenter

//        }
    }

    Testo
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: (selected_exercise.type<3?qsTr("RIPETIZIONI"):qsTr("TEMPO"))+" "+fb_udp.data[0]
    }
}






