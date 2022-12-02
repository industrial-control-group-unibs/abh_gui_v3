
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.12
import StringSender 1.0
import StringReceiver 1.0
import StringSender 1.0
import BinaryReceiver 1.0
import BinarySender 1.0
import UdpVideoStream 1.0
import QtGraphicalEffects 1.12



ApplicationWindow {
    visible: true
    width: 1080/2
    //    height: 1080
    height: width/1080*1920



    visibility: _fullscreen?"FullScreen":false
    onVisibilityChanged: {
        visibility="FullScreen"
    }
    Item {
        id: parametri_generali
        property string coloreBordo:  "#D4C9BD"
        property string coloreSfondo: "#2A211B"
        property string coloreUtente: "#8c177b"
        property int larghezza_barra: 172
        property int offset_icone4x3: 400
        property int logo_time: 2000
        property bool login_page: false
        property string wifi_name

        state: "SABBIA"

        states: [
            State {
                name: "SABBIA"
                PropertyChanges { target: parametri_generali; coloreBordo:  "#D4C9BD"}
                PropertyChanges { target: parametri_generali; coloreSfondo: "#2A211B"}
                PropertyChanges { target: parametri_generali; coloreUtente:  "#8c177b"}
            }
        ]

    }

    Timer
    {
        property int value: 0
        interval: 500
        id: timer_tempo
        repeat: true
        running: false
        onTriggered:
        {
            value+=interval
        }
        signal resetValue
        onResetValue:
        {
            value=0
        }
    }

    Timer
    {
        property int value: 0
        property bool active: false
        interval: 500
        id: timer_tut
        repeat: true
        running: false
        onTriggered:
        {
            value+=interval
        }
        signal resetValue
        onResetValue:
        {
            value=0
        }

    }

    Item {
        id: impostazioni_utente
        property string nome: ""
        property string identifier: ""
        property string foto: ""
        onNomeChanged:
        {

            _utenti.readFile()
        }
    }



    Item {
        id: selected_exercise
        property string code: "unselected"
        property string name: _esercizi.getName(code)
        property string video_intro: _esercizi.getVideoIntro(code)
        property string video_preparati: _esercizi.getVideoPrep(code)
        property string video_workout: _esercizi.getVideoWorkout(code)
        property string immagine: _esercizi.getImage(code)
        property int power: -1
        property int reps: 12
        property int sets: 3
        property int current_set: 0
        property int rest_time: 30
        property int rest_set_time: 30
        property real max_pos_speed: 20
        property real max_neg_speed: -10
        property real score: 0
        property string workout: ""

        property string difficulty: "Facile"  // TO BE REMOVED

        onCodeChanged:
        {
            name= _esercizi.getName(code)
            video_intro= _esercizi.getVideoIntro(code)
            video_preparati= _esercizi.getVideoPrep(code)
            video_workout= _esercizi.getVideoWorkout(code)
            immagine= _esercizi.getImage(code)
            if (workout==="")
            {
                reps=_esercizi.getRepetition(code)
                max_pos_speed=_esercizi.getMaxPosVel(code)
                max_neg_speed=_esercizi.getMaxNegVel(code)
            }
        }
    }

    Item {
        id: zona_allenamento
        property string gruppo: ""
        onGruppoChanged: _myModel.readFile(gruppo)
    }

    StringSender {
        id: exercise_udp
        // @disable-check M16
        port: "21004"
        // @disable-check M16
        host: "localhost"
        // @disable-check M16
        string: selected_exercise.code
    }
    BinarySender {
        id: power_udp
        // @disable-check M16
        port: "21002"
        // @disable-check M16
        host: "localhost"
        // @disable-check M16
        data: [selected_exercise.power]
    }

    StringSender {
        id: user_udp
        // @disable-check M16
        port: "21005"
        // @disable-check M16
        host: "localhost"
        // @disable-check M16
        string: impostazioni_utente.nome
    }

    StringSender {
        id: startstop_udp
        //@disable-check M16
        port: "21003"
        // @disable-check M16
        host: "localhost"
        // @disable-check M16
        string: "stop"
    }


    BinaryReceiver
    {
        id: fb_udp
        // @disable-check M16
        name: "fba"
        // @disable-check M16
        port: "99999"
        // @disable-check M16
        data: [0.0,0.0,0.0,0.0]
        // @disable-check M16
        size: 5
        // @disable-check M16

        property int counter: 0
        onDataChanged:
        {
            if (counter++>100000)
            {
                counter=0
                console.log(data)
            }
            if (data[1]===1 && timer_tut.active)
            {
                timer_tut.start()
            }
            else
            {
                timer_tut.stop()
            }
        }

    }



    Timer
    {

        interval: 1000
        repeat: false
        running: true
        onTriggered:
        {
            fb_udp.port="21012"
        }
    }

    UdpVideoStream {
        id: udpStream
        // @disable-check M16
        port: "5000"
    }



    Rectangle
    {
        anchors.fill: parent
        z:-1
        color: parametri_generali.coloreSfondo
    }

    Loader {
        id: pageLoader
        anchors.fill: parent
        property url last_source


        source:  "PaginaLogo.qml"
//        source:  "PaginaRiepilogoSetWorkout.qml"

    }





}
