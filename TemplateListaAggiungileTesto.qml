import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import Qt.labs.qmlmodels 1.0 //sudo apt install qml-module-qt-labs-qmlmodels



Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    id: component
    property bool link_dx_visible: false
    property bool new_element: false
    property var model
    property variant delegate
    property string text: ""
    property string titolo: ""
    property int elements: lista_workout.count
    property int index: lista_workout.currentIndex
    property int count: lista_workout.count
    signal pressSx
    signal pressDx
    signal erase
    signal reload

    onReload: lista_workout.reload()
    Barra_superiore{titolo: component.titolo}

    Component.onCompleted:
    {
    }

    Component.onDestruction:
    {
    }

    Item
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z:parent.z+2
        height:274+50
        FrecceSxDx
        {
            onPressSx: component.pressSx()
            onPressDx: component.pressDx()
            dx_visible: component.link_dx_visible
            colore: parametri_generali.coloreBordo
        }
    }

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        ListView {
            snapMode: ListView.SnapOneItem
            id: lista_workout
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            currentIndex:-1

            model: component.model

            onCurrentIndexChanged:
            {
            }

            signal reload;
            onReload:
            {
                lista_workout.model=[]
                lista_workout.model= component.model
                lista_workout.forceLayout()
                pageLoader.source=pageLoader.source
                currentIndex=-1
                component.link_dx_visible=false
            }

            delegate: IconaRettangolo{


                color: parametri_generali.coloreBordo
                highlighted:
                {
                    if (lista_workout.currentIndex>=0)
                        lista_workout.currentIndex === index
                    else
                        false;

                }
                image_file: selected_exercise.workout_image
                text:
                {
                    if (modelData==="+")
                        modelData
                    else
                        qsTr("SESSIONE")+" "+modelData
                }

                width: lista_workout.width-2

                onPressed: {
                    lista_workout.currentIndex=index
                    component.link_dx_visible=true
                    if (modelData==="+")
                    {
                        component.new_element=true
                    }
                    else
                    {
                        component.new_element=false
                        component.text=modelData
                    }
                }
                onPressAndHold:
                {
                    if (modelData!=="+")
                    {
                        testo_elimina=qsTr("VUOI ELIMINARE LA SESSIONE?")
                        erase=true
                    }
                }
                onEraseNo:
                {
                    erase=false
                }
                onEraseYes:
                {

                    component.erase()
                    lista_workout.reload()
                }
            }
        }
    }
}
