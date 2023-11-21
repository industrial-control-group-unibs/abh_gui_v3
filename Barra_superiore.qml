import QtQuick 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.12

Item
{
    id: barra

    property string titolo: ""
    property color colore: parametri_generali.coloreSfondo
    property bool nero: false
    onColoreChanged:
    {
        nero=(colore.r<0.05) && (colore.g<0.05) && (colore.b<0.05)
    }

    anchors
    {
        left:parent.left
        right:parent.right
        top: parent.top
        bottom: parent.bottom
        bottomMargin: parent.height-parametri_generali.larghezza_barra
    }
    DropShadow {
        anchors.fill: barra_colore
        //horizontalOffset: 3
        verticalOffset: barra_colore.anchors.bottomMargin
        radius: 8.0
        samples: 17
        color: "black"
        source: barra_colore
    }

    Rectangle
    {
        id: barra_colore
        anchors.fill: parent
        anchors.bottomMargin: 5
        color: parametri_generali.coloreSfondo
    }

    Testo {
        property var locale: Qt.locale()
        property date currentDate: new Date()
        property string dateTimeString
        text: dateTimeString
        anchors
        {
            top: immagine_utente.bottom
            bottom: parent.bottom
            left: immagine_utente.left
            right: immagine_utente.right
            //leftMargin: 10
            topMargin: 5
            bottomMargin: 10
        }

        Timer
        {
            property int value: 0
            interval: 10*1000
            repeat: true
            running: true
            onTriggered:
            {
                parent.dateTimeString = Qt.formatTime(new Date(),"hh:mm");
            }
        }

        Component.onCompleted: {
            dateTimeString = Qt.formatTime(new Date(),"hh:mm");
        }
    }

    MouseArea
    {

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: parent.width*0.33
        anchors.rightMargin: parent.width*0.33

        onPressed:
        {
            if (parametri_generali.login_page)
            {
                startstop_udp.string="rewire"
            }
        }
        onReleased:
        {
            if (parametri_generali.login_page)
                startstop_udp.string="stop"
        }
    }


    Image {
        visible: !barra.nero
        id: sfumatura_barra
        anchors.fill: barra_colore
        mipmap: true
        fillMode: Image.Stretch
        source: "file://"+PATH+"/loghi/"+"sfumatura_barra.png"
    }


    IconaWifi
    {
        anchors
        {
            bottom: immagine_utente.bottom
            right: immagine_utente.right
            rightMargin: -80
            bottomMargin: -20
        }
        width: 40
        color: parametri_generali.coloreBordo
        connesso: parametri_generali.wifi_on
        MouseArea
        {
            anchors.fill: parent
            onClicked: pageLoader.source="PaginaConnessioni.qml"
        }
    }
    Rectangle {

        id: immagine_utente

        width:108
        height:108



        anchors
        {
            verticalCenter: barra.verticalCenter
            verticalCenterOffset: -10
            left: parent.left
            leftMargin: 40
        }



        radius: width*0.5
        color: "transparent"
        border{
            color: parametri_generali.coloreBordo
            width: 4
        }
        layer.enabled:true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }

        Image {
            visible: impostazioni_utente.nome !==""
            id: img_barra
            layer.enabled: true
            fillMode: Image.PreserveAspectCrop
            //visible: true
            mipmap: true
            anchors
            {
                fill: parent
                topMargin: parent.border.width
                bottomMargin: parent.border.width
                leftMargin: parent.border.width
                rightMargin: parent.border.width
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    if (parametri_generali.login_page)
                    {
                        pageLoader.source=  "PaginaImpostazioni.qml"
                    }

                }
            }

            source:  "file://"+PATH+"/../utenti/"+impostazioni_utente.identifier+"/"+impostazioni_utente.foto
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: img_barra.width
                    height: img_barra.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: img_barra.adapt ? img_barra.width : Math.min(img_barra.width, img_barra.height)
                        height: img_barra.adapt ? img_barra.height : width
                        radius: Math.min(width, height)
                    }
                }
            }


        }
    }

    Rectangle {
        id: figma_10_661
        objectName:"Iconly/Bold/Setting"
        layer.enabled:true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }
        width:38
        height:40
        //visible: impostazioni_utente.nome !==""

        anchors
        {
            bottom: immagine_utente.bottom
            right: immagine_utente.right
            rightMargin: -15
        }
        color: "transparent"
        clip: false
        Rectangle {
            id: figma_10_662
            anchors.fill: parent
            color: "transparent"
            clip: false
            Shape {
                id: figma_10_663
                objectName:"Vector"
                x:0
                y:0
                width:38
                height:40
                ShapePath {
                    joinStyle: ShapePath.MiterJoin
                    strokeColor: "#ff000000"
                    strokeWidth:1
                    fillColor:"#ffe5e5e5"
                    id: svgpath_figma_10_663
                    fillRule: ShapePath.WindingFill
                    PathSvg {
                        path: "M20.4345 0C21.9469 0 23.3164 0.84 24.0726 2.08C24.4405 2.68 24.6858 3.42 24.6245 4.2C24.5836 4.8 24.7676 5.4 25.0946 5.96C26.137 7.66 28.4466 8.3 30.2452 7.34C32.2687 6.18 34.8236 6.88 35.9886 8.86L37.3581 11.22C38.5435 13.2 37.8895 15.74 35.8456 16.88C34.1082 17.9 33.4951 20.16 34.5375 21.88C34.8645 22.42 35.2324 22.88 35.8047 23.16C36.5201 23.54 37.0719 24.14 37.4603 24.74C38.2165 25.98 38.1552 27.5 37.4194 28.84L35.9886 31.24C35.2324 32.52 33.8221 33.32 32.3709 33.32C31.6555 33.32 30.8584 33.12 30.2044 32.72C29.6729 32.38 29.0598 32.26 28.4057 32.26C26.3822 32.26 24.6858 33.92 24.6245 35.9C24.6245 38.2 22.7441 40 20.3936 40L17.6138 40C15.2429 40 13.3625 38.2 13.3625 35.9C13.3216 33.92 11.6252 32.26 9.6017 32.26C8.92721 32.26 8.31404 32.38 7.80306 32.72C7.14901 33.12 6.33144 33.32 5.63651 33.32C4.16489 33.32 2.75459 32.52 1.99834 31.24L0.58804 28.84C-0.168209 27.54 -0.209087 25.98 0.547161 24.74C0.874188 24.14 1.48736 23.54 2.18229 23.16C2.75459 22.88 3.12249 22.42 3.46996 21.88C4.49192 20.16 3.87874 17.9 2.14141 16.88C0.117939 15.74 -0.536114 13.2 0.628918 11.22L1.99834 8.86C3.18381 6.88 5.71827 6.18 7.76218 7.34C9.54039 8.3 11.85 7.66 12.8924 5.96C13.2194 5.4 13.4034 4.8 13.3625 4.2C13.3216 3.42 13.5465 2.68 13.9348 2.08C14.6911 0.84 16.0605 0.04 17.5525 0L20.4345 0ZM19.0242 14.36C15.8152 14.36 13.2194 16.88 13.2194 20.02C13.2194 23.16 15.8152 25.66 19.0242 25.66C22.2331 25.66 24.7676 23.16 24.7676 20.02C24.7676 16.88 22.2331 14.36 19.0242 14.36Z"
                    }
                }
            }
        }
    }
    Item {
        id: logo_barra
        objectName:"abh Logo Trasparente 2"
        layer.enabled:true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }
        width: 90
        height: 90
        anchors
        {
            verticalCenter: barra.verticalCenter
            right: parent.right
            rightMargin: 40
        }
        Image {
            id: source_logo_barra
            layer.enabled: true
            fillMode: Image.PreserveAspectCrop
            visible: true
            mipmap: true
            anchors.fill:parent
            source: "file://"+PATH+"/loghi/LogoABHCorner.png"
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                if (parametri_generali.login_page)
                {
                    pageLoader.source=  "PaginaAllenamento.qml"
                }
            }
        }

    }

    Item
    {
        id: barra_zona_testo
        anchors{
//            left: immagine_utente.right
//            right: logo_barra.left
            horizontalCenter: parent.horizontalCenter
            top:parent.top
            bottom: parent.bottom
        }
        width: parent.width*0.6

        Titolo
        {

            text:barra.titolo
        }
    }

}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
