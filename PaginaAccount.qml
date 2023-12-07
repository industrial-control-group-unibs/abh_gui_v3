import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1
Rectangle {
    id: pagina_login
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2
    color:parametri_generali.coloreSfondo
    clip: true

    Component.onCompleted:
    {
        pageLoader.source=  "PaginaLogin.qml"
    }
    Component.onDestruction:
    {
    }


    Barra_superiore{}



    IconaOff
    {
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 40
        }
        onPressed: pageLoader.source=  "PaginaExit.qml"
    }

}
