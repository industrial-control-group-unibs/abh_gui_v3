

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0




PaginaVideoSingolo
{
    link_dx: "PaginaWorkout.qml"
    video_folder: "video_preparazione_esercizi"
    video_name: selected_exercise.video_preparati
    titolo: selected_exercise.name



    Item {
        id: ricevi_comando_vocale
        property real data: fb_udp.data[4]
        onDataChanged:
        {
            if (data==1)
            {
                pageLoader.source="PaginaWorkout.qml"
            }
        }
    }

    Component.onDestruction:
    {
        //_history.pop()
        //link_sx=_history.pop()

        if (selected_exercise.workout==="" || _workout.completed)
        {
            selected_exercise.current_set=0
        }
        else
        {
        }
    }
}


