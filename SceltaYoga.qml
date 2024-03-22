import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
SceltaLista
{
    titolo: disciplina.nome
    cartella_immagini: disciplina.nome

    onPressSx: pageLoader.source="PaginaMondi.qml"
    onPressDx:
    {
        if (!_read_lista.readFile(disciplina.nome+"/"+disciplina.tipologia))
        {
            shadow()
            _read_lista.readFile(disciplina.nome+"/"+disciplina.nome)
        }
        else
            pageLoader.source="SceltaYogaPratica.qml"
    }

    onSelected:
    {
        console.log("selezionato ", name)
        disciplina.tipologia=name
    }

    Component.onCompleted: {
        _read_lista.readFile(disciplina.nome+"/"+disciplina.nome)
        reload()
    }
    model: _read_lista
}

