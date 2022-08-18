

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}


    FrecceSxDx
    {
        link_sx: "DefinizioneUtente1.qml"
        dx_visible: false
        z:5
    }

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo

        clip: true

        Titolo
        {
            text: "SCEGLI L'AVATAR"
        }

        Item {
            anchors
            {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: parent.height*.1
            }
            height: parent.height*0.8

            GridView {
                snapMode: ListView.SnapPosition
                highlightRangeMode: ListView.StrictlyEnforceRange
                highlightFollowsCurrentItem: true
                id: lista_utente
                cellWidth: width*0.25; cellHeight: cellWidth
                anchors {
                    fill: parent
                }
                clip: true

                model: ListModel {
                    ListElement { foto: "avatar1.png"}
                    ListElement { foto: "avatar2.png"}
                    ListElement { foto: "avatar3.png"}
                    ListElement { foto: "avatar4.png"}
                }



                delegate:  Rectangle {
                    color: "transparent";
//                    anchors{
//                        horizontalCenter: parent.horizontalCenter
//                        verticalCenter: parent.verticalCenter
//                    }
                    width:.2*parent.width
                    height: width

                    border.color: parametri_generali.coloreBordo
                    border.width: 4
                    radius: width*0.5

                    MouseArea{
                        anchors.fill: parent
                        onPressed: {
                            impostazioni_utente.foto=foto
                            pageLoader.source="DefinizioneUtente1.qml"
                        }
                    }

                    Image {

                        fillMode: Image.PreserveAspectCrop
                        visible: false
                        mipmap: true
                        anchors.fill:parent
                        source: "file://"+PATH+"/images/"+foto
                        id: allenamento_icona
                    }

                    Rectangle {
                        id: allenamento_mask
                        anchors
                        {
                            fill: parent
                            topMargin: parent.border.width
                            bottomMargin: parent.border.width
                            leftMargin: parent.border.width
                            rightMargin: parent.border.width
                        }
                        visible: false
                        color: "blue"
                        radius: parent.radius-parent.border.width
                    }
                    OpacityMask {
                        anchors.fill: allenamento_mask
                        source: allenamento_icona
                        maskSource: allenamento_mask
                    }
                }
            }
        }

    }
}
