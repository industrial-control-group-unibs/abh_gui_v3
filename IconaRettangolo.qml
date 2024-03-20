import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Item {
    implicitWidth: 800
    implicitHeight: 225

    property bool highlighted: true
    property bool shadow: !highlighted



    property real margin: 2
    property real bordo: component.highlighted? 8: 2
    property real radius: 20

    property color color: parametri_generali.coloreBordo
    property color colorTransparent: Qt.rgba(color.r, color.g, color.b, 0.440)

    property color colorShadow: parametri_generali.coloreSfondo
    property color colorShadowTransparent: Qt.rgba(colorShadow.r, colorShadow.g, colorShadow.b, 0.440)

    property string testo_elimina: qsTr("VUOI ELIMINARE IL PROGRAMMA DI ALLENAMENTO?")
    property string image_file

    property color colorBordoTransparent: Qt.rgba(parametri_generali.coloreSfondo.r, parametri_generali.coloreSfondo.g, parametri_generali.coloreSfondo.b, 0.70)


    id: component

    onShadowChanged:
    {
        console.log("icona ",component.text," shadow: ",component.shadow?"on":"off")
    }

    signal pressed
    signal pressAndHold
    signal eraseYes
    signal eraseNo

    property string text: ""

    property bool erase: false

    Image {
        //visible: titolo!=="+" && text!=="+"
        visible: text!=="+"
        id: immagine
        fillMode: Image.Stretch
        z: component.z-2
        mipmap: true
        asynchronous: true
        anchors
        {
            fill: parent
            margins: component.margin
        }
        source: component.image_file

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: immagine.width
                height: immagine.height
                Rectangle {
                    anchors.fill: parent
                    radius: component.radius-0*component.bordo-component.margin
                }
            }
        }
        Rectangle
        {
            anchors.fill: parent
            z: component.z+4
            color: component.colorBordoTransparent
        }
    }

    Rectangle
    {
        id: erase_rectange
        visible: component.erase
        anchors.fill: parent
        color: parametri_generali.coloreSfondo
        z: parent.z+20
        radius: parent.radius
        anchors.margins: component.margin

        border.color: component.color
        border.width: component.bordo
        Testo
        {
            id: testo_erase
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: cerchio_sx.right
            anchors.right: cerchio_dx.left
            //anchors.leftMargin: parent.height
            //anchors.rightMargin: parent.height
            //font.pixelSize: 100
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: component.testo_elimina
            fontSizeMode: Text.Fit
        }
        IconaCerchio
        {
            id: cerchio_sx
            anchors.left: parent.left
            anchors.leftMargin: parent.height*0.5-width*0.5
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height*0.5
            state: "pieno"
            onPressed: component.eraseYes()
            Testo
            {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.bottom
                height: parent.width*0.4
                font.pixelSize: 100
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "SI"
                fontSizeMode: Text.Fit
            }
        }
        IconaCerchio
        {
            id: cerchio_dx
            anchors.right: parent.right
            anchors.rightMargin: parent.height*0.5-width*0.5
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height*0.5
            state: "vuoto"
            onPressed: component.eraseNo()

            Testo
            {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.bottom
                height: parent.width*0.40
                font.pixelSize: 100
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "NO"
                fontSizeMode: Text.Fit

            }
        }
    }


    Item {
        visible: component.text==="+"
        anchors.fill: parent
        Rectangle
        {
            color: component.color
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 0.5*parent.height
            width: 0.1*height
            radius: width*0.5
        }
        Rectangle
        {
            color: component.color
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: 0.5*parent.height
            height: 0.1*width
            radius: width*0.5
        }
    }

    Testo
    {
        visible: component.text!=="+"
        text:component.text
        font.pixelSize: 70
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.Fit
        anchors
        {
            //verticalCenter: parent.verticalCenter
            //horizontalCenter: parent.horizontalCenter
            fill: parent
        }
        z: shadow.z+2
    }

    Rectangle   {
        visible: !component.erase
        id: icona
        color: "transparent"
        anchors.fill: parent
        anchors.margins: component.margin

        radius: component.radius
        border.color: component.color
        border.width: component.bordo

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onPressed: {
                component.pressed()
            }
            onPressAndHold:
            {
                component.pressAndHold()
            }
        }

        Rectangle
        {
            visible: component.highlighted
            radius: parent.radius
            anchors.fill: icona
            z: component.z+4
            color: component.colorTransparent
        }


    }

    Rectangle
    {
        id: shadow
        visible: component.shadow
        radius: parent.radius
        anchors.fill: icona
        z: component.z+4
        color: component.colorShadowTransparent
    }

}
