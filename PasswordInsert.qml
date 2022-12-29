import QtQuick 2.0
import SysCall 1.0
import QtGraphicalEffects 1.12

Item {
    id: component
    anchors.fill: parent

    property string titolo: "INSERISCI PASSWORD"
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
                pageLoader.source=pageLoader.last_source
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
            id: titolo
        }

        Item
        {
            id: display
            anchors
            {
                top: titolo.bottom
                bottom: tastierino.top
                horizontalCenter: parent.horizontalCenter
            }

            width: tastierino.width
            property real spacing: 5
            property real key_width: (width-3*spacing)/4

            Row
            {
                spacing: parent.spacing
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Rectangle
                {
                    height: display.key_width
                    width: height
                    radius: 0.1*height
                    color: parametri_generali.coloreBordo

                    Rectangle
                    {
                        visible: tastierino.testo.length>=1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.5
                        width: height
                        radius: 0.5*height
                        color: parametri_generali.coloreSfondo

                    }

                }

                Rectangle
                {
                    height: display.key_width
                    width: height
                    radius: 0.1*height
                    color: parametri_generali.coloreBordo

                    Rectangle
                    {
                        visible: tastierino.testo.length>=2
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.5
                        width: height
                        radius: 0.5*height
                        color: parametri_generali.coloreSfondo

                    }

                }

                Rectangle
                {
                    height: display.key_width
                    width: height
                    radius: 0.1*height
                    color: parametri_generali.coloreBordo

                    Rectangle
                    {
                        visible: tastierino.testo.length>=3
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.5
                        width: height
                        radius: 0.5*height
                        color: parametri_generali.coloreSfondo

                    }

                }

                Rectangle
                {
                    height: display.key_width
                    width: height
                    radius: 0.1*height
                    color: parametri_generali.coloreBordo

                    Rectangle
                    {
                        visible: tastierino.testo.length>=4
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.5
                        width: height
                        radius: 0.5*height
                        color: parametri_generali.coloreSfondo

                    }

                }


            }

        }


        Tastierino
        {
            id: tastierino
            width: parent.width*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width*0.1
            colore: parametri_generali.coloreBordo
            font_colore: parametri_generali.coloreSfondo

            onTestoChanged:
            {
                if (tastierino.testo.length>=4)
                {
                    if (tastierino.testo==="1111")
                        pageLoader.source=  "PaginaAllenamento.qml"
                    else
                        testo=""
                }
            }
        }

    }
}




