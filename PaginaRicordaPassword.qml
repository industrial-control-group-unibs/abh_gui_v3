

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

PaginaSiNo
{
    titolo: qsTr("VUOI SALVARE IL PIN?")


    onPressNo: {
        _utenti.saveStorePassword(impostazioni_utente.identifier,"false")
        pageLoader.source=  "PaginaMondi.qml"
    }
    onPressYes: {
        _utenti.saveStorePassword(impostazioni_utente.identifier,"true")
        pageLoader.source=  "PaginaMondi.qml"
    }

}

