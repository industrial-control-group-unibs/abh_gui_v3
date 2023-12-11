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

    Component.onCompleted: {
        gruppo_model_.filterByName("")
        lista_workout.reload()
    }

    Component.onDestruction:
    {
        selected_exercise.workout=""
    }


    Barra_superiore{
       titolo: qsTr("RICERCA PER NOME")
    }



    Item
    {
        id: sotto
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height*0.2
        z:10
        FrecceSxDx
        {
            onPressSx: pageLoader.source= "SceltaGruppo.qml"
            onPressDx: pageLoader.source=  "PaginaConfEsercizioSingolo.qml"
            dx_visible: lista_workout.currentIndex>=0
        }
    }


    BottoniSwipe{

        anchors
        {
            bottom: parent.bottom
            bottomMargin: parent.height*0.05
            horizontalCenter: parent.horizontalCenter
        }
        z:5
        width: 0.4*parent.width
        bordo: parametri_generali.coloreUtente
        onPressRight:
        {
//            component.state="stats"
        }
        onPressLeft:
        {
            pageLoader.source=  "SceltaGruppo.qml"
        }
        state: "dx"
    }

    Column
    {
        id: rect_grid
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true
        spacing: 10

        Rectangle
        {
            id: casella
            property color colore: parametri_generali.coloreBordo
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height*0.1
            radius: 20
            color: "transparent"
            border.color: colore

            Testo
            {
                anchors.fill: parent
                text: tastierino.testo
                font.pixelSize: 70
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
            }

        }

        Tastiera
        {
            id: tastierino
            anchors.left: parent.left
            anchors.right: parent.right
            colore: parametri_generali.coloreBordo
            font_colore: parametri_generali.coloreSfondo
            onTestoChanged:
            {
                gruppo_model_.filterByName(testo)
                lista_workout.reload()
            }
        }

        Item
        {
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height*0.6
            clip: true
            ListView {
                snapMode: ListView.SnapOneItem
                id: lista_workout
                anchors {
                    top: parent.top
                    //topMargin: header.height
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }
                currentIndex: -1

                model: gruppo_model_

                signal reload;

                onReload:
                {
                    lista_workout.model=[]
                    lista_workout.model= gruppo_model_
                    lista_workout.forceLayout()
                    currentIndex: -1
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

                    nome:  _esercizi.getName(ex_name)
                    type:  _esercizi.getType(ex_name)
                    immagine:  _esercizi.getImage(ex_name)

                    ripetizioni:-1
                    serie: -1
                    potenza: -1



                    width: lista_workout.width-2

                    onPressed: {
                        selected_exercise.code= ex_name
                        selected_exercise.sets=1
                        lista_workout.currentIndex=index
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

}
