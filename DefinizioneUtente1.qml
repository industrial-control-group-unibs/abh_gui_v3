

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1
Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    id: component
    state: impostazioni_utente.foto===""? "nofoto": "sifoto"

    states: [
        State {
            name: "nofoto"
            PropertyChanges { target: link_foto; visible: true}
        },
        State {
            name: "sifoto"
            PropertyChanges { target: link_foto; visible: false}
        }
    ]

    Barra_superiore{}



    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        Titolo
        {
            text: "UTENTE"
        }




        Item {
            anchors
            {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: parent.height*.1
            }
            height: parent.height*0.4

            IconaCerchio{
                id: link_foto
                visible: true
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                width: 100
                onPressed: pageLoader.source= "PaginaSceltaAvatar.qml"//impostazioni_utente.foto="avatar1.png" //
                Testo
                {
                    text: "SCEGLI FOTO\nPROFILO"
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5
                    }
                }

            }

            Rectangle {
                color: "transparent";
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                width: 300/1080*parent.width
                height: width

                visible: !link_foto.visible
                border.color: parametri_generali.coloreBordo
                border.width: 4
                radius: width*0.5
                MouseArea{
                    anchors.fill: parent
                    onPressed: pageLoader.source= "PaginaSceltaAvatar.qml"
                }

                Image {

                    fillMode: Image.PreserveAspectCrop
                    visible: false
                    mipmap: true
                    anchors.fill:parent
                    source: "file://"+PATH+"/utente/"+impostazioni_utente.foto
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

        Item {
            visible: !link_foto.visible
            id: dati_utente
            anchors
            {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: parent.height*.5
            }
            height: parent.height*0.2

            IconaCerchio
            {
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                width: 100
                z: 3
                property var dati: ["",""]

                Testo
                {
                    id: testo_avanti
                    text: "AVANTI"
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5
                    }
                }
                onPressed:
                {
                    if (lista_utente.currentIndex<lista_utente.count-1)
                    {
                        if (lista_utente.currentItem.name!=="" || !lista_utente.currentItem.campo_obbligatorio)
                        {
                            lista_utente.currentItem.colore=parametri_generali.coloreBordo
                            dati[lista_utente.currentIndex]=lista_utente.currentItem.name
                            console.log(dati)
                            lista_utente.currentIndex++;
                        }
                        else
                        {
                            lista_utente.currentItem.colore="red"
                        }
                    }
                    else
                    {
                        if (testo_avanti.text==="CONFERMA")
                        {
                            _utenti.addUser(dati)
                            _utenti.readFile()
                            pageLoader.source="PaginaLogin.qml"
                        }
                        else
                        {
                            testo_avanti.text="CONFERMA"
                            lista_utente.currentItem.colore=parametri_generali.coloreBordo
                            dati[lista_utente.currentIndex]=lista_utente.currentItem.name
                            dati[lista_utente.currentIndex+1]=impostazioni_utente.foto
                        }
                    }
                }
            }

            IconaCerchio
            {
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                width: 100
                z: 3
                visible: (lista_utente.currentIndex>0)
                Testo
                {
                    text: "INDIETRO"
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5
                    }
                }
                onPressed:
                {
                    if (lista_utente.currentIndex>0)
                    {
                        lista_utente.currentIndex--;
                    }
                }
            }

            ListView {
                snapMode: ListView.SnapPosition
                highlightRangeMode: ListView.StrictlyEnforceRange
                highlightFollowsCurrentItem: true
                id: lista_utente
                anchors {
                    fill: parent
                }
                clip: true

                model: ModelloRichiesteUtente{}

                delegate: Item {
                    property alias name: input_nome.text
                    property alias colore: casella.colore
                    property bool campo_obbligatorio: obbligatorio
                    implicitWidth: 1080
                    implicitHeight: 10
                    width: dati_utente.width
                    height: dati_utente.height//180/1080*parent.width

                    Rectangle
                    {
                        id: casella
                        property color colore: parametri_generali.coloreBordo
                        anchors
                        {
                            horizontalCenter: parent.horizontalCenter
                            verticalCenter: parent.verticalCenter
                        }
                        width: parent.width*0.5
                        height: 80/1080*parent.width
                        radius: 20
                        color: "transparent"
                        border.color: colore
                        Testo
                        {
                            text: campo
                            anchors
                            {
                                horizontalCenter: parent.horizontalCenter
                                top: parent.bottom
                                topMargin: 5
                            }
                        }


                        TextInput {
                            id: input_nome
                            anchors.left:parent.left
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter

                            height: 60
                            text: ""
                            cursorVisible: false

                            color: parametri_generali.coloreBordo
                            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                            font.italic: false
                            font.letterSpacing: 0
                            font.pixelSize: 20
                            font.weight: Font.Normal
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignTop

                        }
                    }


                }

            }

        }

    }
}
