import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1


import QtMultimedia 5.0
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2


    Component.onCompleted:
    {

    }

    Component.onDestruction:
    {
        selected_exercise.code=_workout.code
        selected_exercise.reps=_workout.reps
        selected_exercise.rest_time=_workout.rest
        selected_exercise.sets=_workout.sets
        selected_exercise.rest_set_time=_workout.restSet
        selected_exercise.power=_workout.power
    }

    FreccieSotto
    {

        swipe_visible: false

        onPressSx:{
            _list_string.fromList(_workout.listSessionsNumber())
            pageLoader.source="ListaStatisticheWorkoutSessioni.qml"
        }

        onPressDx: pageLoader.source=  "ListaStatisticheWorkoutSessioni.qml"
        dx_visible: false

        up_visible: lista_workout.currentIndex>0
        down_visible: lista_workout.currentIndex<(lista_workout.count-1)
        onPressDown:  lista_workout.currentIndex<(lista_workout.count-1)?lista_workout.currentIndex+=1:lista_workout.currentIndex
        onPressUp: lista_workout.currentIndex>0?lista_workout.currentIndex-=1:lista_workout.currentIndex


    }


    Barra_superiore{}




    Rectangle
    {
        id: rect_grid
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        anchors.bottomMargin: parametri_generali.larghezza_barra
        color: parametri_generali.coloreSfondo
        clip: true



        ListView {
            snapMode: ListView.SnapOneItem
            id: lista_workout
            clip: true
            anchors {
                fill: parent
            }
            currentIndex: -1



            model: _list_string




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
                titolo: _esercizi.getName(vector[0])
                progress: parseFloat(vector[1])
                punteggio: parseFloat(10*vector[2])


                date: ""

                tempo: vector[3]
                tut: vector[4]


                width: lista_workout.width-2

                onPressed: {
                    lista_workout.currentIndex=index
                    //selected_exercise.selected_session=lista_workout.currentIndex+1
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
