import QtQuick 2.12


TemplateInserimentoTesto
{
    titolo: "NUOVO PROGRAMMA"
    onPressSx: pageLoader.source= "SceltaAllenamentoPersonalizzato.qml"
    property bool replace: false
    onPressDx:
    {
        programma_personalizzato.name=text
        if (_custom_sessions.rename("SESSION_template",
                                    impostazioni_utente.identifier+"_"+text,
                                    replace))
        {
            if (replace)
                _custom_sessions.removeRowByName("CUSTOMWORKOUT_"+impostazioni_utente.identifier,text);
            _custom_sessions.addRow("CUSTOMWORKOUT_"+impostazioni_utente.identifier,
                                    [text,0,0,Math.round(new Date().getTime()*0.001),0,0])

            _workout.loadWorkout(impostazioni_utente.identifier,programma_personalizzato.name)

            pageLoader.source="SceltaAllenamentoPersonalizzatoSessioni.qml"
        }
        else
        {
            messaggio="NOME ESISTENTE\nSOSTITUIRE?"
            replace=true
        }
    }
}
