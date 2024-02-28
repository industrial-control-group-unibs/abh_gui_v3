

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    titolo: qsTr("CONFERMI IL CAMBIO DI LA LINGUA?")

    signal aggiorna
    onPressNo:
    {
        _history.pop()
        pageLoader.source=  "PaginaLingue.qml"
    }
    onPressYes: {
        _history.pop()
        _user_config.setValue("lingua",parametri_generali.nuova_lingua)

        if (impostazioni_utente.identifier !=="")
            pageLoader.source="PaginaAllenamento.qml"
        else
            pageLoader.source="PaginaLogin.qml"
   }


}

