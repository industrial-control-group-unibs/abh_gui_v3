

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0

PaginaSiNo
{
    id: component
    property string frase: ""
    titolo: frase

    state: "init"

    states: [
        State {
            name: "init"
            PropertyChanges { target: component; frase: qsTr("VUOI AGGIORNARE?\nGLI AGGIORNAMENTI SARANNO OPERATIVI DOPO IL RIAVVIO")}
            PropertyChanges { target: component; sino_visible: true}
        },
        State {
            name: "run"
            PropertyChanges { target: component; frase: qsTr("AGGIORNAMENTO IN CORSO")}
            PropertyChanges { target: component; sino_visible: false}
        },
        State {
            name: "reboot"
            PropertyChanges { target: component; frase: qsTr("VUOI SPEGNERE?\nGLI AGGIORNAMENTI SARANNO OPERATIVI DOPO IL RIAVVIO")}
            PropertyChanges { target: component; sino_visible: true}
        }
    ]

    signal aggiorna
    signal spegni
    onPressNo:
    {
        _history.pop()
        pageLoader.source=  "PaginaImpostazioni.qml"
    }
    onPressYes: {
        if (state==="init")
        {
            aggiorna()
            conto_alla_rovescia.running=true
            component.state="run"
        }
        else if (state==="reboot")
        {
            spegni()
        }
        else
        {

        }

    }
    onAggiorna: {
        chiamata_sistema.string=". ~/script_update.sh"
        chiamata_sistema.call()
    }

    onSpegni: {
        chiamata_sistema.string="systemctl poweroff"
        chiamata_sistema.call()
        chiamata_sistema.string="xrandr --output "+parametri_generali.monitor+" --off"
        chiamata_sistema.call()
    }

    Timer{
        id: conto_alla_rovescia
        interval: 100
        repeat: true
        running: false
        property int position: 0
        property int duration: 30*1000
        onTriggered: {
            if (position<duration)
            {
                position+=interval
            }
            else
            {
                component.state="reboot"
            }
        }
    }

    CircularTimer {
        visible: component.state==="run"
        id: tempo
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        width: 200
        height: width
        tacche: 120
        value: (conto_alla_rovescia.position/conto_alla_rovescia.duration)
        tempo: (conto_alla_rovescia.duration-conto_alla_rovescia.position) //timerino.remaining_time
        onTempoChanged:
        {

        }

        colore: parametri_generali.coloreUtente
        coloreTesto: colore

    }

    SysCall
    {
        id: chiamata_sistema
    }
}

