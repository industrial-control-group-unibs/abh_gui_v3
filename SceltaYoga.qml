import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
SceltaLista
{
    titolo: qsTr("YOGA")
    cartella_immagini: "yoga"

    onPressSx: pageLoader.source="PaginaMondi.qml"
    onPressDx:
    {
        pageLoader.source="SceltaYogaPratica.qml"
    }

    onSelected:
    {
        console.log("selezionato ", name)
        yoga.pratica=name
    }

    Component.onCompleted: {
        _read_lista.readFile("yoga/Yoga")
        reload()
    }
    model: _read_lista
}

