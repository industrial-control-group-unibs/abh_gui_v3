

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Component.onCompleted:
    {
        if (impostazioni_utente.nome ==="")
            pageLoader.source="PaginaLogin.qml"
    }

    Barra_superiore{}

    QuattroImmagini
    {
        immagine11: "workout.jpg"
        testo11: "ALLENAMENTO\n GUIDATO"
        link11: "SceltaWorkout.qml"
        immagine21: "allenamento_singolo.jpg"
        testo21: "ESERCIZI\n"
        link21: "SceltaGruppo.qml"
        immagine12: "sfida.jpg"
        testo12: "ALLENAMENTO\n PERSONALIZZATO"
        link12: "PaginaAllenamento.qml"
        immagine22: "statistiche.jpg"
        testo22: "STATISTICHE\n"
        link22: "PaginaRiepilogoWorkout.qml"
    }

//    Rectangle{
//        anchors.fill: parent
//        anchors.topMargin: parametri_generali.larghezza_barra
//        color:parametri_generali.coloreSfondo
//        clip: true

//        GridLayout {
//            anchors.left: parent.left
//            anchors.right: parent.right

//            anchors.verticalCenter: parent.verticalCenter
//            columns: 2

//            Icona_4_3{
//                nome: "PROGRAMMA\n DI ALLENAMENTO"
//                link: "SceltaGruppo.qml"
//                immagine: "place_holder_4_3.png"
//            }

//            Icona_4_3{
//                nome: "SFIDA\n"
//                link: "PaginaLogin.qml"
//                immagine: "place_holder_4_3.png"
//            }

//            Icona_4_3{
//                nome: "EXTRA\n"
//                link: "PaginaLogin.qml"
//                immagine: "place_holder_4_3.png"
//            }

//            Icona_4_3{
//                nome: "ALLENAMENTO SINGOLO\n"
//                link: "SceltaGruppo.qml"
//                immagine: "place_holder_4_3.png"
//            }
//        }

//    }
}
