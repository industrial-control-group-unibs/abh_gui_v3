

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


    Tastiera
    {
        z: 4
        id: tastiera
        anchors.left: parent.left
        anchors.right: parent.right
        //anchors.top: barra.bottom
        anchors.bottom: parent.bottom
        colore: parametri_generali.coloreBordo
        font_colore: parametri_generali.coloreSfondo
        visible: dati_utente.visible
        testo: avanti.dati[lista_utente.currentIndex]
    }



    Rectangle{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        color:parametri_generali.coloreSfondo
        clip: true

        Titolo
        {
            text: "UTENTE"
            height: parent.height*0.1
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
            id: icona_foto

            IconaCerchio{
                id: link_foto
                visible: true
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                width: 100
                onPressed: pageLoader.source= "PaginaScattaFoto.qml" //"PaginaSceltaAvatar.qml"//impostazioni_utente.foto="avatar1.png" //
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
                    onPressed: pageLoader.source= "PaginaScattaFoto.qml"
                }

                Image {

                    fillMode: Image.PreserveAspectCrop
                    visible: false
                    mipmap: true
                    anchors.fill:parent
                    source: "file://"+PATH+"/utenti/"+impostazioni_utente.foto
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
            visible: link_foto.visible

            anchors
            {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: parent.height*.5
            }
            height: parent.height*0.2


            IconaPlus
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height*0.1
                width: 100
                onPressed:
                {
                    if (impostazioni_utente.identifier !=="")
                        pageLoader.source = "PaginaAllenamento.qml"
                    else
                        pageLoader.source = "PaginaLogin.qml"

                }
                Testo
                {
                    text: "CONTINUA"
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.bottom
                        topMargin: 5

                    }
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
                id: avanti
                property var dati: ["","","","","","","","","","",""]
                Component.onCompleted:
                {
                    if (impostazioni_utente.identifier !=="")
                    {
                        dati=_utenti.getUser(impostazioni_utente.identifier)
                    }
                    else
                    {
                        dati:["","","","","","","","","","",""]
                    }
                }

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
                            lista_utente.currentIndex++;
                            tastiera.testo=avanti.dati[lista_utente.currentIndex]
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
                            if (impostazioni_utente.identifier !=="")
                            {
                                _utenti.editUser(impostazioni_utente.identifier,avanti.dati)
                            }
                            else
                            {
                                impostazioni_utente.identifier=_utenti.addUser(dati)
                            }
                            _utenti.readFile()
                            pageLoader.source="PaginaSceltaPrivacy.qml"//"PaginaLogin.qml"
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
                id: icona_cerchio_indietro
                //visible: (lista_utente.currentIndex>0)
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
                        tastiera.testo=avanti.dati[lista_utente.currentIndex]
                    }
                    else
                    {
                        if (impostazioni_utente.identifier !=="")
                            pageLoader.source = "PaginaAllenamento.qml"
                        else
                            pageLoader.source = "PaginaLogin.qml"
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

                onCurrentItemChanged:
                {
                    if (lista_utente.currentItem.campo_tipo==="numerico")
                        tastiera.state="numbers"
                    else
                        tastiera.state="letter"
                }

                delegate: Item {
                    property alias name: input_nome.text
                    property alias colore: casella.colore
                    property bool campo_obbligatorio: obbligatorio
                    property string campo_tipo: tipo
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


                        Text {
                            id: input_nome
                            anchors.left:parent.left
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter

                            height: 60
                            text: tastiera.testo

                            color: parametri_generali.coloreBordo
                            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                            font.italic: false
                            font.letterSpacing: 0
                            font.pixelSize: 25
                            font.weight: Font.Normal
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                        }
                    }


                }

            }

        }

    }

}
