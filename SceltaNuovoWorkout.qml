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
//    Component.onCompleted:
//    {
//        selected_exercise.workout=_utenti.getWorkout(impostazioni_utente.identifier)
//        if (selected_exercise.workout!=="")
//        {
//            _workout.loadWorkout(impostazioni_utente.identifier,selected_exercise.workout)
//            pageLoader.source="PaginaConfermaWorkout.qml"
//        }
//    }

    Component.onDestruction:
    {
    }

    FreccieSotto
    {

        swipe_visible: false

        onPressSx: pageLoader.source= "SceltaWorkout.qml"
        onPressDx:
        {
            pageLoader.source="PaginaConfWorkout.qml"
        }

        dx_visible: lista_workout.currentIndex>=0

        up_visible: lista_workout.currentIndex>0
        down_visible: lista_workout.currentIndex<(lista_workout.count-1)
        onPressDown:  lista_workout.currentIndex<(lista_workout.count-1)?lista_workout.currentIndex+=1:lista_workout.currentIndex
        onPressUp: lista_workout.currentIndex>0?lista_workout.currentIndex-=1:lista_workout.currentIndex
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
            onPressSx: pageLoader.source= "SceltaWorkout.qml"
            onPressDx:
            {
                pageLoader.source="PaginaConfWorkout.qml"
            }

            dx_visible: lista_workout.currentIndex>=0
            colore: parametri_generali.coloreBordo
        }
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

            model: _workout_list

            onCurrentIndexChanged:
            {
            }

            delegate: IconaImmagine{
                color: parametri_generali.coloreBordo
                highlighted:
                {
                    if (lista_workout.currentIndex>=0)
                        lista_workout.currentIndex === index
                    else
                        false;

                }
                text: vector[0]
                image: "file://"+PATH+"/allenamento_programmato/"+vector[1]
                width: lista_workout.width-2
                onPressed: {
                    selected_exercise.workout=vector[0]
                    selected_exercise.workout_image=PATH+"/allenamento_programmato/"+vector[1]
                    console.log("foto",selected_exercise.workout_image)
                    lista_workout.currentIndex=index
                }
            }


        }

    }
}
