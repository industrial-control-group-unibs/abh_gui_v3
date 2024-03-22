import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
SceltaLista
{
    titolo: disciplina.pratica
    cartella_immagini: disciplina.nome

    onPressSx: pageLoader.source="SceltaYoga.qml"
    onPressDx: pageLoader.source="SceltaYogaPraticaEsercizi.qml"

    onSelected:
    {
        console.log("selezionato ", name)
        disciplina.pratica=name
    }

    Component.onCompleted: {
        if (!_read_lista.readFile(disciplina.nome+"/"+disciplina.tipologia))
            pageLoader.source="SceltaYoga.qml"
        reload()

    }
    model: _read_lista
}

