import QtQuick 2.0
import SysCall 1.0
import QtGraphicalEffects 1.12

Item {
    id: component
    anchors.fill: parent

    property string titolo: qsTr("LUMINOSITÀ")
    signal pressYes
    signal pressNo
    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}




    Item
    {
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height*0.3
        FrecceSxDx
        {
            id: freccia
            onPressSx:
            {
                _history.pop()
                pageLoader.source=_history.pop()
            }
            dx_visible: false
            z:5
        }
    }

    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true


        Titolo
        {
            text: component.titolo
            height: parent.height*0.1
            fontSize: 40
        }

        Item
        {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            height: 100
            id: volume

            IconaMeno
            {
//                anchors.left: parent.left
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -parent.width*0.25
//                anchors.top: parent.top
                black: true
                onPressed:
                {
                    if (parametri_generali.luminosita>15)
                    {
                        _user_config.setValue("luminosita",parametri_generali.luminosita-5)
                    }
                }
                id: meno
            }
            IconaPlus
            {
//                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width*0.25
                height: parent.height
                black: true
//                anchors.top: parent.top
                onPressed:
                {
                    if (parametri_generali.luminosita<95)
                    {
                        _user_config.setValue("luminosita",parametri_generali.luminosita+5)
                    }
                }
                id: piu
            }

            Item
            {
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: meno.right
                anchors.right: piu.left
                anchors.leftMargin: meno.width*0.1
                anchors.rightMargin: meno.width*0.1
                height: parent.height*.5



                    RadialGradient {
                        anchors.fill: parent
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: parametri_generali.coloreUtente}
                            GradientStop { position: (0.8*parametri_generali.luminosita+80)/300; color: "transparent" }
                        }
                    }
            }



        }


    }
}




