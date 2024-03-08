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

    Barra_superiore{titolo: qsTr("ALLENAMENTO GUIDATO") }

    id: component
    property bool new_workout: false
    Component.onCompleted:
    {
        _active_workouts.readFile((impostazioni_utente.identifier+"/ACTIVEWORKOUT"))
        lista_workout.reload()
        selected_exercise.personalizzato=false;
        console.log("workout ",selected_exercise.workout)
    }

    Component.onDestruction:
    {
    }

    FrecceSotto
    {

        swipe_visible: false

        onPressSx: pageLoader.source= "PaginaAllenamento.qml"
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
                 _list_string.fromList(_workout.listSessionsNumber())
                pageLoader.source="ListaWorkoutSessioni.qml"
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
            currentIndex:-1

            model: _active_workouts

            onCurrentIndexChanged:
            {
            }

            signal reload;
            onReload:
            {
                lista_workout.model=[]
                lista_workout.model= _active_workouts
                lista_workout.forceLayout()
                pageLoader.source="SceltaWorkout.qml"
            }

            delegate: IconaInformazioni{


                color: parametri_generali.coloreBordo
                color2: parametri_generali.coloreUtente
                highlighted:
                {
                    if (lista_workout.currentIndex>=0)
                        lista_workout.currentIndex === index
                    else
                        false;

                }
                titolo: vector[0]
                progress: parseFloat(vector[1])
                punteggio: 10.0*parseFloat(vector[2])
                image_file: "file://"+PATH+"/../utenti/"+impostazioni_utente.identifier+"/"+vector[0]+".jpg"

                date: Qt.formatDate(new Date(1000*parseFloat(vector[3])),"dd/MM/yyyy")

                tempo: vector[4]

                width: lista_workout.width-2

                onPressed: {
                    lista_workout.currentIndex=index
                    if (vector[0]==="+")
                    {
                        component.new_workout=true
                    }
                    else
                    {
                        component.new_workout=false
                        selected_exercise.workout=vector[0]
                        selected_exercise.workout_image=PATH+"/../utenti/"+impostazioni_utente.identifier+"/"+vector[0]+".jpg"
                    }
                }
                onPressAndHold:
                {
                    erase=true
                }
                onEraseNo:
                {
                    erase=false
                }
                onEraseYes:
                {
                    _active_workouts.removeRow(impostazioni_utente.identifier+"/ACTIVEWORKOUT",index);
                    lista_workout.reload()
                }
            }

        }

    }
}
