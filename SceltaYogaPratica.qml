import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
SceltaLista
{
    titolo: yoga.pratica
    cartella_immagini: "yoga"

    onPressSx: pageLoader.source="SceltaYoga.qml"
    onPressDx: pageLoader.source="SceltaYoga.qml"
    //onSelected:

    Component.onCompleted: {
        _read_lista.readFile("yoga/"+yoga.pratica)
        reload()

    }
    model: _read_lista
}

