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


    Component.onDestruction:
    {
        selected_exercise.workout=""
    }


    Barra_superiore{
       titolo: zona_allenamento.gruppo
    }


    FrecceSotto
    {
        id: sotto
        swipe_sx: false

        onPressSx: pageLoader.source= "SceltaGruppo.qml"
        onPressDx: pageLoader.source=  "PaginaConfEsercizioSingolo.qml"
        dx_visible: lista_workout.currentIndex>=0

        onSwipeDx:
        {

        }
        onSwipeSx:
        {
            pageLoader.source=  "SceltaEsercizi.qml"
        }
        up_visible: lista_workout.currentIndex>0
        down_visible: lista_workout.currentIndex<(lista_workout.count-1)
        onPressDown:  lista_workout.currentIndex<(lista_workout.count-1)?lista_workout.currentIndex+=1:lista_workout.currentIndex
        onPressUp: lista_workout.currentIndex>0?lista_workout.currentIndex-=1:lista_workout.currentIndex
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


            Text {
                id: nome_titolo
                text:selected_exercise.name==="unselected"? zona_allenamento.gruppo : selected_exercise.name
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                }
                color: parametri_generali.coloreBordo
                wrapMode: TextEdit.WordWrap
                font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                font.italic: false
                font.letterSpacing: 0
                font.pixelSize: 30
                font.weight: Font.Normal
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop

                layer.enabled: true
                layer.effect: DropShadow {
                    verticalOffset: 2
                    color: "#80000000"
                    radius: 1
                    samples: 3
                }
            }

            Rectangle   {
                color: "black"
                id: video_zone
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: nome_titolo.bottom



                width: lista_workout.width*0.33
                height: width
                radius: 20
                border.color: selected_exercise.immagine? parametri_generali.coloreBordo: "transparent"
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

                    source: "file://"+PATH+"/video_brevi_esercizi/"+selected_exercise.video_intro

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

        ListView {
            snapMode: ListView.SnapOneItem
            id: lista_workout
            anchors {
                top: parent.top
                topMargin: header.height
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            currentIndex: -1

            model: gruppo_model_

            signal reload;


            delegate: IconaDescrizioneEsercizi{


                color: parametri_generali.coloreBordo
                highlighted:
                {
                    if (lista_workout.currentIndex>=0)
                        lista_workout.currentIndex === index
                    else
                        false;
                }
                nome:  _esercizi.getName(ex_name)
                type:  _esercizi.getType(ex_name)
                immagine:  _esercizi.getImage(ex_name)

                ripetizioni:-1
                serie: -1
                potenza: -1



                width: lista_workout.width-2

                signal selected
                onSelected:
                {
                    selected_exercise.code= ex_name
                    selected_exercise.sets=1
                    lista_workout.currentIndex=index
                }

                onHighlightedChanged:
                {
                    if (highlighted)
                    {
                        selected_exercise.video_intro=_esercizi.getVideoIntro(ex_name)
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
