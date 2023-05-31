

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
    property int riposo: 40
    property int riposo_finale: 40

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
            onPressSx: pageLoader.source= "SceltaAllenamentoPersonalizzatoEsercizi.qml"
            onPressDx:
            {
                _workout.addRow(programma_personalizzato.sessione,[selected_exercise.code,selected_exercise.power,selected_exercise.reps,selected_exercise.sets,component.riposo,component.riposo_finale,programma_personalizzato.sessione,-1,0,0])
                pageLoader.source=  "SceltaAllenamentoPersonalizzatoEsercizi.qml"
            }
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
            height: parent.height/5.0

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
                    text: "N° SERIE"
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
            height: parent.height/5.0


            LinearSlider
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: 10
                min: 1
                max: 50

                onValueChanged: selected_exercise.reps=value

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: selected_exercise.type===3? "DURATA [SECONDI]" : "N° RIPETIZIONI"
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
            height: parent.height/5.0


            LinearSlider
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: 3
                min: 1
                max: 20

                onValueChanged: selected_exercise.power=value

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "DIFFICOLTA’"
                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
                }

            }


        }

        Item
        {
            id: riposo
            anchors
            {
                top: difficolta.bottom
                left: parent.left
                right: parent.right
            }
            height: parent.height/5.0


            LinearSlider
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: 30
                min: 0
                max: 900
                increment: 5

                onValueChanged: component.riposo=value

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "RIPOSO"
                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
                }

            }


        }

        Item
        {
            id: riposo_set
            anchors
            {
                top: riposo.bottom
                left: parent.left
                right: parent.right
            }
            height: parent.height/5.0


            LinearSlider
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: 30
                min: 0
                max: 900
                increment: 5

                onValueChanged: component.riposo_finale=value

                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "RIPOSO FINALE"
                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
                }

            }


        }


    }

}
