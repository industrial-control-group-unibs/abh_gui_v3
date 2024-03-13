

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import SysCall 1.0
Item {
    id: component
    anchors.fill: parent

    property string titolo: qsTr("CONNESSIONI")
    property int numero_wifi: 0

    Component.onCompleted:
    {
        parametri_generali.wifi_name=""
//        chiamata_sistema.string="nmcli device wifi rescan"
//        chiamata_sistema.call()
        _wifi.readFile("wifi_list")
        numero_wifi=_wifi.rowCount()
        lista_wifi.reload()
    }


    SysCall
    {
        id: chiamata_sistema
    }


    Timer
    {
        interval: 5000
        id: timer_scan
        repeat: true
        running: true
        property int  indice: 0
        onTriggered:
        {
//            chiamata_sistema.string="nmcli device wifi rescan"
//            chiamata_sistema.call()
            //if (lista_wifi.count>0)
              //  indice=lista_wifi.currentItem
            _wifi.readFile("wifi_list")
            numero_wifi=_wifi.rowCount()
            console.info("connessioni: ", numero_wifi)
            lista_wifi.reload()
           // lista_wifi.currentItem=indice
        }
    }

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}


    Item{
        anchors.fill: parent
        anchors.topMargin: parametri_generali.larghezza_barra
        anchors.bottomMargin: parametri_generali.larghezza_barra
        clip: true

        Titolo
        {
            text: component.titolo
            height: 130/1920*component.height
            fontSize: 40
            id: titolo
        }

        Item {

            anchors {
                top: titolo.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                topMargin: parent.width*0.1
                leftMargin: parent.width*0.1
                rightMargin: parent.width*0.1
            }

            Item {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height*0.2
                id: spegni

                property bool acceso: parametri_generali.wifi_acceso
                IconaCerchio
                {
                    id: icona_salva_pwd
                    pieno: parametri_generali.wifi_acceso
                    onPressed: {
                        if (parametri_generali.wifi_acceso)
                        {
                            parametri_generali.wifi_acceso=false
                            pieno=false
                            chiamata_sistema.string="nmcli radio wifi off"
                            chiamata_sistema.call()
                        }
                        else
                        {
                            parametri_generali.wifi_acceso=true
                            pieno=true
                            chiamata_sistema.string="nmcli radio wifi on"
                            chiamata_sistema.call()
                        }

                    }
                }


                Testo
                {
                    text: parent.acceso?qsTr("PREMI PER DISATTIVARE IL WIFI"):qsTr("PREMI PER ATTIVARE IL WIFI")
                    anchors
                    {
                        verticalCenter: icona_salva_pwd.verticalCenter
                        left: icona_salva_pwd.right
                        right: parent.right
                    }
                    anchors.margins: 10
                    fontSizeMode: Text.Fit
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                }
            }

            Item {
                anchors {
                    top: spegni.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                z:10

                Testo
                {
                    text: component.numero_wifi>0?qsTr("RETI DISPONIBILI"):qsTr("NESSUNA RETE WIFI")
                    id: titoletto
                    anchors
                    {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }
                    anchors.margins: 10
                    fontSizeMode: Text.Fit
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                }

                ListView {
                    //            snapMode: ListView.SnapOneItem
                    //            highlightRangeMode: ListView.StrictlyEnforceRange
                    id: lista_wifi
                    clip: true
                    anchors.top: titoletto.bottom
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height*0.5
                    model: _wifi
                    currentIndex:-1
//                    verticalLayoutDirection: ListView.BottomToTop


                    signal reload;

                    onReload:
                    {
                        lista_wifi.model=[]
                        lista_wifi.model= _wifi
                        lista_wifi.forceLayout()
//                        currentIndex:-1
                    }

                    delegate:
                        IconaRettangolo{


                        color: parametri_generali.coloreBordo
                        highlighted:
                        {
                            if (lista_wifi.currentIndex>=0)
                                lista_wifi.currentIndex === index
                            else
                                false;

                        }
                        text: vector[2]

                        width: lista_wifi.width-2

                        Testo
                        {
                            visible: vector[0]==="True"?true:false
                            text: qsTr("CONNESSO")
                            anchors.fill: parent
                            anchors.margins: parent.height*0.1
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignTop
                        }
                        Testo
                        {
                            visible: vector[0]==="False" && vector[1]==="True"?true:false
                            text: "" //qsTr("SALVATA")
                            anchors.fill: parent
                            anchors.margins: parent.height*0.1
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignTop
                        }


                        onPressed: {
                            lista_wifi.currentIndex = index
                            parametri_generali.wifi_name=vector[2]
                            parametri_generali.wifi_known=vector[1]==="True"?true:false
                            parametri_generali.wifi_connected=vector[0]==="True"?true:false
                        }
                        onPressAndHold:
                        {
                            testo_elimina=qsTr("VUOI DIMENTICARE LA CONNESSIONE?")
                            erase=true
                        }
                        onEraseNo:
                        {
                            erase=false
                        }
                        onEraseYes:
                        {
                            chiamata_sistema.string= "nmcli connection delete "+uuid
                            chiamata_sistema.call()
                            lista_wifi.reload()
                        }
                    }
                }
            }
        }
    }

    FrecceSotto
    {
        id: sotto
        swipe_visible: false

        onPressSx:
        {
            if (impostazioni_utente.identifier !=="")
                pageLoader.source="PaginaAllenamento.qml"
            else
                pageLoader.source="PaginaLogin.qml"
        }
        dx_visible: parametri_generali.wifi_name!==""
        onPressDx:
        {
            _history.pop()
            if (parametri_generali.wifi_connected)
                pageLoader.source="PaginaImpostazioni.qml"
            else
                pageLoader.source="PaginaConnessioni2.qml"
        }

        onSwipeDx:
        {
            pageLoader.source=  "SceltaEserciziNew.qml"
        }
        onSwipeSx:
        {

        }
        up_visible: lista_wifi.currentIndex>0
        down_visible: lista_wifi.currentIndex<(lista_wifi.count-1)
        onPressDown: lista_wifi.currentIndex+=1
        onPressUp: lista_wifi.currentIndex-=1
    }





}
