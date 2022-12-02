

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    id: component

    property int giorni: 3
    property int settimane: 4

    state: "esordiente"
    states: [
        State {
            name: "esordiente"
            PropertyChanges { target: esordiente; z: 3}
            PropertyChanges { target: intermedio; z: 2}
            PropertyChanges { target: esperto;    z: 1}
        },
        State {
            name: "intermedio"
            PropertyChanges { target: esordiente; z: 2}
            PropertyChanges { target: intermedio; z: 3}
            PropertyChanges { target: esperto;    z: 1}
        },
        State {
            name: "esperto"
            PropertyChanges { target: esordiente; z: 1}
            PropertyChanges { target: intermedio; z: 2}
            PropertyChanges { target: esperto;    z: 3}
        }

    ]

    Component.onDestruction:
    {
        pageLoader.last_source="PaginaConfWorkout.qml"
    }

    Barra_superiore{
        Titolo
        {
            text: selected_exercise.workout
        }
    }


    Item{
        anchors
        {
            left:parent.left
            right:parent.right
            top:parent.top
        }
        height: parent.height*0.7
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true

        Item {
            anchors
            {
                left:parent.left
                right:parent.right
                top:parent.top
            }
            id: s1
            height: parent.height*0.33

            Rectangle{
                color: parametri_generali.coloreBordo
                radius: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -width*0.8
                width: parent.width/3.0
                height: 0.8*width
                id: esordiente

                border.color: parametri_generali.coloreSfondo
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: component.state="esordiente"
                }
                Testo
                {

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "ESORDIENTE"
                    font.pixelSize: parent.height*0.2
                    font.bold: parent.z>2
                    color: parametri_generali.coloreSfondo

                }
            }

            Rectangle{
                color: parametri_generali.coloreBordo
                radius: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width/3.0
                height: 0.8*width
                id: intermedio
                border.color: parametri_generali.coloreSfondo
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: component.state="intermedio"
                }
                Testo
                {

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "INTERMEDIO"
                    font.pixelSize: parent.height*0.2
                    font.bold: parent.z>2
                    color: parametri_generali.coloreSfondo

                }
                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "LIVELLO"
                    font.pixelSize: 20
                    color: parametri_generali.coloreBordo
                }
            }

            Rectangle{
                color: parametri_generali.coloreBordo
                radius: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: width*0.8
                width: parent.width/3.0
                height: 0.8*width
                id: esperto
                border.color: parametri_generali.coloreSfondo

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: component.state="esperto"
                }
                Testo
                {

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "ESPERTO"
                    font.pixelSize: parent.height*0.2
                    font.bold: parent.z>2
                    color: parametri_generali.coloreSfondo

                }
            }

        }

        Item {
            anchors
            {
                left:parent.left
                right:parent.right
                top:s1.bottom
            }
            id: s2
            height: parent.height*0.33


            Rectangle{
                //                id: medio
                color: parametri_generali.coloreBordo
                radius: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width/3.0
                height: 0.8*width
                Testo
                {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: component.giorni
                    font.pixelSize: 40
                    color: parametri_generali.coloreSfondo
                }
                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "FREQUENZA (N° allenamenti/settimana)"
                    font.pixelSize: 20
                    color: parametri_generali.coloreBordo
                }
            }


            IconaMeno
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
                anchors.verticalCenter: parent.verticalCenter
                //                height: parent.height/3.0
                onPressed: {
                    if (component.giorni>1)
                        component.giorni--
                }
            }

            IconaPiu
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                anchors.verticalCenter: parent.verticalCenter
                //                height: parent.height/3.0
                onPressed: {
                    if (component.giorni<7)
                        component.giorni++;
                }
            }
        }

        Item {
            anchors
            {
                left:parent.left
                right:parent.right
                top:s2.bottom
            }
            id: s3
            height: parent.height*0.33

            Rectangle{
                //                id: medio
                color: parametri_generali.coloreBordo
                radius: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width/3.0
                height: 0.8*width
                Testo
                {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: component.settimane
                    font.pixelSize: 40
                    color: parametri_generali.coloreSfondo
                }
                Testo
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    width: 300
                    anchors.bottomMargin: 10
                    text: "DURATA (N° settimana)"
                    font.pixelSize: 20
                    color: parametri_generali.coloreBordo
                }
            }


            IconaMeno
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
                anchors.verticalCenter: parent.verticalCenter
                //                height: parent.height/3.0
                onPressed: {
                    if (component.settimane>1)
                        component.settimane--;
                }
            }

            IconaPiu
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                anchors.verticalCenter: parent.verticalCenter
                //                height: parent.height/3.0
                onPressed: {
                    if (component.settimane<12)
                        component.settimane++;
                }
            }
        }

    }

