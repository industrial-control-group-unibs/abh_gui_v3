

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


PaginaVideoSingolo
{
    link_sx: pageLoader.last_source
    link_dx: "PaginaPreparati.qml"
    video_folder: "video_istruzioni"
    video_name: selected_exercise.video_preparati
    titolo: selected_exercise.name
    timer: false

    Component.onCompleted: startstop_udp.string="rewire"
    Component.onDestruction:
    {
        pageLoader.last_source="PaginaIstruzioni.qml"
        startstop_udp.string="stop"
    }
}

