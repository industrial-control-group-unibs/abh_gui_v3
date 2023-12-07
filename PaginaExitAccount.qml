

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    titolo: qsTr("VUOI USCIRE DALL'ACCOUNT?")

    signal spegni
    onPressNo:
    {
        _history.pop()
        pageLoader.source=_history.pop()
    }

    onPressYes: {
        pageLoader.source=  "PaginaAccount.qml"
    }
}

