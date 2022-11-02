

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0




PaginaVideoSingolo
{
    link_sx: pageLoader.last_source
    link_dx: "PaginaWorkout.qml"
    video_folder: "video_preparazione_esercizi"
    video_name: selected_exercise.video_preparati
    titolo: selected_exercise.name

    Item {
        id: ricevi_comando_vocale
        property real data: comando_vocale_udp.data[0]
        onDataChanged:
        {
            console.log("data = ",data)
            if (data==1)
            {
                console.log("qui")
                pageLoader.source="PaginaWorkout.qml"
            }
        }
    }

    Component.onDestruction:
    {
        pageLoader.last_source="PaginaPreparati.qml"

        if (selected_exercise.workout==="" || _workout.completed)
        {
            selected_exercise.current_set=0
        }
        else
        {
        }
    }
}


