

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    titolo: "EFFETTUARE IL LOGOUT?"

    signal spegni
    onPressNo: pageLoader.source=  "PaginaImpostazioni.qml"
    onPressYes:
    {
        pageLoader.source=  "DefinizioneUtente1.qml"
        impostazioni_utente.nome=""
        impostazioni_utente.foto=""
        pageLoader.source=  "PaginaLogin.qml"
    }

    SysCall
    {
        id: chiamata_sistema
    }
}

