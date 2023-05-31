import QtQuick 2.12

TemplateListaAggiungile
{
    Component.onCompleted:
    {
        _custom_workouts.readFile("CUSTOMWORKOUT_"+impostazioni_utente.identifier)
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

            pageLoader.source="SceltaAllenamentoPersonalizzatoSessioni.qml"
        }
    }
    onErase:
    {

        _custom_workouts.removeRow("CUSTOMWORKOUT_"+impostazioni_utente.identifier,index);
    }


}
