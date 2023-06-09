

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    titolo: qsTr("VUOI SALVARE LA PASSWORD?")


    onPressNo: {
        _utenti.saveStorePassword(impostazioni_utente.identifier,"false")
        pageLoader.source=  "PaginaAllenamento.qml"
    }
    onPressYes: {
        _utenti.saveStorePassword(impostazioni_utente.identifier,"true")
        pageLoader.source=  "PaginaAllenamento.qml"
    }

}

