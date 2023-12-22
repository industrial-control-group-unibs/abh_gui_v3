import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1
Rectangle {
    id: component
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2
    color:parametri_generali.coloreSfondo
    clip: true

    property string field_name: qsTr("ACCESS ID")

    state: "id"
    states: [
        State {
            name: "id"
            PropertyChanges { target: component; field_name: qsTr("ACCESS ID")}
            PropertyChanges { target: freccie; sx_visible: false}
        },
        State {
            name: "key"
            PropertyChanges { target: component; field_name: qsTr("ACCESS KEY")}
            PropertyChanges { target: freccie; sx_visible: true}
        },
        State {
            name: "bucket"
            PropertyChanges { target: component; field_name: qsTr("BUCKET")}
            PropertyChanges { target: freccie; sx_visible: true}
        }
    ]

    Barra_superiore{}


    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        clip: true


        Titolo
        {
            id: titolo
            text: qsTr("ACCEDI AL TUO ACCOUNT")
            height: parent.height*0.1
            fontSize: 40
        }

        Column
        {
            id: rect_grid
            anchors.fill: parent
            anchors.topMargin: titolo.height
            clip: true
            spacing: 30

            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
            }
            Testo
            {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
                text: qsTr("DIGITA")+" "+component.field_name
                font.pixelSize: 70
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
            }

            Rectangle
            {
                id: casella
                property color colore: parametri_generali.coloreBordo
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.1
                radius: 20
                color: "transparent"
                border.color: colore

                Testo
                {
                    anchors.fill: parent
                    text: tastierino.testo
                    font.pixelSize: 70
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                }

            }

            Tastiera
            {
                id: tastierino
                anchors.left: parent.left
                anchors.right: parent.right
                colore: parametri_generali.coloreBordo
                font_colore: parametri_generali.coloreSfondo
                onTestoChanged:
                {

                }
            }




        }

    }

    Item
    {
        id: sotto
        anchors
        {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height*0.2
        z:10
        FrecceSxDx
        {
            id: freccie
            onPressSx:
            {
                if (component.state==="bucket")
                    component.state="key"
                else if (component.state==="key")
                    component.state="id"
            }
            onPressDx:
            {
                if (component.state==="id")
                    component.state="key"
                else if (state==="key")
                    component.state="bucket"
                else
                    pageLoader.source=  "PaginaLogin.qml"
            }
            sx_visible: false
        }
    }



}
