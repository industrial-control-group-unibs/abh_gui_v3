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
    property variant model
    property variant delegate
    property string text: ""
    property string titolo: ""
    property int index: lista_workout.currentIndex
    signal pressSx
    signal pressDx
    signal erase
    signal reload

    onReload: lista_workout.reload()

    Barra_superiore{titolo: component.titolo}

    Component.onCompleted:
    {
        lista_workout.reload()
    }

    Component.onDestruction:
    {
    }


    FrecceSotto
    {

        swipe_visible: false

        onPressSx: component.pressSx()
        onPressDx: component.pressDx()
        dx_visible: component.link_dx_visible

        onSwipeDx:
        {
         }
        onSwipeSx:
        {
        }
        up_visible: lista_workout.currentIndex>0
        down_visible: lista_workout.currentIndex<(lista_workout.count-1)
        onPressDown:  lista_workout.currentIndex<(lista_workout.count-1)?lista_workout.currentIndex+=1:lista_workout.currentIndex
        onPressUp: lista_workout.currentIndex>0?lista_workout.currentIndex-=1:lista_workout.currentIndex
    }



    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        anchors.bottomMargin: parametri_generali.larghezza_barra
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

            delegate: IconaInformazioni{


                color: parametri_generali.coloreBordo
                color2: parametri_generali.coloreUtente
                highlighted:
                {
                    if (lista_workout.currentIndex>=0)
                        lista_workout.currentIndex === index
                    else
                        false;

                }
                titolo: vector[0]
                progress: parseFloat(vector[1])
                punteggio: 10.0*parseFloat(vector[2])


                date: Qt.formatDate(new Date(1000*parseFloat(vector[3])),"dd/MM/yyyy")

                tempo: vector[4]

                width: lista_workout.width-2
                image_file: "file://"+PATH+"/allenamento_programmato/CUSTOM_"+index%8+".jpg"
                onPressed: {
                    lista_workout.currentIndex=index
                    selected_exercise.workout_image=image_file
                    component.link_dx_visible=true
                    if (vector[0]==="+")
                    {
                        component.new_element=true
                    }
                    else
                    {
                        component.new_element=false
                        component.text=vector[0]
                    }
                }
                onPressAndHold:
                {
                    if (vector[0]!=="+")
                        erase=true
                }
                onEraseNo:
                {
                    erase=false
                }
                onEraseYes:
                {
                    component.index=index
                    component.erase()
                    lista_workout.reload()
                }
            }
        }
    }
}
