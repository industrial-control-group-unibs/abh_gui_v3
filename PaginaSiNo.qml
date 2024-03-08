

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    id: component
    anchors.fill: parent

    property string titolo: selected_exercise.name

    property bool sino_visible: true
    signal pressYes
    signal pressNo
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra*2
        clip: true


        Titolo
        {
            text: component.titolo
            height: parent.height*0.1
            fontSize: 40
        }

        SiNo
        {
            visible: component.sino_visible
            onPressNo: component.pressNo()
            onPressYes: component.pressYes()
        }
    }
}
