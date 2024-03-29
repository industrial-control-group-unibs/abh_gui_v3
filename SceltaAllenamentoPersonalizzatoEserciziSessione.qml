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

    property bool first_time: true
    property bool nuovo: true

    property string nomeEsercizio: selected_exercise.video_intro
//    onNomeEsercizioChanged:
//    {
//        video_source="file://"+PATH+"/video_brevi_esercizi/"+nomeEsercizio
//    }
    property string video_source: "file://"+PATH+"/video_brevi_esercizi/"+nomeEsercizio



    Component.onCompleted:
    {
    }

    Component.onDestruction:
    {
    }


    Item
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z:parent.z+2
        height:274+50
        FrecceSxDx
        {
            onPressSx:{
                pageLoader.source="SceltaAllenamentoPersonalizzatoSessioni.qml"
            }
            onPressDx:
            {
                programma_personalizzato.indice_esercizio=lista_workout.currentIndex
                programma_personalizzato.nuovo_esercizio=component.nuovo
                if (component.nuovo)
                {
                    pageLoader.source="SceltaAllenamentoPersonalizzatoGruppo.qml"
                }
                else
                {
                    pageLoader.source="SceltaAllenamentoPersonalizzatoConfEsercizio.qml"
                }
            }

            dx_visible: true
            colore: parametri_generali.coloreBordo
        }
    }

    Barra_superiore{titolo: qsTr("SESSIONE")+" "+programma_personalizzato.sessione}




    Rectangle
    {
        id: rect_grid
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: parametri_generali.coloreSfondo
        clip: true

        Rectangle
        {
            id: header
            height: video_zone.height+nome_titolo.height
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            z: 5
            color: parametri_generali.coloreSfondo

            Text {
                id: nome_titolo
                text:selected_exercise.name==="unselected"? "" : selected_exercise.name
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



                width: parent.width*0.33 //grid.cellWidth
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
                    autoPlay: true
                    autoLoad: true

                    source:  component.video_source //"file://"+PATH+"/video_brevi_esercizi/"+selected_exercise.video_intro

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
            clip: true
            anchors {
                top: header.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            currentIndex: -1

            signal reload;
            property var empty_list: ["+", "0", "0", "0", "0", "0", "0", "0", "0", "0"]

            onReload:
            {
                lista_workout.model=[]

                _list_string.fromList(_workout.listSessionExercise(programma_personalizzato.sessione))
                _list_string.addRow(empty_list)

                lista_workout.model= _list_string
                lista_workout.forceLayout()
                pageLoader.source=pageLoader.source
                currentIndex:-1
            }

            model: _list_string

            Component.onCompleted:
            {
            }


            delegate: IconaDescrizioneEsercizi{

                color: parametri_generali.coloreBordo
                highlighted:
                {
                    if (lista_workout.currentIndex>=0)
                        lista_workout.currentIndex === index
                    else
                        false;
                }
                onHighlightedChanged:
                {
                    if (highlighted)
                    {
                        selected_exercise.video_intro=_esercizi.getVideoIntro(vector[0])
                    }
                }

                nome:  _esercizi.getName(vector[0])
                type:  _esercizi.getType(vector[0])
                immagine: vector[0]==="+"?"+": _esercizi.getImage(vector[0])

                ripetizioni:parseFloat(vector[1])
                serie: parseFloat(vector[2])
                potenza: parseFloat(vector[3])



                width: lista_workout.width-2

                onPressed: {
                    lista_workout.currentIndex=index
                    selected_exercise.code=vector[0]

                    component.nuovo=vector[0]==="+"
                }
                onPressAndHold:
                {
                    if (vector[0]!=="+")
                    {
                        testo_elimina=qsTr("VUOI ELIMINARE L'ESERCIZIO?")
                        erase=true
                    }

                }
                onEraseNo: erase=false
                onEraseYes:
                {
                    erase=false
                    _workout.removeRow(programma_personalizzato.sessione,
                                       index)
                    lista_workout.reload()
                }
            }


        }



    }


}
