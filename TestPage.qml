

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    QuattroImmagini
    {
        immagine11: "place_holder_4_3.png"
        testo11: "ALLENAMENTO\n"
        link11: "PaginaAllenamento.qml"
        immagine12: "place_holder_4_3.png"
        testo12: "NUTRIZIONE\n"
        link12: "PaginaAllenamento.qml"
        immagine21: "place_holder_4_3.png"
        testo21: "PSICHE\n"
        link21: "PaginaAllenamento.qml"
        immagine22: "place_holder_4_3.png"
        testo22: "MEDITAZIONE\n"
        link22: "PaginaAllenamento.qml"
    }
}
