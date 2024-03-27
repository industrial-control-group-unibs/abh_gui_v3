import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1


import QtMultimedia 5.0
Item {

    id: component
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    signal pressSx
    signal pressDx
    signal swipeSx
    signal swipeDx
    signal selected(string name)
    signal reload
    signal shadow

    onShadow: grid.shadow()
    onReload: grid.reload()

    property string titolo: "TITOLO"
    property string selezione: ""
    property variant model
    property bool swipe: false
    property bool swipe_sx: true

    Barra_superiore{titolo: component.titolo}

    Barra_superiore{
        titolo: zona_allenamento.gruppo
    }

    FrecceSotto
    {
        id: sotto



        onPressSx: component.pressSx()
        onPressDx: component.pressDx()
        dx_visible: grid.currentIndex>=0

        swipe_visible: component.swipe
        swipe_sx: component.swipe_sx
        onSwipeDx: component.swipeDx()
        onSwipeSx: component.swipeSx()

        up_visible: grid.currentIndex>0
        down_visible: grid.currentIndex<(grid.count-1)
        onPressDown:  grid.currentIndex<(grid.count-1)?grid.currentIndex+=1:grid.currentIndex
        onPressUp: grid.currentIndex-=1
    }



    Rectangle
    {
        id: rect_grid
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        anchors.bottomMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        Rectangle
        {
            id: header
            height: video_zone.height+nome_titolo.height+20
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            color: rect_grid.color
            z: 1


            Testo
            {
                id: nome_titolo

                text: _esercizi.getName(component.selezione)
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                }
                font.pixelSize: 30
                font.weight: Font.Normal
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
            }

            Rectangle   {
                color: "black"
                id: video_zone
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: nome_titolo.bottom



                width: grid.cellWidth
                height: width
                radius: 20
                border.color: component.selezione!==""? parametri_generali.coloreBordo: "transparent"
                border.width: 2



                Rectangle
                {
                    id: immagine_selezionata_mask
                    anchors
                    {
                        fill: parent
                        topMargin: parent.border.width
                        bottomMargin: parent.border.width
                        leftMargin: parent.border.width
                        rightMargin: parent.border.width
                    }
                    visible: false
                    color: "white"
                    radius: parent.radius-parent.border.width
                }

                OpacityMask {
                    anchors.fill:immagine_selezionata_mask
                    source: videoOutput
                    maskSource: immagine_selezionata_mask
                }


                MediaPlayer {
                    id: mp_esercizio
                    autoPlay: false
                    autoLoad: true

                    source: "file://"+PATH+"/video_brevi_esercizi/"+_esercizi.getVideoIntro(component.selezione)

                    onPlaybackStateChanged: {
                        if(playbackState==1){
                            durTrig.stop();
                            durTrig.interval=duration-100;
                            durTrig.restart();
                        }
                    }
                }
                Timer{
                    id:durTrig
                    running:false
                    repeat: false
                    onTriggered:{
                        mp_esercizio.pause();
                    }
                }


                VideoOutput {
                    id: videoOutput

                    source: mp_esercizio
                    anchors.fill: parent
                    z:0
                    visible: false
                }


            }
        }


        GridView {

            id: grid
            anchors.topMargin: header.height
            cellWidth: width*0.33; cellHeight: cellWidth
            anchors.fill: parent
            snapMode: GridView.SnapOneRow //SnapToRow
            focus: true

            signal reload;

            onReload:
            {
                grid.model=[]
                grid.model= component.model
                grid.forceLayout()
            }

            signal shadow
            onShadow:
            {
                grid.currentItem.dark_shadow=true
            }

            Component.onCompleted: {currentIndex=-1}

            model: component.model

            delegate: IconaImmagine{
                name: _esercizi.getName(vector[0])
                color: parametri_generali.coloreBordo
                highlighted:
                {
                    if (grid.currentIndex>=0)
                        grid.currentIndex === index
                    else
                        false;
                }
                text: ""
                image:"file://"+PATH+"/immagini_esercizi/"+_esercizi.getImage(vector[0])

                width: grid.cellWidth-2
                height: grid.cellHeight-2

                signal selected
                onSelected:
                {
                    component.selezione= vector[0]
                    grid.currentIndex=index
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

            onCurrentIndexChanged: {
                if (currentIndex>=0)
                {
                    mp_esercizio.stop()
                    mp_esercizio.play()
                }
            }
        }

    }


}
