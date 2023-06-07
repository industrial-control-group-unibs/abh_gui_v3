

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls 2.3


import Charts 1.0

Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{id:barra}


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
            dx_visible: false
            onPressSx:
            {
                _history.pop()
                pageLoader.source=_history.pop()
            }
        }
    }
    Item{
        anchors.top: barra.bottom
        anchors.bottom: sotto.top
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true

        Statistiche
        {
            Component.onCompleted:
            {
                xvalues=_workout.getSelectedSessionNumbers(selected_exercise.selected_session)
                yvalues=_workout.getSelectedSessionScores(selected_exercise.selected_session)
                yvalues2=_workout.getSelectedSessionMeanScores(selected_exercise.selected_session)
                update()
            }

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: parent.height*0.45
            anchors.margins: 10
            xlabel: "ESERCIZI"
            legend_1: "PUNTEGGIO"
            legend_2: "PUNTEGGIO MEDIO"
        }


        Statistiche
        {
            Component.onCompleted:
            {
                xvalues  =_workout.getSelectedSessionNumbers(selected_exercise.selected_session)
                yvalues  =_workout.getSelectedSessionTimes(selected_exercise.selected_session)
                yvalues2 =_workout.getSelectedSessionTuts(selected_exercise.selected_session)
                ymax = 0.5
                xmax=0
                ystep = 0.5
                update()
            }

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: parent.height*0.45
            anchors.margins: 10
            xlabel: "ESERCIZI"
            ylabel: "TEMPO (MIN)"
            title: "TEMPO/TU"
            legend_2: "TU"
            legend_1: "TEMPO"
        }
    }

}
