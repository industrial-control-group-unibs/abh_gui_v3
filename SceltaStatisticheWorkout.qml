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

    property bool selected: false
    property bool personalizato: false
    Barra_superiore{titolo: "STATISTICHE"}
    id: component
    property bool new_workout: false
    Component.onCompleted:
    {
        _active_workouts.appendIcon(false);
        _active_workouts.readFile("ACTIVEWORKOUT_"+impostazioni_utente.identifier);
        _custom_workouts.appendIcon(false)
        _custom_workouts.readFile("CUSTOMWORKOUT_"+impostazioni_utente.identifier);
        _custom_workouts.appendIcon(true)
        _active_workouts.appendIcon(true);
         lista_workout.reload()
    }


    Component.onDestruction:
    {
        _active_workouts.appendIcon(true);
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
            onPressSx: pageLoader.source= "PaginaAllenamento.qml"
            onPressDx:
            {
                _workout.loadWorkout(impostazioni_utente.identifier,selected_exercise.workout)
                if (!_workout.isEmpty())
                {
                    _list_string.fromList(_workout.listSessionsNumber())
                    pageLoader.source="ListaStatisticheWorkoutSessioni.qml"
                }
            }

            dx_visible: lista_workout.currentIndex>=0
            colore: parametri_generali.coloreBordo
        }
        IconaBottone
        {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 100

            onPressed: {
                component.personalizato=!component.personalizato
                lista_workout.reload()
            }
            Testo
            {
                text: !component.personalizato?"ALLENAMENTO\nGUIDATO":"ALLENAMENTO\nPERSONALIZZATO"
                color: parametri_generali.coloreUtente
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.bottom
                    topMargin: 5
                }
            }
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

            currentIndex:-1

            model: _active_workouts

            onCurrentIndexChanged:
            {
            }

            signal reload;
            onReload:
            {
                lista_workout.model=[]
                if (!component.personalizato)
                    lista_workout.model= _active_workouts
                else
                    lista_workout.model= _custom_workouts
                lista_workout.forceLayout()
                pageLoader.source="SceltaStatisticheWorkout.qml"
            }

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
                onHighlightedChanged:
                {
                    if (lista_workout.currentIndex === index)
                        selected_exercise.workout=vector[0]
                }

                titolo: vector[0]
                progress: parseFloat(vector[1])
                punteggio: 10.0*parseFloat(vector[2])


                date: Qt.formatDate(new Date(1000*parseFloat(vector[3])),"dd/MM/yyyy")

                tempo: vector[4]
                tut: vector[5]

                width: lista_workout.width-2

                onPressed: {
                    component.selected=true
                    lista_workout.currentIndex=index
//                    selected_exercise.workout=vector[0]
                }
                onSeeStat:
                {
                    _workout.loadWorkout(impostazioni_utente.identifier,selected_exercise.workout)
                    if (!_workout.isEmpty())
                        pageLoader.source= "PaginaStatistiche.qml"
                }

            }

        }

    }
}
