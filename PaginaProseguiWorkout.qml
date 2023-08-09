

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

    property string next_level: _workout.getNextLevel()
    property string workout_id: ""

    Component.onCompleted:
    {
        console.log(name,level,score,next_level)
        if (level===next_level)
            pageLoader.source="PaginaAllenamento.qml"
    }

    titolo: qsTr("VUOI PROSEGUIRE IL WORKOUT CON IL LIVELLO "+next_level+"?")

    onPressNo:
    {
        _history.pop()
        pageLoader.source="PaginaAllenamento.qml"
    }

    onPressYes: {
        component.workout_id=_workout.createWorkout(impostazioni_utente.identifier,component.name+"_"+component.next_level,_workout.getNumberOfSession())

        if (component.workout_id!=="")
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
    }
}

