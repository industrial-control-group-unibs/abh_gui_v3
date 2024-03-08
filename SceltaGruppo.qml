import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Rectangle {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{titolo: qsTr("ALLENAMENTO LIBERO")}


    Component.onDestruction:
    {
        console.log("closing SceltaGruppo")
    }

    FreccieSotto
    {

        swipe_sx: true

        onPressSx: pageLoader.source= "PaginaAllenamento.qml"
        onPressDx: pageLoader.source=  "SceltaEsercizi.qml"
        dx_visible: lista_zona.currentIndex>=0

        onSwipeDx:
        {
            zona_allenamento.gruppo="tutti"
            pageLoader.source=  "SceltaEserciziSearch.qml"
        }
        onSwipeSx:
        {
            //            pageLoader.source=  "SceltaEserciziSearch.qml"
        }
        up_visible: lista_zona.currentIndex>0
        down_visible: lista_zona.currentIndex<(lista_zona.count-1)
        onPressDown:  lista_zona.currentIndex<(lista_zona.count-1)?lista_zona.currentIndex+=1:lista_zona.currentIndex
        onPressUp: lista_zona.currentIndex>0?lista_zona.currentIndex-=1:lista_zona.currentIndex
    }




    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        anchors.bottomMargin: parametri_generali.larghezza_barra
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

            onCurrentIndexChanged: console.log("index = ",currentIndex, " count = ",count)
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
