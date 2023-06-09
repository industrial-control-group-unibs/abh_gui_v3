

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

PaginaSiNo
{
    titolo: qsTr("VUOI CANCELLARE L'UTENTE?")
    onPressNo: pageLoader.source=  "PaginaLogin.qml"
    onPressYes:
    {
        _utenti.removeUser(impostazioni_utente.identifier)
        _utenti.readFile()
        impostazioni_utente.nome=""
        impostazioni_utente.foto=""

        pageLoader.source=  "PaginaLogin.qml"
    }
}
