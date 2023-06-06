import QtQuick 2.12

TemplateListaAggiungileTesto
{
    model: _custom_sessions.uniqueElementsOfColumn(impostazioni_utente.identifier+"_"+programma_personalizzato.name,"session")
    titolo: programma_personalizzato.name
    id: component
    property var empty_list: ["+", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
    onPressSx: pageLoader.source= "SceltaAllenamentoPersonalizzato.qml"
    onPressDx:
    {
        programma_personalizzato.sessione= index+1
        console.log("session=",programma_personalizzato.sessione)
        _list_string.fromList(_workout.listSessionExercise(programma_personalizzato.sessione))
        _list_string.addRow(empty_list)

        pageLoader.source="SceltaAllenamentoPersonalizzatoEserciziSessione.qml"
    }
    onErase:
    {

    }


    Item
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z:parent.z+2
        height:274+50

        IconaCerchio
        {
            visible: component.count>1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 100

            onPressed: {
                selected_exercise.code=_workout.code
                selected_exercise.reps=_workout.reps
                selected_exercise.rest_time=_workout.rest
                selected_exercise.rest_set_time=_workout.restSet
                selected_exercise.sets=_workout.sets
                selected_exercise.current_set=0
                selected_exercise.power=_workout.power
                _list_string.fromList(_workout.listSessionExercise(1))
                selected_exercise.workout=programma_personalizzato.name
                pageLoader.source="ListaEserciziWorkout.qml"
            }
            Testo
            {
                text: "INIZIA\nL'ALLENAMENTO"
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.bottom
                    topMargin: 5
                }
            }
        }

    }
}
