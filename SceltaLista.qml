import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Rectangle {
    id: component
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    signal pressSx
    signal pressDx
    signal selected(string name)
    signal reload



    property string titolo: "TITOLO"
    property string cartella_immagini: "zona"
    property variant model
    Barra_superiore{titolo: component.titolo}

    onReload: lista.reload()

    Component.onDestruction:
    {
        console.log("closing SceltaGruppo")
    }

    FrecceSotto
    {

        swipe_visible: false

        onPressSx: component.pressSx()
        onPressDx: component.pressDx()
        dx_visible: lista.currentIndex>=0

        up_visible: lista.currentIndex>0
        down_visible: lista.currentIndex<(lista.count-1)
        onPressDown:  lista.currentIndex<(lista.count-1)?lista.currentIndex+=1:lista.currentIndex
        onPressUp: lista.currentIndex>0?lista.currentIndex-=1:lista.currentIndex
    }




    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        anchors.bottomMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        Component.onDestruction:
        {
        }




        ListView {
            snapMode: ListView.SnapOneItem
            id: lista
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            signal reload;

            onReload:
            {
                lista.model=[]
                lista.model= component.model
                lista.forceLayout()
            }

            model: component.model
            currentIndex:-1

            delegate: IconaImmagine{
                color: parametri_generali.coloreBordo
                highlighted:
                {
                    if (lista.currentIndex>=0)
                        lista.currentIndex === index
                    else
                        false;

                }
                text: ex_name
                image: "file://"+PATH+"/"+component.cartella_immagini+"/"+image_name
                width: lista.width-2

                signal selected
                onSelected:
                {
                    lista.currentIndex = index
                    component.selected(ex_name)
                }

                onHighlightedChanged:
                {
                    if (highlighted)
                    {
                        selected()
                    }
                }

                onPressed: {
                    selected()
                }
            }




        }

    }
}
