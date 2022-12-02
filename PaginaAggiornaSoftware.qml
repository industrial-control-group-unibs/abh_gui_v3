

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    titolo: "VUOI AGGIORNARE?\nGLI AGGIORNAMENTI SARANNO\n OPERATIVI DOPO IL RIAVVIO"

    signal aggiorna
    onPressNo: pageLoader.source=  "PaginaImpostazioni.qml"
    onPressYes: {
        aggiorna()
        pageLoader.source=  "PaginaImpostazioni.qml"
   }
    onAggiorna: {


        chiamata_sistema.string=". ~/script_update.sh"
        chiamata_sistema.call()
    }


    SysCall
    {
        id: chiamata_sistema
    }
}

