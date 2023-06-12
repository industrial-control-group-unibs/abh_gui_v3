

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls 2.3


import Charts 1.0
import QtWebKit 3.0

Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{id:barra}


    Rectangle
    {
        color: "transparent"
        border.color: parametri_generali.coloreBordo
        anchors.fill: parent
        anchors.margins: 60


        WebView {
            id: webView
            anchors.fill: parent
            url: "www.google.it"
        }
    }


}