//    Item
//    {
//        id: ripetizioni
//        anchors
//        {
//            top: serie.bottom
//            left: parent.left
//            right: parent.right
//        }
//        height: parent.height/3.0

//        Rectangle{
////                id: medio
//            color: parametri_generali.coloreBordo
//            radius: 20
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.horizontalCenter: parent.horizontalCenter
//            width: parent.width/3.0
//            height: 0.8*width
//            Testo
//            {
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.horizontalCenter: parent.horizontalCenter
//                text: selected_exercise.reps
//                font.pixelSize: 40
//                color: parametri_generali.coloreSfondo
//            }
//            Testo
//            {
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.bottom: parent.top
//                width: 300
//                anchors.bottomMargin: 10
//                text: "N° RIPETIZIONI"
//                font.pixelSize: 20
//                color: parametri_generali.coloreBordo
//            }
//        }


//        IconaMeno
//        {
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.horizontalCenterOffset: -parent.width*0.25
//            anchors.verticalCenter: parent.verticalCenter
////                height: parent.height/3.0
//            onPressed: {
//                if (selected_exercise.reps>1)
//                    selected_exercise.reps--
//            }
//        }

//        IconaPiu
//        {
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.horizontalCenterOffset: parent.width*0.25
//            anchors.verticalCenter: parent.verticalCenter
////                height: parent.height/3.0
//            onPressed: selected_exercise.reps++
//        }
//    }

//    Item
//    {
//        id: difficolta
//        anchors
//        {
//            top: ripetizioni.bottom
//            left: parent.left
//            right: parent.right
//        }
//        height: parent.height/3.0

//        Rectangle{
////                id: medio
//            color: parametri_generali.coloreBordo
//            radius: 20
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.horizontalCenter: parent.horizontalCenter
//            width: parent.width/3.0
//            height: 0.8*width
//            Testo
//            {
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.horizontalCenter: parent.horizontalCenter
//                text: selected_exercise.power
//                font.pixelSize: 40
//                color: parametri_generali.coloreSfondo
//            }
//            Testo
//            {
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.bottom: parent.top
//                width: 300
//                anchors.bottomMargin: 10
//                text: "DIFFICOLTA’"
//                font.pixelSize: 20
//                color: parametri_generali.coloreBordo
//            }
//        }

//        IconaMeno
//        {
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.horizontalCenterOffset: -parent.width*0.25
//            anchors.verticalCenter: parent.verticalCenter
////                height: parent.height/3.0
//            onPressed: {
//                if (selected_exercise.power>1)
//                    selected_exercise.power--
//            }
//        }

//        IconaPiu
//        {
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.horizontalCenterOffset: parent.width*0.25
//            anchors.verticalCenter: parent.verticalCenter
////                height: parent.height/3.0
//            onPressed:
//            {
//                if (selected_exercise.power<20)
//                    selected_exercise.power++
//            }
//        }
//    }

    Item
    {
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height*0.2
        FrecceSxDx
        {
            id: freccia
            onPressSx:
            {
                pageLoader.source=pageLoader.last_source
            }
            dx_visible: true
            onPressDx:
            {
                pageLoader.source="PaginaIstruzioni.qml"
                _workout.createWorkout(impostazioni_utente.identifier,selected_exercise.workout+"_"+component.state,component.giorni*component.settimane)
//                _workout.readFile(selected_exercise.workout+"_"+state)
                selected_exercise.name=_workout.name
                selected_exercise.reps=_workout.reps
                selected_exercise.rest_time=_workout.rest
                selected_exercise.sets=_workout.sets
                selected_exercise.current_set=0
                selected_exercise.power=_workout.power

            }

            z:5
        }
    }
}
