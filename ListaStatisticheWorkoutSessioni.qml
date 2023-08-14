import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import Qt.labs.qmlmodels 1.0 //sudo apt install qml-module-qt-labs-qmlmodels



Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    id: component
    property bool new_workout: false
    Component.onCompleted:
    {
        _active_workouts.appendIcon(false);
        _active_workouts.readFile(impostazioni_utente.identifier+"/ACTIVEWORKOUT");
         lista_workout.reload()
        _active_workouts.appendIcon(false);
    }

    Component.onDestruction:
    {
    }

    Item
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z:parent.z+2
        height:274+50
        FrecceSxDx
        {
            onPressSx: pageLoader.source= "SceltaStatisticheWorkout.qml"
            onPressDx:
            {
                if (component.new_workout)
                {
                    pageLoader.source="SceltaNuovoWorkout.qml"
                }
                else
                {
                    _workout.loadWorkout(impostazioni_utente.identifier,selected_exercise.workout)
                    selected_exercise.code=_workout.code
                    selected_exercise.reps=_workout.reps
                    selected_exercise.rest_time=_workout.rest
                    selected_exercise.rest_set_time=_workout.restSet
                    selected_exercise.sets=_workout.sets
                    selected_exercise.current_set=0
                    selected_exercise.power=_workout.power
                    selected_exercise.selected_session=lista_workout.currentIndex+1
                    _list_string.fromList(_workout.listSessionExerciseStat(selected_exercise.selected_session))
                    pageLoader.source="ListaStatisticheEserciziWorkout.qml"
                }
            }

            dx_visible: lista_workout.currentIndex>=0
            colore: parametri_generali.coloreBordo
        }
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
            currentIndex: -1

            model: _list_string


            signal reload;


            delegate: IconaStat{


                color: parametri_generali.coloreBordo
                color2: parametri_generali.coloreUtente
                highlighted:
                {
                    if (lista_workout.currentIndex>=0)
                        lista_workout.currentIndex === index
                    else
                        false;

                }
                titolo: qsTr("SESSIONE")+" "+vector[0]
                progress: parseFloat(vector[1])
                punteggio: parseFloat(10*vector[2])


                date: ""

                tempo: vector[3]
                tut: vector[4]

                width: lista_workout.width-2

                onPressed: {
                    lista_workout.currentIndex=index
                    selected_exercise.selected_session=lista_workout.currentIndex+1
                }

                onSeeStat:
                {
                    _workout.loadWorkout(impostazioni_utente.identifier,selected_exercise.workout)
                    pageLoader.source= "PaginaStatisticheSessione.qml"

                }
            }


        }

    }
}
