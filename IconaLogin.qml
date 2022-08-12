import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12




Item
{


    implicitWidth: 200
    implicitHeight: 200
    width: lista_login.cellWidth
    height: lista_login.cellHeight


    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(nome === "NUOVO UTENTE") {
                pageLoader.source=  "DefinizioneUtente1.qml"
                impostazioni_utente.nome=""
            }
            else
            {
                impostazioni_utente.nome=nome
                pageLoader.source=  "PaginaMondi.qml"
            }

        }
    }

    //        border.color: "blue"
    Column
    {
        spacing: 10
        anchors.centerIn: parent

        Rectangle {
            id: figma_2_466
            objectName:"Iconly/Light-Outline/Profile"
            layer.enabled:true

            width:170
            height:width
            radius: width*0.5
            color: "transparent"
            clip: false

            border
            {
                color: parametri_generali.coloreIcona
                width: 4
            }
            Shape {
                id: figma_2_468
                objectName:"Combined-Shape"

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
                    fillColor: parametri_generali.coloreIcona
                    id: svgpath_figma_2_468

                    PathSvg {
                        path:
                            if(nome === "NUOVO UTENTE") {
                                "M23.625 41.4977C36.4354 41.4977 47.25 43.7166 47.25 52.2859C47.25 60.8552 36.366 63 23.625 63C10.8146 63 0 60.7778 0 52.2119C0 43.6426 10.8808 41.4977 23.625 41.4977ZM53.5468 16.5789C55.1099 16.5789 56.3785 17.9366 56.3785 19.6017L56.3785 23.5019L60.1682 23.5019C61.7281 23.5019 63 24.8595 63 26.5246C63 28.1897 61.7281 29.5473 60.1682 29.5473L56.3785 29.5473L56.3785 33.451C56.3785 35.116 55.1099 36.4737 53.5468 36.4737C51.9869 36.4737 50.715 35.116 50.715 33.451L50.715 29.5473L46.9318 29.5473C45.3686 29.5473 44.1 28.1897 44.1 26.5246C44.1 24.8595 45.3686 23.5019 46.9318 23.5019L50.715 23.5019L50.715 19.6017C50.715 17.9366 51.9869 16.5789 53.5468 16.5789ZM23.625 0C32.3019 0 39.2573 7.41619 39.2573 16.6679C39.2573 25.9197 32.3019 33.3359 23.625 33.3359C14.9481 33.3359 7.99271 25.9197 7.99271 16.6679C7.99271 7.41619 14.9481 0 23.625 0Z"
                            }
                            else
                            {
                                "M53.68 51.3419C53.68 61.792 38.3622 63 26.8434 63L26.0191 62.9993C18.6803 62.9827 0 62.5492 0 51.2785C0 41.0416 14.7022 39.6736 26.1334 39.622L27.6677 39.6211C35.006 39.6377 53.68 40.0712 53.68 51.3419ZM26.8434 44.3762C12.4033 44.3762 5.08333 46.6971 5.08333 51.2785C5.08333 55.9011 12.4033 58.2442 26.8434 58.2442C41.2801 58.2442 48.5967 55.9233 48.5967 51.3419C48.5967 46.7192 41.2801 44.3762 26.8434 44.3762ZM26.8434 0C36.7661 0 44.835 7.55224 44.835 16.8356C44.835 26.1189 36.7661 33.668 26.8434 33.668L26.7349 33.668C16.8326 33.6395 8.81111 26.0841 8.84489 16.8261C8.84489 7.55224 16.9173 0 26.8434 0ZM26.8434 4.52754C19.5878 4.52754 13.6843 10.0475 13.6843 16.8356C13.6606 23.6015 19.52 29.1183 26.7451 29.1437L26.8434 31.4074L26.8434 29.1437C34.0956 29.1437 39.9957 23.6206 39.9957 16.8356C39.9957 10.0475 34.0956 4.52754 26.8434 4.52754Z"
                            }
                    }

                }
            }
        }

        Text {
            text: nome //"Tizio Caio"
            anchors
            {
                left:parent.left
                right:parent.right
                leftMargin: 5
            }
            color: parametri_generali.coloreIcona
            font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

            font.italic: false
            font.letterSpacing: 0
            font.pixelSize: 20
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop

            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 2
                color: "#80000000"
                radius: 1
                samples: 3
            }
        }
    }
}




// CODICE FOTO PERSONA
//    Image {
//        id: img
//        property string img_name: "pic_foto.jpg"
//        layer.enabled: true
//        fillMode: Image.PreserveAspectCrop
//        visible: true
//        mipmap: true
//        anchors.fill:parent
//        source: "file://"+PATH+"/images/"+img_name

//        layer.effect: OpacityMask {
//            maskSource: Item {
//                width: img.width
//                height: img.height
//                Rectangle {
//                    anchors.centerIn: parent
//                    width: img.adapt ? img.width : Math.min(img.width, img.height)
//                    height: img.adapt ? img.height : width
//                    radius: Math.min(width, height)
//                }
//            }
//        }
//    }
