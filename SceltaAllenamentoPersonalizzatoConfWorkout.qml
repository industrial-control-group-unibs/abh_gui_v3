

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    id: component

    property int giorni: frequenza.value
    property int settimane: durata.value


    onStateChanged:
    {
    }

    Component.onDestruction:
    {
    }

    Barra_superiore{
        Item
        {
            anchors
            {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                leftMargin: 170
                rightMargin: 170
            }
            Titolo
            {
                id: titolo
                text:selected_exercise.workout
            }
        }
    }


    Item{
        anchors
        {
            left:parent.left
            right:parent.right
            top:parent.top
        }
        height: parent.height*0.7
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true


        // FREQUENZA
        Item {
            anchors
            {
                left:parent.left
                right:parent.right
                top:s1.bottom
            }
            id: s2
            height: parent.height*0.33


            LinearSlider
            {
                id: frequenza
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: 3
                min: 1
                max: 7

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "FREQUENZA"
                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
                }
                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 300
                    anchors.topMargin: 10
                    text: "(N° allenamenti/settimana)"
                    font.pixelSize: 30
                    color: parametri_generali.coloreBordo
                }
            }
        }


        // DURATA
        Item {
            anchors
            {
                left:parent.left
                right:parent.right
                top:s2.bottom
            }
            id: s3
            height: parent.height*0.33


            LinearSlider
            {
                id: durata
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: 4
                min: 1
                max: 12

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "DURATA"
                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
                }
                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 300
                    anchors.topMargin: 30
                    text: "(N° settimane)"
                    font.pixelSize: 30
                    color: parametri_generali.coloreBordo
                }
            }
        }

    }



    Item
    {
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height*0.2
        FrecceSxDx
        {
            id: freccia
            onPressSx:
            {
                _history.pop()
                pageLoader.source=_history.pop()
            }
            dx_visible: !component.duplicato

            onPressDx:
            {
                _workout.extend(component.giorni*component.settimane)


                selected_exercise.code=_workout.code
                selected_exercise.reps=_workout.reps
                selected_exercise.rest_time=_workout.rest
                selected_exercise.rest_set_time=_workout.restSet
                selected_exercise.sets=_workout.sets
                selected_exercise.current_set=0
                selected_exercise.power=_workout.power
                _list_string.fromList(_workout.listSessionsNumber())
                //_list_string.fromList(_workout.listSessionExercise(1))
                selected_exercise.workout=programma_personalizzato.name
                pageLoader.source="ListaWorkoutSessioni.qml"

            }

            z:5
        }
    }
}
