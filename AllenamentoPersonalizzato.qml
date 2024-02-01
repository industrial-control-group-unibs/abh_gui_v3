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
       titolo: zona_allenamento.gruppo
    }

    Item {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parametri_generali.larghezza_barra
    FrecceSxDx
    {
        onPressSx: pageLoader.source= "SceltaGruppo.qml"
        onPressDx: {
            if (component.what_pressed===1)
                 pageLoader.source="SceltaAllenamentoPersonalizzatoTitolo.qml"
            else if (component.what_pressed===2)
                pageLoader.source="SceltaAllenamentoPersonalizzato.qml"
            else
            {
                selected_exercise.code="novision"
                pageLoader.source="PaginaWorkoutManuale.qml"
            }
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

        Column
        {
            anchors.fill: parent
            spacing: parametri_generali.larghezza_barra*0.1
            IconaRettangolo{
                color: parametri_generali.coloreBordo
                highlighted: component.what_pressed===1
                text: qsTr("CREA IL PROGRAMMA\nDI ALLENAMENTO")
                width: parent.width-2

                onPressed: {
                    component.pressed=true
                    component.what_pressed=1
                }

            }
            IconaRettangolo{
                color: parametri_generali.coloreBordo
                highlighted: component.what_pressed===2
                text: qsTr("CONTINUA IL PROGRAMMA\nDI ALLENAMENTO")
                width: parent.width-2

                onPressed: {

                    component.pressed=true
                    component.what_pressed=2
                }

            }
            IconaRettangolo{
                color: parametri_generali.coloreBordo
                highlighted: component.what_pressed===3
                text: qsTr("MODALITA' MANUALE")
                width: parent.width-2

                onPressed: {
                    component.pressed=true
                    component.what_pressed=3
                }

            }
        }
    }


}
