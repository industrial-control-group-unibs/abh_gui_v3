import QtQuick 2.12

Item
{
    Component.onCompleted: {
    }

    anchors
    {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    height: parent.height*0.3

    property bool is_visible: true


    signal cancel
    signal exit

    Testo
    {
        id: testo1
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height*0.3

        text: "ANALISI IN CORSO"
        color: parametri_generali.coloreUtente
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 60
//        anchors
//        {
//            horizontalCenter: parent.horizontalCenter
//            verticalCenter: parent.verticalCenter

//        }
    }

    Testo
    {
        anchors.top: testo1.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height*0.5
        text: "CONTINUA AD ESEGUIRE\n L'ESERCIZIO"
        color: parametri_generali.coloreUtente
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 40
//        anchors
//        {
//            horizontalCenter: parent.horizontalCenter
//            verticalCenter: parent.verticalCenter

//        }
    }


}






