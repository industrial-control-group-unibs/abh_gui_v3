

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

    property int sets: 40
    property int reps: 40
    property int power: 40


    Component.onDestruction:
    {
        selected_exercise.default_power=selected_exercise.power

    }

    Component.onCompleted:
    {
        if (programma_personalizzato.nuovo_esercizio)
        {
            component.sets= 3
            component.reps= selected_exercise.type===3? 30: 12
            component.power=3
        }
        else
        {
            component.sets=_workout.getValue(programma_personalizzato.sessione,
                              programma_personalizzato.indice_esercizio,
                              "set")

            component.reps=_workout.getValue(programma_personalizzato.sessione,
                              programma_personalizzato.indice_esercizio,
                              "ripetizioni")
            component.power=_workout.getValue(programma_personalizzato.sessione,
                              programma_personalizzato.indice_esercizio,
                              "power")
        }
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
            property var empty_list: ["+", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
            onPressSx:
            {
                _list_string.fromList(_workout.listSessionExercise(programma_personalizzato.sessione))
                _list_string.addRow(empty_list)
                if (!programma_personalizzato.nuovo_esercizio)
                    pageLoader.source= "SceltaAllenamentoPersonalizzatoEserciziSessione.qml"
                else
                    pageLoader.source= "SceltaAllenamentoPersonalizzatoEsercizi.qml"
            }
            onPressDx:
            {

                if (programma_personalizzato.nuovo_esercizio)
                    _workout.addRow(programma_personalizzato.sessione,[selected_exercise.code,selected_exercise.power,selected_exercise.reps,selected_exercise.sets,component.riposo,component.riposo_finale,programma_personalizzato.sessione,-1,0,0])
                else
                {

                    _workout.setValue(programma_personalizzato.sessione,
                                      programma_personalizzato.indice_esercizio,
                                      "set",
                                      selected_exercise.sets)

                    _workout.setValue(programma_personalizzato.sessione,
                                      programma_personalizzato.indice_esercizio,
                                      "ripetizioni",
                                      selected_exercise.reps)
                    _workout.setValue(programma_personalizzato.sessione,
                                      programma_personalizzato.indice_esercizio,
                                      "power",
                                      selected_exercise.power)

                    _workout.setValue(programma_personalizzato.sessione,
                                      programma_personalizzato.indice_esercizio,
                                      "riposo",
                                      component.riposo)

                    _workout.setValue(programma_personalizzato.sessione,
                                      programma_personalizzato.indice_esercizio,
                                      "riposo_set",
                                      component.riposo_set)
                }
                _list_string.fromList(_workout.listSessionExercise(programma_personalizzato.sessione))
                _list_string.addRow(empty_list)
                if (!programma_personalizzato.nuovo_esercizio)
                    pageLoader.source= "SceltaAllenamentoPersonalizzatoEserciziSessione.qml"
                else
                    pageLoader.source= "SceltaAllenamentoPersonalizzatoEsercizi.qml"
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

                value: component.sets
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
            height: parent.height/5.0


            LinearSlider
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.8*parent.width
                height: 0.1*width

                value: component.reps
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
                    textFormat: Text.RichText
                    text: selected_exercise.type===3? (qsTr("<span style='font-size: 70px;'>DURATA </span>")
                        + qsTr("<span style='font-size: 30px'>sec.</span>")) : qsTr("N° RIPETIZIONI")
                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
                }

            }


        }

        Item
        {
            visible: selected_exercise.type===1
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

                value: component.power
                min: 1
                max: 20

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

                value: component.riposo
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

                    textFormat: Text.RichText
                    text: qsTr("<span style='font-size: 70px;'>PAUSA </span>")
                        + qsTr("<span style='font-size: 30px'>sec.</span>")

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

                value: component.riposo_finale
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
                    textFormat: Text.RichText
                    text: qsTr("<span style='font-size: 70px;'>RIPOSO </span>")
                        + qsTr("<span style='font-size: 30px'>sec.</span>")

                    font.pixelSize: 70
                    color: parametri_generali.coloreBordo
                }

            }


        }


    }

}
