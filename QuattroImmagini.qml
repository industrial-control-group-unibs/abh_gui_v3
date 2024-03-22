

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

Item {
    anchors.fill: parent
    id: component
    property real ratio: 0.8
    property string immagine11: "place_holder_4_3.png"
    property string testo11: "ALLENAMENTO\n"
    property string link11: "PaginaAllenamento.qml"
    property string immagine12: "place_holder_4_3.png"
    property string testo12: "ALLENAMENTO2\n"
    property string link12: "PaginaAllenamento.qml"
    property string immagine21: "place_holder_4_3.png"
    property string testo21: "ALLENAMENTO\n LIBERO"
    property string link21: "PaginaAllenamento.qml"
    property string immagine22: "place_holder_4_3.png"
    property string testo22: "ALLENAMENTO\n"
    property string link22: "PaginaAllenamento.qml"

    signal press11
    signal press12
    signal press21
    signal press22



    property real bordo: parametri_generali.larghezza_barra*0.05
    property real cell_height: (height-3*bordo)/4
    Column
    {
        anchors.fill: parent
        spacing: component.bordo
        IconaImmagine{
            color: parametri_generali.coloreBordo
            highlighted: component.what_pressed===1
            shadow: true
            text: component.testo11
            image: "file://"+PATH+"/loghi/"+component.immagine11
            width: parent.width-2
            height: component.cell_height

            onPressed: component.press11()

        }
        IconaImmagine{
            color: parametri_generali.coloreBordo
            highlighted: component.what_pressed===2
            shadow: true
            text: component.testo12
            image: "file://"+PATH+"/loghi/"+component.immagine12
            width: parent.width-2
            height: component.cell_height
            onPressed:  component.press12()

        }
        IconaImmagine{
            color: parametri_generali.coloreBordo
            highlighted: component.what_pressed===3
            shadow: true
            text: component.testo21
            image: "file://"+PATH+"/loghi/"+component.immagine21
            width: parent.width-2
            height: component.cell_height

            onPressed:  component.press21()

        }

        IconaImmagine{
            color: parametri_generali.coloreBordo
            highlighted: component.what_pressed===4
            shadow: true
            text: component.testo22
            image: "file://"+PATH+"/loghi/"+component.immagine22
            width: parent.width-2
            height: component.cell_height

            onPressed:  component.press22()

        }
    }

}
