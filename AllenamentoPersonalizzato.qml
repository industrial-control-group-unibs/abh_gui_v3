import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1


import QtMultimedia 5.0
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    id: component

    property bool pressed: false
    property int what_pressed: 0

    Component.onDestruction:
    {
        selected_exercise.workout=""
    }


    Barra_superiore{
       titolo: qsTr("ALLENAMENTO PERSONALIZZATO")
    }

    Item {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parametri_generali.larghezza_barra
    FrecceSxDx
    {
        onPressSx: pageLoader.source= "PaginaAllenamento.qml"
        onPressDx: {
            if (component.what_pressed===1)
                 pageLoader.source="SceltaAllenamentoPersonalizzatoTitolo.qml"
            else if (component.what_pressed===2)
                pageLoader.source="SceltaAllenamentoPersonalizzato.qml"
            else if (component.what_pressed===3)
            {
                selected_exercise.code="novision"
                pageLoader.source="PaginaWorkoutManuale.qml"
            }
            else if (component.what_pressed===4)
                pageLoader.source="SceltaStatisticheWorkout.qml"

        }
        dx_visible: component.pressed
        colore: parametri_generali.coloreBordo
    }
    }

    Rectangle
    {
        id: rect_grid
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        anchors.bottomMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        property real bordo: parametri_generali.larghezza_barra*0.05
        property real cell_height: (height-3*bordo)/4
        Column
        {
            anchors.fill: parent
            spacing: rect_grid.bordo
            IconaImmagine{
                color: parametri_generali.coloreBordo
                highlighted: component.what_pressed===1
                text: qsTr("CREA IL PROGRAMMA\nDI ALLENAMENTO")
                image: "file://"+PATH+"/immagini_allenamento_personalizzato/ALLENAMENTO_PERSONALIZZATO_0.jpg"
                width: parent.width-2
                height: rect_grid.cell_height

                onPressed: {
                    component.pressed=true
                    component.what_pressed=1
                }

            }
            IconaImmagine{
                color: parametri_generali.coloreBordo
                highlighted: component.what_pressed===2
                text: qsTr("CONTINUA IL PROGRAMMA\nDI ALLENAMENTO")
                image: "file://"+PATH+"/immagini_allenamento_personalizzato/ALLENAMENTO_PERSONALIZZATO_1.jpg"
                width: parent.width-2
                height: rect_grid.cell_height
                onPressed: {

                    component.pressed=true
                    component.what_pressed=2
                }

            }
            IconaImmagine{
                color: parametri_generali.coloreBordo
                highlighted: component.what_pressed===3
                text: qsTr("MODALITA' MANUALE")
                image: "file://"+PATH+"/immagini_allenamento_personalizzato/ALLENAMENTO_PERSONALIZZATO_2.jpg"
                width: parent.width-2
                height: rect_grid.cell_height

                onPressed: {
                    component.pressed=true
                    component.what_pressed=3
                }

            }

            IconaImmagine{
                color: parametri_generali.coloreBordo
                highlighted: component.what_pressed===4
                dark_shadow: true
                text: qsTr("MODALITA' TUNING")
                image: "file://"+PATH+"/immagini_allenamento_personalizzato/ALLENAMENTO_PERSONALIZZATO_3.jpg"
                width: parent.width-2
                height: rect_grid.cell_height

                onPressed: {
                    component.pressed=true
                    component.what_pressed=4
                }

            }
        }
    }


}
