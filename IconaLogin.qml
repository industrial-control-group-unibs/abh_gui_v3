import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12




Item
{

    id: component


    implicitWidth: 170
    height: width
    //width: lista_login.cellWidth
    //height: lista_login.cellHeight

    property bool active: false

    signal pressed
    signal selected
    signal erase
    signal clicked


    onSelected:
    {
        if (identifier === "")
            pressed()
        else
            active= true
        clicked()
    }

    onErase: {
        if(identifier !== "") {
            impostazioni_utente.nome=nome
            impostazioni_utente.foto=foto
            impostazioni_utente.identifier=identifier
            pageLoader.source=  "PaginaCancellaUtente.qml"
        }
    }


    onPressed: {
        if(identifier === "") {
            pageLoader.source=  "DefinizioneUtente1.qml"
            impostazioni_utente.nome=""
            impostazioni_utente.foto=""
            impostazioni_utente.identifier=""
        }
        else
        {

            impostazioni_utente.identifier=identifier


            if (_utenti.getStorePassword(impostazioni_utente.identifier))
                pageLoader.source=  "PaginaMondi.qml"
            else
                pageLoader.source=  "PasswordInsert.qml"
        }
    }

    MouseArea {
        anchors.fill: parent
        pressAndHoldInterval: 500
        z: 10
        preventStealing: true
        onPressAndHold: component.active? component.pressed(): component.selected()


        onClicked: component.pressed()
    }

    Rectangle {
        color: "transparent";
        anchors.fill: parent
        visible: identifier !== ""

        border.color: parametri_generali.coloreBordo
        border.width: component.active?8:4
        radius: width*0.5



        Image {
            fillMode: Image.PreserveAspectCrop
            visible: false
            mipmap: true
            cache: false
            anchors.fill:parent
            source: "file://"+PATH+"/../utenti/"+identifier+"/foto.png"
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

        Testo
        {
            text: nome
            font.pixelSize: 20
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5
            }
            id: testo
        }

        Rectangle
        {
            border.color: parametri_generali.coloreBordo
            border.width: 4
            z: 20
            color: "transparent"

            width: parent.width*0.2
            height: width
            radius: width*0.5
            anchors.top: testo.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            visible: component.active

            Testo
            {
                text: "X"
                font.pixelSize: 20
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                pressAndHoldInterval: 1000
                z: 10
                preventStealing: true
                onClicked: component.erase()
            }
        }
    }

    Rectangle {
        width:170
        height:width
        radius: width*0.5
        color: "transparent"
        clip: false
        visible: identifier === ""
        border
        {
            color: parametri_generali.coloreBordo
            width: 4
        }
        Shape {

            width:53.68
            height:63
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            ShapePath {
                strokeColor: "transparent"
                strokeWidth:1
                fillColor: parametri_generali.coloreBordo
                id: svgpath_figma_2_468

                PathSvg {
                    path:
                            "M23.625 41.4977C36.4354 41.4977 47.25 43.7166 47.25 52.2859C47.25 60.8552 36.366 63 23.625 63C10.8146 63 0 60.7778 0 52.2119C0 43.6426 10.8808 41.4977 23.625 41.4977ZM53.5468 16.5789C55.1099 16.5789 56.3785 17.9366 56.3785 19.6017L56.3785 23.5019L60.1682 23.5019C61.7281 23.5019 63 24.8595 63 26.5246C63 28.1897 61.7281 29.5473 60.1682 29.5473L56.3785 29.5473L56.3785 33.451C56.3785 35.116 55.1099 36.4737 53.5468 36.4737C51.9869 36.4737 50.715 35.116 50.715 33.451L50.715 29.5473L46.9318 29.5473C45.3686 29.5473 44.1 28.1897 44.1 26.5246C44.1 24.8595 45.3686 23.5019 46.9318 23.5019L50.715 23.5019L50.715 19.6017C50.715 17.9366 51.9869 16.5789 53.5468 16.5789ZM23.625 0C32.3019 0 39.2573 7.41619 39.2573 16.6679C39.2573 25.9197 32.3019 33.3359 23.625 33.3359C14.9481 33.3359 7.99271 25.9197 7.99271 16.6679C7.99271 7.41619 14.9481 0 23.625 0Z"
                }
            }
        }



        Testo
        {
            text: qsTr("NUOVO UTENTE")
            font.pixelSize: 20
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 5

            }
        }
    }

}


