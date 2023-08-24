

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    id: component
    property string level: _workout.level()
    property string name: _workout.name()
    property double score: _workout.score
    property bool duplicato: false
    property string next_level: _workout.getNextLevel()
    property string workout_id: ""


    Component.onCompleted:
    {
        if (next_level==="ESPERTO" && level===next_level)
        {
            pageLoader.source="PaginaAllenamento.qml"
        }
        else if (level===next_level)
            state="mantieni"
        else if (next_level==="ESORDIENTE" && level==="INTERMEDIO")
            state="cala"
        else if (next_level==="INTERMEDIO" && level==="ESPERTO")
            state="cala"
        else if (next_level==="INTERMEDIO" && level==="ESORDIENTE")
            state="aumenta"
        else if (next_level==="ESPERTO" && level==="INTERMEDIO")
            state="aumenta"
        console.log("state = ",state,level,next_level)
    }

    titolo: state==="aumenta"?qsTr("COMPLIMENTI! HAI RAGGIUNTO L'OBIETTIVO ORA PUOI ACCEDERE AL LIVELLO SUCCESSIVO.\n\nVUOI PROSEGUIRE?"):
            state==="mantieni"?qsTr("TI MANCA POCO PER RAGGIUNGERE L'OBIETTIVO.\n\nVUOI RIPETERE IL PROGRAMMA DI ALLENAMENTO?"):
            qsTr("NON HAI RAGGIUNTO L'OBIETTIVO MA POTRESTI RIPROVARE CON UN LIVELLO PIÙ ADEGUATO.\n\nVUOI PROVARE A MIGLIORARE LE TUE PERFORMANCE?")


    onPressNo:
    {
        _history.pop()
        pageLoader.source="PaginaAllenamento.qml"
    }

    onPressYes: {

        duplicato=_active_workouts.checkIfExistColumn(impostazioni_utente.identifier+"/ACTIVEWORKOUT",
                                                0,
                                                component.name+"_"+component.next_level)
        if (duplicato)
        {
            console.log("Rimuovi workout", component.name+"_"+component.next_level)
            _active_workouts.removeRowByName(impostazioni_utente.identifier+"/ACTIVEWORKOUT",
                                              component.name+"_"+component.next_level)
        }

        component.workout_id=_workout.createWorkout(impostazioni_utente.identifier,component.name+"_"+component.next_level,_workout.getNumberOfSession())

        if (component.workout_id!=="")
        {
            _utenti.saveWorkout(impostazioni_utente.identifier,workout_id)
            _workout.updateStatFile(impostazioni_utente.identifier,_utenti.getWorkout(impostazioni_utente.identifier),timer_tempo.value,timer_tut.value);
            _active_workouts.addRow(impostazioni_utente.identifier+"/ACTIVEWORKOUT",
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
    }
}

