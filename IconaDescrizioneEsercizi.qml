import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

IconaRettangolo
{

    id:component

    property string immagine: "biceps_curl.jpeg"
    property string nome: "NOME"
    property int type: 10
    property int ripetizioni: 10
    property int serie: 4
    property int potenza: 10

    property real fontSize: 35


    text: immagine==="+"?immagine:""

    Item {

        anchors.fill: parent
        visible: immagine!=="+"


        Rectangle {
            id: immagine_id
            anchors
            {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                topMargin: component.bordo
                bottomMargin: component.bordo
                leftMargin: component.bordo
                rightMargin: component.bordo
            }
            color: "transparent"
            width: height

            radius: component.radius
            border.color: component.color
            border.width: component.bordo

            Rectangle
            {
                id: esercizio_mask
                anchors
                {
                    fill: parent
                    //                    topMargin: component.bordo
                    //                    bottomMargin: component.bordo
                    //                    leftMargin: component.bordo
                    //                    rightMargin: component.bordo
                }
                visible: false
                color: "white"
                radius: component.radius
            }

            OpacityMask {
                anchors.fill:esercizio_mask
                source: immagine_esercizio
                maskSource: esercizio_mask
            }

            Image {
                id: immagine_esercizio
                layer.enabled: true
                fillMode: Image.Stretch
                visible: false
                mipmap: true
                anchors.fill: parent
                source: "file://"+PATH+"/immagini_esercizi/"+immagine
            }
        }



        Item {
            id: descrizione
            anchors
            {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                leftMargin: parent.height+parent.height*0.2
                rightMargin: parent.height*0.2
            }

            Testo {
                id: titolo_esercizio
                visible: component.ripetizioni>=0
                text: component.nome
                anchors
                {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                fontSizeMode: Text.Fit
                height: 0.33*parent.height
                font.pixelSize: 40
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignHCenter
            }
            Testo {
                visible: component.ripetizioni<0
                text: component.nome
                anchors
                {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                fontSizeMode: Text.Fit
                wrapMode: Text.WordWrap

                font.pixelSize: 40
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Item {
                visible: component.ripetizioni>=0
                anchors
                {
                    left: parent.left
                    right: parent.right
                    top: titolo_esercizio.bottom
                    bottom: parent.bottom


                }
                Testo
                {
                    anchors.fill: parent
                    font.pixelSize: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    text: component.type===3? "TEMPO\nSERIE\nPOTENZA" :"RIPETIZIONI\nSERIE\nPOTENZA"
                }
                Testo
                {
                    anchors.fill: parent
                    font.pixelSize: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    text: component.ripetizioni+"\n"+component.serie+"\n"+component.potenza
                }

            }

        }
    }

}

