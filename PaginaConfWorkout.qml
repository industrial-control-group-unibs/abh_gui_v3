

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

    state: livello.value
    states: [
        State {
            name: "ESORDIENTE"
        },
        State {
            name: "INTERMEDIO"
        },
        State {
            name: "ESPERTO"
        }
    ]
    property bool duplicato: false
    onStateChanged:
    {
        duplicato=_active_workouts.checkIfExistColumn("ACTIVEWORKOUT_"+impostazioni_utente.identifier,
                                                0,
                                                selected_exercise.workout+"_"+component.state);
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


        // LIVELLO

        Item {
            anchors
            {
                left:parent.left
                right:parent.right
                top:parent.top
            }
            id: s1
            height: parent.height*0.33

            StringLinearSlider
            {
                id: livello
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                //color: component.duplicato? parametri_generali.coloreBordoTrasparent: parametri_generali.coloreUtente
                //text_color: component.duplicato? parametri_generali.coloreUtente: parametri_generali.coloreBordo
                color: parametri_generali.coloreUtente
                text_color: parametri_generali.coloreBordo

                lista: ["ESORDIENTE", "INTERMEDIO", "ESPERTO"]


                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "LIVELLO"
                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
                }
            }
        }

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

            property string workout_id: ""
            onPressDx:
            {
                if (_active_workouts.checkIfExistColumn("ACTIVEWORKOUT_"+impostazioni_utente.identifier,
                                                        0,
                                                        selected_exercise.workout+"_"+component.state))
                {
                    //duplicato
                }
                else
                {
                    workout_id=_workout.createWorkout(impostazioni_utente.identifier,selected_exercise.workout+"_"+component.state,component.giorni*component.settimane)

                    if (workout_id!=="")
                    {
                        _utenti.saveWorkout(impostazioni_utente.identifier,workout_id)
                        _workout.updateStatFile(impostazioni_utente.identifier,_utenti.getWorkout(impostazioni_utente.identifier),timer_tempo.value,timer_tut.value);
                        _active_workouts.addRow("ACTIVEWORKOUT_"+impostazioni_utente.identifier,
                                                [workout_id,0,0,Math.round(new Date().getTime()*0.001),0,0])
                        selected_exercise.code=_workout.code
                        selected_exercise.reps=_workout.reps
                        selected_exercise.rest_time=_workout.rest
                        selected_exercise.rest_set_time=_workout.restSet
                        selected_exercise.sets=_workout.sets
                        selected_exercise.current_set=0
                        selected_exercise.power=_workout.power
                        pageLoader.source="SceltaWorkout.qml"
                    }
                    else
                    {
                        console.log("qualcosa non va")
                        pageLoader.source="SceltaWorkout.qml"
                    }
                }
            }

            z:5
        }
    }
}
