

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
//    property string nome_livello: livello.state

    Component.onDestruction:
    {
        pageLoader.last_source="PaginaConfEsercizioSingolo.qml"
        selected_exercise.power=difficolta
        selected_exercise.difficulty=nome_livello
        selected_exercise.level=(Math.min(3,difficolta)).toString()

        timer_tempo.start()
    }

    Component.onCompleted:
    {
        selected_exercise.sets= 3
        selected_exercise.reps= 12
        selected_exercise.power=3
    }

    Barra_superiore{
        Titolo
        {
            text: selected_exercise.name
        }
        id: barra
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
        FrecceSxDx
        {
            onPressSx: pageLoader.source= "SceltaEsercizi.qml"
            onPressDx: pageLoader.source=  "PaginaIstruzioni.qml"
        }
    }

    Item
    {
        anchors
        {
            bottom: sotto.top
            top: barra.bottom
            topMargin: 30
            left: parent.left
            right: parent.right
        }

        Item
        {
            id: serie
            anchors
            {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            height: parent.height/3.0

            Rectangle{
//                id: medio
                color: parametri_generali.coloreBordo
                radius: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width/3.0
                height: 0.8*width
                Testo
                {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: selected_exercise.sets
                    font.pixelSize: 40
                    color: parametri_generali.coloreSfondo
                }

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "N° SERIE"
                    font.pixelSize: 20
                    color: parametri_generali.coloreBordo
                }
            }

            Rectangle
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height/3.0
                width: height
                radius: width*0.5
                border.color: parametri_generali.coloreBordo
                color: "transparent"
                border.width: 5
                id: icona_meno
                Shape {
                    anchors.fill: parent


                    ShapePath {
                        strokeColor: parametri_generali.coloreBordo
                        strokeWidth: 5
//                        strokeStyle: ShapePath.DashLine
                        //startY: parent.width*0.5*(1.0+selected_exercise.max_pos_speed/max)

                        startX: icona_meno.width*0.3
                        startY: icona_meno.height*0.5
                        PathLine { x: icona_meno.width*0.7; y: icona_meno.height*0.5 }
                    }
                }

                MouseArea
                {
                    anchors.fill: parent
                    onPressed: {
                        if (selected_exercise.sets>1)
                            selected_exercise.sets--
                    }
                }
            }

            Rectangle
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height/3.0
                width: height
                radius: width*0.5
                border.color: parametri_generali.coloreBordo
                color: "transparent"
                border.width: 5
                id: icona_piu
                Shape {
                    anchors.fill: parent


                    ShapePath {
                        strokeColor: parametri_generali.coloreBordo
                        strokeWidth: 5
                        startX: icona_piu.width*0.3
                        startY: icona_piu.height*0.5
                        PathLine { x: icona_piu.width*0.7; y: icona_piu.height*0.5 }
                    }
                    ShapePath {
                        strokeColor: parametri_generali.coloreBordo
                        strokeWidth: 5
                        startX: icona_piu.width*0.5
                        startY: icona_piu.height*0.3
                        PathLine { x: icona_piu.width*0.5; y: icona_piu.height*0.7 }
                    }

                }

                MouseArea
                {
                    anchors.fill: parent
                    onPressed: selected_exercise.sets++
                }
            }
        }

        Item
        {
            id: ripetizioni
            anchors
            {
                top: serie.bottom
                left: parent.left
                right: parent.right
            }
            height: parent.height/3.0

            Rectangle{
//                id: medio
                color: parametri_generali.coloreBordo
                radius: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width/3.0
                height: 0.8*width
                Testo
                {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: selected_exercise.reps
                    font.pixelSize: 40
                    color: parametri_generali.coloreSfondo
                }
                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "N° RIPETIZIONI"
                    font.pixelSize: 20
                    color: parametri_generali.coloreBordo
                }
            }
        }

        Item
        {
            id: difficolta
            anchors
            {
                top: ripetizioni.bottom
                left: parent.left
                right: parent.right
            }
            height: parent.height/3.0

            Rectangle{
//                id: medio
                color: parametri_generali.coloreBordo
                radius: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width/3.0
                height: 0.8*width
                Testo
                {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: selected_exercise.power
                    font.pixelSize: 40
                    color: parametri_generali.coloreSfondo
                }
                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "DIFFICOLTA’"
                    font.pixelSize: 20
                    color: parametri_generali.coloreBordo
                }
            }
        }
    }

    /*
    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true





        Item
        {
            id: livello

            state: "Facile"
            states: [
                State {
                    name: "Facile"
                    PropertyChanges { target: facile;    width: livello.width*0.30}
                    PropertyChanges { target: medio;     width: livello.width*0.25}
                    PropertyChanges { target: difficile; width: livello.width*0.25}
                },
                State {
                    name: "Medio"
                    PropertyChanges { target: facile;    width: livello.width*0.25}
                    PropertyChanges { target: medio;     width: livello.width*0.30}
                    PropertyChanges { target: difficile; width: livello.width*0.25}
                },
                State {
                    name: "Difficile"
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
//                anchors.left: parent.left
                anchors.top: parent.top
//                anchors.leftMargin: 30
//                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
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
                    height: 0.8*width
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
                        onPressed: livello.state="Facile"
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
                        onPressed: livello.state="Medio"
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
                        onPressed: livello.state="Difficile"
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
//                anchors.left: parent.left
                anchors.top: parent.top
//                anchors.leftMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
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
                        height: 0.8*width
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
*/

}
