import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Item {

    signal pressYes
    signal pressNo

    anchors
    {
        fill:parent
    }

    IconaCerchio
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width*0.25
        anchors.verticalCenter: parent.verticalCenter
        width: 150

        onPressed: pressYes()
        Testo
        {
            text: qsTr("SI")
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5
            }
        }
    }


    IconaCerchio
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: parent.width*0.25
        anchors.verticalCenter: parent.verticalCenter
        width: 150
        state: "pieno"
        onPressed: pressNo()
        Testo
        {
            text: qsTr("NO")
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5
            }
        }
    }
}


