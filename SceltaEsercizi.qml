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

    Barra_superiore{}

    FrecceSxDx
    {
        link_sx: "SceltaGruppo.qml"
        link_dx: "PaginaPreparati.qml"
    }


    Rectangle
    {
        id: rect_grid
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        Rectangle
        {
            id: header
            height: video_zone.height+20
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            color: rect_grid.color
            z: 1


            Text {
                text:selected_exercise.ex_name==="unselected"? zona_allenamento.gruppo+"\n" : zona_allenamento.gruppo+"\n"+selected_exercise.ex_name
                anchors
                {
                    left:parent.left
                    right:parent.right
                    leftMargin: 5
                    verticalCenter: parent.verticalCenter
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
                color: "transparent"
                id: video_zone
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: 256*2
                height: 135*2
                radius: 20
                border.color: selected_exercise.source? parametri_generali.coloreBordo: "transparent"
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

//                    loops: MediaPlayer.Infinite
                    //source: selected_exercise.ex_code+ ".mp4"
                    source: "file://"+PATH+"/video/"+"placeholver_video.mp4"
//                    onSourceChanged: console.log("video "+selected_exercise.ex_code+ ".mp4")

                    onPlaybackStateChanged: {
                        if(playbackState==1){
                            durTrig.stop();
                            console.log(duration)
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

//                Image {
//                    id: immagine_selezionata
//                    layer.enabled: true
//                    fillMode: Image.PreserveAspectFit
//                    visible: false
//                    mipmap: true
//                    //                    z: 2
//                    anchors
//                    {
//                        fill: parent
//                        leftMargin: 5
//                        rightMargin: 5
//                        topMargin: 5
//                        bottomMargin: 5
//                    }
//                    source: "file://"+PATH+"/"+selected_exercise.source

//                }
            }
        }


        GridView {

            id: grid
            anchors.topMargin: header.height
            cellWidth: width*0.33; cellHeight: cellWidth
            anchors.fill: parent
            snapMode: GridView.SnapToRow
            focus: true

            Component.onCompleted: {currentIndex=-1}

            model: _myModel //zona_allenamento.lista //Lista_pettorali {}
            delegate:IconaEsercizi{}

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
