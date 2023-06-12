

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

    Component.onDestruction:
    {
        selected_exercise.default_power=selected_exercise.power

    }

    Component.onCompleted:
    {
        selected_exercise.sets= 3
        selected_exercise.reps= 12
        selected_exercise.power=3
    }

    Barra_superiore{
        Item
        {
            anchors
            {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                leftMargin: 170
                rightMargin: 170
            }
            Titolo
            {

                text:selected_exercise.name
            }
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

            LinearSlider
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: 3
                min: 1
                max: 10

                onValueChanged: selected_exercise.sets=value

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: qsTr("N° SERIE")
                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
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


            LinearSlider
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: 10

                min: 1
                increment: selected_exercise.type===3? (value>=30?5:1)   : 1
                max: selected_exercise.type===3? 600 : 50

                onValueChanged: selected_exercise.reps=value

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: selected_exercise.type===3? qsTr("DURATA (SECONDI)") : qsTr("N° RIPETIZIONI")
                    font.pixelSize: 70
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


            LinearSlider
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: 3
                min: 1
                max: 25

                onValueChanged: selected_exercise.power=value

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: qsTr("DIFFICOLTA’")
                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
                }

            }


        }


    }

}
