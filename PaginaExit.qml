

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    titolo: qsTr("VUOI USCIRE?")

    signal spegni
    onPressNo:
    {
        _history.pop()
        pageLoader.source=_history.pop()
    }
    //pageLoader.source=  "PaginaLogin.qml"
    onPressYes: {
        spegni()

        Qt.callLater(Qt.quit)
    }
    onSpegni: {

        chiamata_sistema.string="systemctl poweroff"
        chiamata_sistema.call()
        chiamata_sistema.string="xrandr --output "+parametri_generali.monitor+" --off"
        chiamata_sistema.call()
    }


    SysCall
    {
        id: chiamata_sistema
    }
}

