

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    id: component
    property int difficolta: 1
    property string nome_livello: livello.state

    Component.onDestruction:
    {
        pageLoader.last_source="PaginaConfWorkout.qml"
        _workout.readFile(selected_exercise.workout+"_"+nome_livello+"_"+String(difficolta))
        selected_exercise.name=_workout.name
        selected_exercise.reps=_workout.reps
        selected_exercise.rest_time=_workout.rest
        selected_exercise.sets=_workout.sets
        selected_exercise.max_pos_speed=_workout.maxPosSpeed
        selected_exercise.max_neg_speed=_workout.maxNegSpeed
        selected_exercise.current_set=0
        selected_exercise.power=_workout.power

        timer_tempo.start()
    }

    Barra_superiore{
        Titolo
        {
            text: selected_exercise.workout
        }
    }
    FrecceSxDx
    {
        onPressSx: pageLoader.source= "SceltaWorkout.qml"
        onPressDx: pageLoader.source=  "PaginaPreparati.qml"
    }

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true





        Item
        {
            id: livello

            state: "facile"
            states: [
                State {
                    name: "facile"
                    PropertyChanges { target: facile;    width: livello.width*0.30}
                    PropertyChanges { target: medio;     width: livello.width*0.25}
                    PropertyChanges { target: difficile; width: livello.width*0.25}
                },
                State {
                    name: "medio"
                    PropertyChanges { target: facile;    width: livello.width*0.25}
                    PropertyChanges { target: medio;     width: livello.width*0.30}
                    PropertyChanges { target: difficile; width: livello.width*0.25}
                },
                State {
                    name: "difficile"
                    PropertyChanges { target: facile;    width: livello.width*0.25}
                    PropertyChanges { target: medio;     width: livello.width*0.25}
                    PropertyChanges { target: difficile; width: livello.width*0.30}
                }
            ]

            anchors
            {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: parent.height*0.2
            }
            height: parent.height*0.3

            Testo
            {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 30
//                anchors.topMargin: 30
                font.pixelSize: 30
                text: "LIVELLO"
            }
            Row
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 2

                Rectangle{
                    id: facile
                    color: parametri_generali.coloreBordo
                    radius: 20
                    anchors.verticalCenter: parent.verticalCenter
                    width: livello.width*0.25
                    height: 0.66*width
                    Testo
                    {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "ESORDIENTE"
                        font.pixelSize: 20
                        color: parametri_generali.coloreSfondo
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed: livello.state="facile"
                    }
                }

                Rectangle{
                    id: medio
                    color: parametri_generali.coloreBordo
                    radius: 20
                    anchors.verticalCenter: parent.verticalCenter
                    width: livello.width*0.25
                    height: 0.66*width
                    Testo
                    {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "INTERMEDIO"
                        font.pixelSize: 20
                        color: parametri_generali.coloreSfondo
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed: livello.state="medio"
                    }
                }

                Rectangle{
                    id: difficile
                    color: parametri_generali.coloreBordo
                    anchors.verticalCenter: parent.verticalCenter
                    radius: 20
                    width: livello.width*0.25
                    height: 0.66*width
                    Testo
                    {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "ESPERTO"
                        font.pixelSize: 20
                        color: parametri_generali.coloreSfondo
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed: livello.state="difficile"
                    }
                }


            }
        }

        Item
        {

            anchors
            {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: parent.height*0.5
            }
            height: parent.height*0.3

            Testo
            {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 30
//                anchors.topMargin: 30
                font.pixelSize: 30
                text: "DIFFICOLTÀ"
            }


            ListView {
                snapMode: ListView.SnapPosition
                highlightRangeMode: ListView.StrictlyEnforceRange
                highlightFollowsCurrentItem: true
                orientation: ListView.Horizontal
                id: lista_difficolta
                anchors {
                    fill: parent
                }
                spacing: 2
                clip: true

                model: ListModel {
                    ListElement { valore:  1;}
                    ListElement { valore:  2;}
                    ListElement { valore:  3;}
                    ListElement { valore:  4;}
                    ListElement { valore:  5;}
                    ListElement { valore:  6;}
                    ListElement { valore:  7;}
                    ListElement { valore:  8;}
                    ListElement { valore:  9;}
                    ListElement { valore: 10;}
                }


                delegate:

                    Rectangle
                    {
                        anchors.verticalCenter: parent.verticalCenter
                        radius: 20
                        color: parametri_generali.coloreBordo
                        width: lista_difficolta.currentIndex===index?livello.width*0.3: livello.width*0.25
                        height: 0.66*width
                        MouseArea{
                            anchors.fill: parent
                            onPressed:
                            {
                                lista_difficolta.currentIndex=index
                                component.difficolta=valore
                            }

                        }
                        Testo
                        {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: valore
                            font.pixelSize: 20
                            color: parametri_generali.coloreSfondo
                        }
                    }



            }
        }

    }
}
