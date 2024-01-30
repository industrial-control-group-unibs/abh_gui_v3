import QtQuick 2.12

TemplateListaAggiungile
{
    Component.onCompleted:
    {
        _custom_workouts.readFile((impostazioni_utente.identifier+"/CUSTOMWORKOUT"))
        selected_exercise.personalizzato=true
        reload()
    }
    model: _custom_workouts
    titolo: qsTr("ALLENAMENTO PERSONALIZZATO")

    onPressSx: pageLoader.source= "AllenamentoPersonalizzato.qml"
    onPressDx:
    {
        if (new_element)
        {
            pageLoader.source="SceltaAllenamentoPersonalizzatoTitolo.qml"
        }
        else
        {
            programma_personalizzato.name=text
            _workout.loadWorkout(impostazioni_utente.identifier,programma_personalizzato.name)
            if (_workout.getProgess()===0)
            {
                pageLoader.source="SceltaAllenamentoPersonalizzatoSessioni.qml"
            }
            else
            {
                selected_exercise.workout=programma_personalizzato.name
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
    }
    onErase:
    {
        _custom_workouts.removeRow(impostazioni_utente.identifier+"/CUSTOMWORKOUT",index);
        _custom_sessions.removeRowByName(impostazioni_utente.identifier+"/CUSTOMWORKOUT",text);
    }


}
