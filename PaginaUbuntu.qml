

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    titolo: qsTr("VUOI USCIRE?")

    signal spegni
    onPressNo: pageLoader.source=  "PaginaLogin.qml"
    onPressYes: {
        spegni()

        Qt.callLater(Qt.quit)
    }
    onSpegni: {


        chiamata_sistema.string="xset -display :0.0 dpms force off"
        chiamata_sistema.call()
    }


    SysCall
    {
        id: chiamata_sistema
    }
}

