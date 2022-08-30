
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

    Component.onCompleted: console.log(_esercizi.getImage("addominali1"))


//    visibility: "FullScreen"
    Item {
        id: parametri_generali
        property string coloreTesto: "#473729"
        property string coloreTestoChiaro: "#ffd4c9bd"
        property string coloreSfondo:"#F5F5F5"
        property string coloreBordo: "#D4C9BD"
        property string coloreBarra: "#473729"
        property string coloreIcona: "#ff9f9181"
        property int larghezza_barra: 172
        property int offset_icone4x3: 400
        property int logo_time: 2000

        state: "SABBIA"

        states: [
            State {
                name: "SABBIA"
                PropertyChanges { target: parametri_generali; coloreTesto:  "#473729"}
                PropertyChanges { target: parametri_generali; coloreTestoChiaro:  "#ffd4c9bd"}
                PropertyChanges { target: parametri_generali; coloreSfondo: "#2A211B"}
                PropertyChanges { target: parametri_generali; coloreBordo:  "#D4C9BD"}
                PropertyChanges { target: parametri_generali; coloreBarra:  "#2A211B"}
                PropertyChanges { target: parametri_generali; coloreIcona:  "#ff9f9181"}
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
    }

    Item {
        id: impostazioni_utente
        property string nome: ""
        property string foto: ""
        onNomeChanged: _utenti.readFile()
    }


    Item {
        id: selected_exercise
        property string name: "unselected"
        property string code: _esercizi.getCode(name)
        property string video_intro: _esercizi.getVideoIntro(name)
        property string video_preparati: _esercizi.getVideoPrep(name)
        property string video_workout: _esercizi.getVideoWorkout(name)
        property string immagine: _esercizi.getImage(name)
        //        property string level: "1"
        //        property string difficulty: "Facile"
        property int power: 1
        property int reps: 15
        property int sets: 3
        property int current_set: 0
        property int rest_time: 10
        property real max_pos_speed: 20
        property real max_neg_speed: -10
        property string workout: "workout1"

        property string level: "1"// TO BE REMOVED
        property string difficulty: "Facile"  // TO BE REMOVED

        onNameChanged:
        {
            code= _esercizi.getCode(name)
            video_intro= _esercizi.getVideoIntro(name)
            video_preparati= _esercizi.getVideoPrep(name)
            video_workout= _esercizi.getVideoWorkout(name)
            immagine= _esercizi.getImage(name)
        }
    }

    Item {
        id: zona_allenamento
        property string gruppo: "Braccia"
        onGruppoChanged: _myModel.readFile(gruppo)
    }

    StringSender {
        id: exercise_udp
        // @disable-check M16
        port: "21004"
        // @disable-check M16
        host: "localhost"
        // @disable-check M16
        string: selected_exercise.code+qsTr(";")+selected_exercise.level+qsTr(";")+selected_exercise.difficulty
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

//    BinaryReceiver {
//        id: feedback_udp
//        // @disable-check M16
//        name: "fb"
//        // @disable-check M16
//        port: "15005"
//        // @disable-check M16
//        data: [0.0,0.0,0.0]
//        // @disable-check M16
//        size: 2
//        // @disable-check M16
//        onDataChanged: console.log(data)
//    }

    BinaryReceiver
    {
        id: fb_udp
        // @disable-check M16
        name: "fba"
        // @disable-check M16
        port: "99999"
        // @disable-check M16
        data: [0.0,0.0,0.0]
        // @disable-check M16
        size: 3
        // @disable-check M16
        onDataChanged:
        {
//            console.log(data)
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

        sourceComponent: PaginaLogo{}
        //                sourceComponent: TestPage{}
//        sourceComponent: PaginaRiepilogo{}
    }




}
