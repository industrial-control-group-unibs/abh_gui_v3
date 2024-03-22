import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
SceltaQuadrati
{
    titolo: disciplina.pratica

    onPressSx: pageLoader.source="SceltaYogaPratica.qml"
    onPressDx: pageLoader.source="PaginaPreparatiPratica.qml"

    swipe: true
    swipe_sx: true
    onSwipeDx: pageLoader.source="SceltaYogaPraticaEserciziNew.qml"

    onSelected:
    {
        console.log("selezionato ", name)
        disciplina.esercizio=name
    }


    Component.onCompleted: {
        disciplina.esercizio=""
        if (!_read_lista.readFile(disciplina.nome+"/"+disciplina.tipologia+"/"+disciplina.pratica))
            pageLoader.source="SceltaYogaPratica.qml"
        reload()

    }
    model: _read_lista
}

