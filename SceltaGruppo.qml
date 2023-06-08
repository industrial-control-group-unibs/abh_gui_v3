import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{titolo: "ALLENAMENTO LIBERO"}
    Component.onDestruction:
    {
    }

    FrecceSxDx
    {
        onPressSx: pageLoader.source= "PaginaAllenamento.qml"
        onPressDx: pageLoader.source=  "SceltaEsercizi.qml"
        dx_visible: lista_zona.currentIndex>=0
        colore: parametri_generali.coloreBordo

    }
    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        Component.onDestruction:
        {
            selected_exercise.name="unselected"
            selected_exercise.code="unselected"
            selected_exercise.immagine=""
        }





        ListView {
            snapMode: ListView.SnapOneItem
            id: lista_zona
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            model: _zona
            currentIndex:-1

            delegate: IconaImmagine{
                color: parametri_generali.coloreBordo
                highlighted:
                {
                    if (lista_zona.currentIndex>=0)
                        lista_zona.currentIndex === index
                    else
                        false;

                }
                text: ex_name
                image: "file://"+PATH+"/zone/"+image_name
                width: lista_zona.width-2
                onPressed: {
                    selected_exercise.name="unselected"
                    zona_allenamento.gruppo=ex_name
                    lista_zona.currentIndex=index
                }
            }




        }

    }
}
