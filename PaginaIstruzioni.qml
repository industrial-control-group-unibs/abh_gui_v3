

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


PaginaVideoSingolo
{
    link_dx: "PaginaPreparati.qml"
    video_folder: "video_istruzioni"
    video_name: selected_exercise.video_istruzioni
    titolo: selected_exercise.name
    timer: false
    property bool ex_left: selected_exercise.code.endsWith("left")
    property bool ex_right: selected_exercise.code.endsWith("right")

    testo_visibile: true
    testo: ex_left? qsTr("SEGUI LE ISTRUZIONI\nIMPUGNA LA MANIGLIA SINISTRA\nPOI PREMI CONTINUA") :
                 ex_right? qsTr("SEGUI LE ISTRUZIONI\nIMPUGNA LA MANIGLIA DESTRA\nPOI PREMI CONTINUA") :
                        qsTr("SEGUI LE ISTRUZIONI\nPOI PREMI CONTINUA")


    Component.onCompleted:
    {
        startstop_udp.string="rewire"
    }
    Component.onDestruction:
    {
        startstop_udp.string="stop_rewire"
        selected_exercise.time_esercizio = 0.0
        selected_exercise.tut_esercizio  = 0.0
        selected_exercise.completamento  = 0.0
        selected_exercise.score          = 0.0
    }
}

