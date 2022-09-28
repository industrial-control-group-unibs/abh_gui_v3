

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}

    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color: "transparent"//parametri_generali.coloreSfondo
        clip: true


        Titolo
        {
            text: "VUOI USCIRE?"
            height: parent.height*0.1
        }


        IconaCerchio{
            visible: true
            anchors{
                left: parent.left
                leftMargin: width*0.2
                verticalCenter: parent.verticalCenter
            }
            width: 100
            onPressed: pageLoader.source= "PaginaLogin.qml"//impostazioni_utente.foto="avatar1.png" //
            Testo
            {
                text: "NO"
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.bottom
                    topMargin: 5
                }
            }

        }


        IconaCerchio{
            visible: true
            anchors{
                right: parent.right
                rightMargin: width*0.2
                verticalCenter: parent.verticalCenter
            }
            width: 100
            onPressed: {
                console.log("exit");
                Qt.callLater(Qt.quit)
            }
            Testo
            {
                text: "SI"
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.bottom
                    topMargin: 5
                }
            }

        }
    }


}
