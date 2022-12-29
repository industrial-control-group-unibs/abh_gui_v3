
import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
Rectangle {
    id: pagina_logo
    objectName:"Pag1"

    anchors.fill: parent

    color:parametri_generali.coloreSfondo
    clip: true 

//    Timer {
//        interval: parametri_generali.logo_time; running: true; repeat: false
//        onTriggered: pageLoader.source=  "PaginaLogin.qml"
//    }

    Item {
        id: figma_2_456
        objectName:"abh Logo Trasparente 1"
        layer.enabled:true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }

        width:1019*0.7
        height:855*0.7
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        Image {
            id: source_figma_2_456
            layer.enabled: true
            fillMode: Image.PreserveAspectCrop
            visible: true
            mipmap: true
            anchors.fill:parent
            source: "file://"+PATH+"/loghi/LogoABIntro.png"

            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    pageLoader.source=  "PaginaLogin.qml"
                }
            }
        }
    } 
}
