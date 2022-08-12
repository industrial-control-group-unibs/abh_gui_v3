import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

ApplicationWindow {
    visible: true
    width:1080
    height:1000

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

    Item {
        id: impostazioni_utente
        property string nome: ""
    }
    Item {
        id: selected_exercise
        property string ex_name: "unselected"
        property string ex_code: "unselected"
        property string source: ""
        property string level: "1"
        property string difficulty: "Facile"
        property string counter: "15"
        property string actual_rep_count: "0"
        property real rep_count: 15
    }

    Item {
        id: zona_allenamento
        property string gruppo: "Braccia"
        onGruppoChanged: _myModel.readFile(gruppo)
    }



    Loader {
        id: pageLoader
        anchors.fill: parent
        //anchors.topMargin: schema_colori.larghezza_barra

        sourceComponent: PaginaLogo{}
//        sourceComponent: DefinizioneUtente1{}
    }




}
