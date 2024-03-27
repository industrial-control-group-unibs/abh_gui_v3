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
    signal shadow

    onShadow: lista.shadow()


    property string titolo: "TITOLO"
    property string cartella_immagini: "zona"
    property variant model
    Barra_superiore{titolo: component.titolo}

    onReload: lista.reload()

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

            signal shadow
            onShadow:
            {
                lista.currentItem.dark_shadow=true
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
                text: vector[0]
                dark_shadow: vector[3]==="no"
                image: "file://"+PATH+"/"+component.cartella_immagini+"/"+vector[1]
                width: lista.width-2


                Testo
                {
                    visible: !dark_shadow && vector[2]!==""
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height*0.1
                    height: parent.height*0.3
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width*0.05
                    anchors.leftMargin: parent.width*0.05
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    text: vector[2]
                    z: 5
                    fontSizeMode: Text.Fit
                }
                Testo
                {
                    visible: dark_shadow
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height*0.1
                    height: parent.height*0.3
                    anchors.left: parent.left
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    text: vector[4]===""?qsTr("NON DISPONIBILE CON IL TUO PIANO"):vector[4]
                    z: 50
                    fontSizeMode: Text.Fit
                }
                Component.onCompleted: added()
                signal selected
                onSelected:
                {
                    lista.currentIndex = index
                    component.selected(vector[0])
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
