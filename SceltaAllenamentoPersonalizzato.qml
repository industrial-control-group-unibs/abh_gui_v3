import QtQuick 2.12

TemplateListaAggiungile
{
    Component.onCompleted:
    {
        _custom_workouts.readFile("CUSTOMWORKOUT_"+impostazioni_utente.identifier)
        selected_exercise.personalizzato=true
        reload()
    }
    model: _custom_workouts
    titolo: "PROGRAMMI PERSONALIZZATI"

    onPressSx: pageLoader.source= "PaginaAllenamento.qml"
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
            console.log("QUI: ",_workout.getProgess())
            if (_workout.getProgess()===0)
            {
                console.log("QUI: ")
                console.log("QUI: ",_custom_sessions.uniqueElementsOfColumn(impostazioni_utente.identifier+"_"+programma_personalizzato.name,"session"))
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
        _custom_workouts.removeRow("CUSTOMWORKOUT_"+impostazioni_utente.identifier,index);
        _custom_sessions.removeRowByName("CUSTOMWORKOUT_"+impostazioni_utente.identifier,text);
    }


}
