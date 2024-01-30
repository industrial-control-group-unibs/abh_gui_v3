

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtMultimedia 5.0


Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    property real time_ex: 0
    property real tut_ex: 0

    property real calibrazione: fb_udp.data[5]
    property real ripetizioni:  fb_udp.data[0]
    property bool end_calibration: false

    Component.onCompleted:
    {

        startstop_udp.string="start"
        parametri_generali.login_page=false

    }
    Component.onDestruction:
    {
        startstop_udp.string="stop"
        parametri_generali.login_page=true
    }


    id: component

    Item {
        id: ricevi_comando_vocale
        property real data: fb_udp.data[4]
        onDataChanged:
        {
            if (data==2)
            {
                pageLoader.source = "PaginaAllenamento.qml"
            }
        }
    }

    Barra_superiore{
        Item
        {
            anchors
            {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                leftMargin: 170
                rightMargin: 170
            }
            Titolo
            {

                text: qsTr("MODALITA' MANUALE")
            }
        }
    }


    Item
    {
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 140//210
        FrecceSxDx
        {
            id: freccia
            visible: true

            onPressSx:
            {
                pageLoader.source = "PaginaAllenamento.qml"
            }
            dx_visible: false
            onPressDx:
            {
                pageLoader.source = "PaginaAllenamento.qml"
            }
            z:5
        }
    }



    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true


        WorkoutTopManuale{
            id: video_top
        }
        WorkoutBottomManuale{
            id: sotto
        }


    }
}
