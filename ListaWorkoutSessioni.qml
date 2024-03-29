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
        _active_workouts.readFile((impostazioni_utente.identifier+"/ACTIVEWORKOUT"))
    }

    Component.onDestruction:
    {
    }

    FrecceSotto
    {
        id: sotto
        swipe_visible: false

        onPressSx:
        {
            if (selected_exercise.personalizzato)
                pageLoader.source= "SceltaAllenamentoPersonalizzato.qml"
            else
                pageLoader.source= "SceltaWorkout.qml"
        }
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
                _list_string.fromList(_workout.listSessionExercise(selected_exercise.selected_session))
                pageLoader.source="ListaEserciziWorkout.qml"
            }
        }

        dx_visible: lista_workout.currentIndex>=0

        up_visible: lista_workout.currentIndex>0
        down_visible: lista_workout.currentIndex<(lista_workout.count-1)
        onPressDown:  lista_workout.currentIndex<(lista_workout.count-1)?lista_workout.currentIndex+=1:lista_workout.currentIndex
        onPressUp: lista_workout.currentIndex>0?lista_workout.currentIndex-=1:lista_workout.currentIndex
    }


    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        anchors.bottomMargin: parametri_generali.larghezza_barra
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
            currentIndex: _workout.getActiveSession()-1

            model: _list_string


            signal reload;


            delegate: IconaInformazioni{

                image_file: "file://"+PATH+"/../utenti/"+impostazioni_utente.identifier+"/"+selected_exercise.workout+".png"

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


                width: lista_workout.width-2

                signal selected
                onSelected:
                {
                    lista_workout.currentIndex=index
                }

                onHighlightedChanged:
                {
                    if (highlighted)
                    {
                        selected()
                    }
                }

                onPressed: {
                    selected()
                }
            }

        }

    }
}
