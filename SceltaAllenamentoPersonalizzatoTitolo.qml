import QtQuick 2.12


TemplateInserimentoTesto
{
    titolo: qsTr("NUOVO PROGRAMMA")
    onPressSx: pageLoader.source= "AllenamentoPersonalizzato.qml"
    property bool replace: false
    onPressDx:
    {
        programma_personalizzato.name=text
        if (_custom_sessions.rename(_template_path+"/SESSION_template",
                                    impostazioni_utente.identifier+"/"+text,
                                    replace))
        {
            if (replace)
            {
                _custom_sessions.removeRowByName(impostazioni_utente.identifier+"/CUSTOMWORKOUT",text);
            }
            _custom_sessions.addRow(impostazioni_utente.identifier+"/CUSTOMWORKOUT",
                                    [text,0,0,Math.round(new Date().getTime()*0.001),0,0])
            _workout.loadWorkout(impostazioni_utente.identifier,programma_personalizzato.name)

            pageLoader.source="SceltaAllenamentoPersonalizzatoSessioni.qml"
        }
        else
        {
            messaggio=qsTr("NOME ESISTENTE\nSOSTITUIRE?")
            replace=true
        }
    }
}
