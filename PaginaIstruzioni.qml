

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

    Component.onCompleted:
    {
        startstop_udp.string="rewire"
    }
    Component.onDestruction:
    {
        startstop_udp.string="stop_rewire"
    }
}

