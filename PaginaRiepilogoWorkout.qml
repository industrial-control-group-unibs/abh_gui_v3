

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Component.onCompleted:
    {
        timer_tut.stop()
        timer_tut.active=false
        timer_tempo.stop()
        startstop_udp.string="rewire"
    }
    Component.onDestruction:
    {
        startstop_udp.string="stop_rewire"
    }

    Barra_superiore{}

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true


        Item {
            anchors
            {
                left: parent.left
                right: parent.right
                top:parent.top
                topMargin: 10
            }
            height: parent.height*0.2
            id: titolo
            Titolo
            {
                text: selected_exercise.workout.replace("_", " ")
            }
        }

        Item {
            anchors
            {
                left: parent.left
                right: parent.right
                top:titolo.bottom
                bottom: avanti.top
                bottomMargin: 10
            }

            id: indicatori
            property real spacing: 10
            property real h:  (height-spacing*3)/3
            property real w: width

            Column {
                spacing: indicatori.spacing
                Item {
                    width: indicatori.w;
                    height: indicatori.h

                    CircularIndicator
                    {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.7
                        width: height

                        stepSize: 0.01
                        trackColor: parametri_generali.coloreBordo
                        trackWidth: 0.1*width
                        progressWidth: trackWidth
                        handleColor: "transparent"
                        progressColor: parametri_generali.coloreUtente
                        value: _workout.getScore()


                        Testo
                        {
                            text: (parent.value*10).toFixed(1).toString()
                            font.pixelSize: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: parametri_generali.coloreBordo
                            anchors
                            {
                                fill:parent
                            }
                        }
                    }
                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.15*parent.height
                        text: qsTr("PUNTEGGIO")
                    }
                }
                Item {
                    width: indicatori.w;
                    height: indicatori.h

                    CircularIndicator
                    {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.7
                        width: height

                        stepSize: 0.01
                        trackColor: parametri_generali.coloreBordo
                        trackWidth: 0.1*width
                        progressWidth: trackWidth
                        handleColor: "transparent"
                        progressColor: parametri_generali.coloreUtente
                        value: _workout.getProgess()


                        Testo
                        {
                            text: (parent.value*100).toFixed(0).toString()+"%"
                            font.pixelSize: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: parametri_generali.coloreBordo
                            anchors
                            {
                                fill:parent
                            }
                        }
                    }
                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.15*parent.height
                        text: qsTr("AVANZAMENTO")
                    }
                }
                Item {
                    width: indicatori.w;
                    height: indicatori.h*0.5

                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.5*parent.height
                        text: "DURATA SESSIONE"
                        font.pixelSize: 50
                    }
                    Rectangle
                    {
                        anchors
                        {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                        }
                        height: 0.5*parent.height
                        radius: 0.5*height
                        width: parent.width*0.8
                        color: parametri_generali.coloreUtente
                        Testo
                        {
                            anchors.fill: parent
                            font.pixelSize: 50
                            font.bold: true
                            text: _workout.getTime()
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
                Item {
                    width: indicatori.w;
                    height: indicatori.h*0.5

                    Testo
                    {
                        anchors
                        {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        height: 0.5*parent.height
                        text: qsTr("TU")
                        font.pixelSize: 50
                    }

                    Rectangle
                    {
                        anchors
                        {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                        }
                        height: 0.5*parent.height
                        radius: 0.5*height
                        width: parent.width*0.8
                        color: parametri_generali.coloreUtente
                        Testo
                        {
                            anchors.fill: parent
                            font.pixelSize: 50
                            font.bold: true
                            text: _workout.getTut()
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }



        IconaPlus
        {
            id: avanti
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.1
            width: 100
            onPressed:
            {
                selected_exercise.current_set=0
                pageLoader.source = "PaginaProseguiWorkout.qml"
            }
//            Testo
//            {
//                text: "CONTINUA"
//                anchors
//                {
//                    horizontalCenter: parent.horizontalCenter
//                    top: parent.bottom
//                    topMargin: 5

//                }
//            }
        }


    }
}
