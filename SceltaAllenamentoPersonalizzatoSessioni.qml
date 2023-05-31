import QtQuick 2.12

TemplateListaAggiungileTesto
{
    model: _custom_sessions.uniqueElementsOfColumn(impostazioni_utente.identifier+"_"+programma_personalizzato.name,"session")
    titolo: programma_personalizzato.name

    property var empty_list: ["+", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
    onPressSx: pageLoader.source= "SceltaAllenamentoPersonalizzato.qml"
    onPressDx:
    {
        programma_personalizzato.sessione= index+1
        _list_string.fromList(_workout.listSessionExercise(programma_personalizzato.sessione))
        _list_string.addRow(empty_list)

        pageLoader.source="SceltaAllenamentoPersonalizzatoEserciziSessione.qml"
    }
    onErase:
    {

    }


}
