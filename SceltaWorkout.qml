import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    Component.onCompleted:
    {
        selected_exercise.workout=_utenti.getWorkout(impostazioni_utente.identifier)
        if (selected_exercise.workout!=="")
        {
            _workout.loadWorkout(impostazioni_utente.identifier,selected_exercise.workout)
            pageLoader.source="PaginaConfermaWorkout.qml"
        }
    }

    Component.onDestruction:
    {
    }

    FrecceSxDx
    {
        onPressSx: pageLoader.source= "PaginaAllenamento.qml"
        onPressDx: pageLoader.source=  "PaginaConfWorkout.qml"
        dx_visible: lista_workout.currentIndex>=0
        colore: parametri_generali.coloreBordo
    }
    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        Component.onDestruction:
        {
            selected_exercise.name="unselected"
            selected_exercise.code="unselected"
            selected_exercise.immagine=""
        }





        ListView {
            snapMode: ListView.SnapOneItem
            id: lista_workout
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            currentIndex:-1

            model: _workout_list

            delegate: IconaWorkout{}



        }

    }
}
