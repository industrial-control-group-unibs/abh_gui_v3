
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
import SysCall 1.0



ApplicationWindow {
    visible: true
    width: 1080
    //    height: 1080
    height: width/1080*1920
    Component.onCompleted:
    {

        _user_config.readFile("user_config")
        updateValue()
    }

    signal updateValue
    onUpdateValue: {
        parametri_generali.lingua=_user_config.getValue("lingua")
        impostazioni_utente.nome=_user_config.getValue("nome")
        impostazioni_utente.foto=_user_config.getValue("foto")
        parametri_generali.coloreBordo=_user_config.getValue("coloreBordo")
        parametri_generali.coloreSfondo =  _user_config.getValue("coloreSfondo")
        parametri_generali.coloreUtente =  _user_config.getValue("coloreUtente")
        parametri_generali.coloreLed =  _user_config.getValue("coloreLed")
        parametri_generali.voice =  _user_config.getValue("voice")==="true"
        parametri_generali.mute =  _user_config.getValue("mute")==="true"
        parametri_generali.volume =  parseInt(_user_config.getValue("volume"))

        console.log("Parametri aggiornati")
    }

    Connections {
        target: _user_config
        onUpdated: updateValue()
    }

    SysCall
    {
        id: chiamata_sistema
        property int volume: getVolume()
        property bool muted: isMuted()
    }

    visibility: _fullscreen?"FullScreen":false
    onVisibilityChanged: {
        visibility="FullScreen"
    }

    Item
    {
        id: programma_personalizzato
        property string name: "UNDEFINED"
        property int sessione: 0
        property bool nuovo_esercizio: false
        property int indice_esercizio: 0
    }

    Item {
        id: parametri_generali
        property color coloreBordo:  _default[0]
        property color coloreBordoTrasparent:  "#c6aa7640"
        property color coloreSfondo: "#2A211B"
        property color coloreUtente: "#8c177b"
        property color coloreUtenteTrasparent: "#c6aa7640"
        property color coloreLed: "#ffffff"
        property color coloreLedInizio: "#ff0000"
        property color coloreLedFine: "#00ff00"
        property color coloreLedPausa: "#ffff00"
        property color coloreLedFinePausa: "#ff0000"

        property int larghezza_barra: 172
        property int offset_icone4x3: 400
        property int logo_time: 2000
        property bool login_page: false
        property string wifi_name
        property bool wifi_known
        property bool wifi_connected
        property string lingua: "abh_it"
        property string wifi_net: _default[9]
        property string monitor: _default[10]
        property string touch: _default[11]
        property bool wifi_on: false
        property bool wifi_acceso: wifi_on
        property bool voice: true
        property bool mute: false
        property int volume: 100

        onWifi_onChanged: {
            if (wifi_on)
                wifi_acceso=true
        }

        onVolumeChanged:
        {
            chiamata_sistema.string="pactl set-sink-volume @DEFAULT_SINK@ "+volume+"%"
            chiamata_sistema.call()
        }

        onMuteChanged:
        {
            if (mute)
                chiamata_sistema.string="pactl set-sink-mute @DEFAULT_SINK@ on"
            else
                chiamata_sistema.string="pactl set-sink-mute @DEFAULT_SINK@ off"
            chiamata_sistema.call()
        }

        onVoiceChanged: console.log("")

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
        onIdentifierChanged:
        {
            console.log("Reading user_config of ",identifier)
            _user_config.readFile(identifier+"/user_config")
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
        property string workout_image: ""
        property bool personalizzato: false
        property bool workout_finito: false
        property int type: 1
        property int  selected_session: 1

        property real time_esercizio: 0
        property real tut_esercizio: 0
        property real completamento: 0
        property string difficulty: "Facile"  // TO BE REMOVED

        property bool corde: selected_exercise.type===1 || selected_exercise.type===3
        property bool a_tempo: selected_exercise.type===2 || selected_exercise.type===4
        property bool movimento: false
        property bool attivo: false

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
        string: impostazioni_utente.identifier
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

    Timer
    {
        id: com_watchdog
        interval: 5000
        repeat: true
        running: true

        onTriggered:
        {
            if (!fb_udp.receivedData())
            {
                console.log("Unable to received data")
                fb_udp.rebootThread()
            }
            _wifi.readFile("wifi_list")
            parametri_generali.wifi_on=false
            for (var index=0; index<_wifi.rowCount(); index++)
            {

                if (_wifi.getValue(index,0)==="True")
                {
                    parametri_generali.wifi_on=true
                }
            }
            console.log("tick")
        }
    }
    BinaryReceiver
    {
        id: fb_udp
        // @disable-check M16
        name: "fba"
        // @disable-check M16
        port: "21012"
        // @disable-check M16
        data: [0.0,0.0,0.0, 0.0,0.0,0.0, 0.0, 0.0]
        // @disable-check M16
        size: 8
        // @disable-check M16



        property int counter: 0
        onDataChanged:
        {
            selected_exercise.movimento = data[2]<-1.5 || data[2]>1.5
            selected_exercise.attivo = data[1]!==5
            if ( (!selected_exercise.corde || (selected_exercise.movimento && selected_exercise.corde))
                    && selected_exercise.attivo && timer_tut.active)
            {
                timer_tut.start()
            }
            else
            {
                timer_tut.stop()
            }
        }

    }





//    Timer
//    {

//        interval: 1000
//        repeat: false
//        running: true
//        onTriggered:
//        {
//            fb_udp.port="21012"
//        }
//    }

//    UdpVideoStream {
//        id: udpStream
//        // @disable-check M16
//        port: "5000"
//    }

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
