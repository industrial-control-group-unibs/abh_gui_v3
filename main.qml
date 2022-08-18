
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
    width: 1080*0.5
    height: width/1080*1920

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
        property int logo_time: 1000

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
        property string code: "unselected"
        property string video_intro: "placeholver_video.mp4"
        property string video_preparati: "placeholver_video.mp4"
        property string video_workout: "placeholver_video.mp4"
        property string immagine: ""
//        property string level: "1"
//        property string difficulty: "Facile"
        property real power: 4
        property real reps: 15
        property real sets: 3
        property real max_pos_speed: 70
        property real max_neg_speed: -70
    }

    Item {
        id: zona_allenamento
        property string gruppo: "Braccia"
        onGruppoChanged: _myModel.readFile(gruppo)
    }

    StringSender {
        id: exercise_udp
        port: "21004"
        host: "localhost"
        string: selected_exercise.code+qsTr(";")+selected_exercise.level+qsTr(";")+selected_exercise.difficulty
    }

    StringSender {
        id: startstop_udp
        port: "21003"
        host: "localhost"
        string: "stop"
    }

    BinaryReceiver {
        id: repetion_udp
        port: "21012"
        data: [0,0]
        size: 2

        onDataChanged:
        {
            if (data[1]===1)
            {
                timer_tut.start()
            }
            else
            {
                timer_tut.stop()
            }
        }
    }

    BinaryReceiver {
        id: feedback_udp
        port: "15005"
        data: [0,0]
        size: 2
    }

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
        property url last_source

        sourceComponent: PaginaLogo{}
//                sourceComponent: TestPage{}
//        sourceComponent: PaginaSceltaAvatar{}
    }




}
