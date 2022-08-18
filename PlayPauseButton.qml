import QtQuick 2.0

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Item
{
    width: 100
    height: width
    property color colore: "#D4C9BD"
    state: "play"

    signal pressPause
    signal pressPlay

    states: [
        State {
            name: "play"
            PropertyChanges { target: play; attivo: true}
            PropertyChanges { target: pause; attivo: false}
        },
        State {
            name: "pause"
            PropertyChanges { target: play; attivo: false}
            PropertyChanges { target: pause; attivo: true}
        }
    ]

    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            if (parent.state==="play")
            {
                parent.state="pause"
                parent.pressPlay()
            }
            else
            {
                parent.state="play"
                parent.pressPause()
            }
            console.log("premuto: ",parent.state)

        }
    }

    PlayButton
    {
        anchors.fill: parent
        id: play
        colore: parent.colore
        attivo: true
    }
    PauseButton
    {
        anchors.fill: parent
        id: pause
        colore: parent.colore
        attivo: false
    }
}

