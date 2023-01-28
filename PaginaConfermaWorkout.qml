

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    titolo: "VUOI CONTINUARE IL WORKOUT\n"+selected_exercise.workout.replace("_", " ")+"?"

    onPressNo: {
        _utenti.saveWorkout(impostazioni_utente.identifier,"")
        pageLoader.source=  "SceltaWorkout.qml"
    }
    onPressYes: {
        selected_exercise.code=_workout.code
        selected_exercise.reps=_workout.reps
        selected_exercise.rest_time=_workout.rest
        selected_exercise.rest_set_time=_workout.restSet
        selected_exercise.sets=_workout.sets
        selected_exercise.current_set=0
        selected_exercise.power=_workout.power
        _list_string.fromList(_workout.listSessionExercise())
        pageLoader.source="ListaEserciziWorkout.qml"
    }

}

