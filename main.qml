
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

    Item
    {
        id: programma_personalizzato
        property string name: "UNDEFINED"
        property int sessione: 0
    }

    Item {
        id: parametri_generali
        property color coloreBordo:  _default[0]
        property color coloreBordoTrasparent:  "#c6aa7640"
        property color coloreSfondo: "#2A211B"
        property color coloreUtente: "#8c177b"
        property color coloreUtenteTrasparent: "#c6aa7640"
        property color coloreLed: "#8c177b"
        property color coloreLedInizio: "#ff0000"
        property color coloreLedFine: "#00ff00"
        property color coloreLedPausa: "#ffff00"
        property color coloreLedFinePausa: "#ff0000"

        property int larghezza_barra: 172
        property int offset_icone4x3: 400
        property int logo_time: 2000
        property bool login_page: false
        property string wifi_name


        Component.onCompleted:
        {
            coloreBordoTrasparent=Qt.rgba(coloreBordo.r, coloreBordo.g, coloreBordo.b, 0.440)
            coloreUtenteTrasparent=Qt.rgba(coloreUtente.r, coloreUtente.g, coloreUtente.b, 0.440)
        }

        onColoreBordoChanged:
        {
            coloreBordoTrasparent=Qt.rgba(coloreBordo.r, coloreBordo.g, coloreBordo.b, 0.440)
        }

        onColoreUtenteChanged:
        {
            coloreUtenteTrasparent=Qt.rgba(coloreUtente.r, coloreUtente.g, coloreUtente.b, 0.440)
        }

        onColoreLedChanged:
        {
            led_udp.data=[coloreLed.r, coloreLed.g, coloreLed.b]
        }

        state: "SABBIA"

        states: [
            State {
                name: "SABBIA"
                PropertyChanges { target: parametri_generali; coloreBordo:  _default[0]} //"#c6aa76"
                PropertyChanges { target: parametri_generali; coloreSfondo: _default[1]}
                PropertyChanges { target: parametri_generali; coloreUtente: _default[2]}
                PropertyChanges { target: parametri_generali; coloreLed:    _default[3]}
                PropertyChanges { target: parametri_generali; coloreLedInizio:    _default[4]}
                PropertyChanges { target: parametri_generali; coloreLedFine:      _default[5]}
                PropertyChanges { target: parametri_generali; coloreLedPausa:     _default[6]}
                PropertyChanges { target: parametri_generali; coloreLedFinePausa: _default[7]}
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
        property string video_istruzioni: _esercizi.getVideoIstruzioni(code)
        property string immagine: _esercizi.getImage(code)
        property int power: -1
        property int default_power: -1
        property int reps: 12
        property int sets: 3
        property int current_set: 0
        property int rest_time: 30
        property int rest_set_time: 30
        property real max_pos_speed: 20
        property real max_neg_speed: -10
        property real score: 0
        property string workout: ""
        property bool personalizzato: false
        property bool workout_finito: false
        property int type: 1
        property int  selected_session: 1

        property real time_esercizio: 0
        property real tut_esercizio: 0
        property real completamento: 0
        property string difficulty: "Facile"  // TO BE REMOVED

        onCodeChanged:
        {
            name= _esercizi.getName(code)
            video_intro= _esercizi.getVideoIntro(code)
            video_preparati= _esercizi.getVideoPrep(code)
            video_workout= _esercizi.getVideoWorkout(code)
            immagine= _esercizi.getImage(code)
            type=_esercizi.getType(code)
            //if (workout==="")
            //{
                max_pos_speed=_esercizi.getMaxPosVel(code)
                max_neg_speed=_esercizi.getMaxNegVel(code)
            //}
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

    BinarySender {
        id: led_udp
        // @disable-check M16
        port: "21051"
        // @disable-check M16
        host: "localhost"
        // @disable-check M16
        data: [coloreLed.r, coloreLed.g, coloreLed.b]
    }
    BinarySender {
        id: type_udp
        // @disable-check M16
        port: "21007"
        // @disable-check M16
        host: "localhost"
        // @disable-check M16
        data: [selected_exercise.type]
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
        port: "21012"
        // @disable-check M16
        data: [0.0,0.0,0.0,0.0]
        // @disable-check M16
        size: 6
        // @disable-check M16

        property int counter: 0
        onDataChanged:
        {
            if (counter===0)
            {
                console.log("data from coordinator = ",data)
            }
            if (counter++>1000)
            {
                counter=0
            }
            if ((data[1]===1 || data[1]===-1 || selected_exercise.type===3) && timer_tut.active)
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

        onSourceChanged:
        {
            _history.push(source)
        }

        source:  "PaginaLogo.qml"
//        source:  "PaginaSceltaPrivacy.qml"
//        source:  "TestPage.qml"

    }





}
