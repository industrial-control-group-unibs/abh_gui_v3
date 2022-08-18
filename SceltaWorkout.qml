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

    Component.onDestruction:
    {
        pageLoader.last_source="SceltaWorkout.qml"
    }

    FrecceSxDx
    {
        link_sx: "PaginaMondi.qml"
        link_dx: "PaginaConfWorkout.qml"
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
            highlightRangeMode: ListView.StrictlyEnforceRange
            id: lista_workout
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            model: _workout_list

            delegate: IconaWorkout{}



//            onCurrentItemChanged: console.log(model.get(list.currentIndex).name + ' selected')
        }

    }
}
