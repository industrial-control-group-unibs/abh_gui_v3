import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1


Rectangle   {


    //id: esercizio
    color: "transparent"
    width: lista_zona.width-2 //lista_zona.cellWidth-2
    //height: 400

    implicitWidth: 1080
    implicitHeight: 447
    radius: 20
    border.color:  lista_zona.currentIndex !== index ? parametri_generali.coloreSfondo: parametri_generali.coloreIcona
    border.width: 5

//    layer.enabled: true
//    layer.effect: DropShadow {
//        verticalOffset: 2
//        color: "#80000000"
//        radius: 1
//        samples: 3
//    }
    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        onPressed: {
            mouse.accepted = false
            console.log("clicked")
            selected_exercise.ex_name="unselected"
            zona_allenamento.gruppo=ex_name
            console.log("clicked + ",ex_name)

            lista_zona.currentIndex=index
            console.log(lista_zona.currentIndex, index,parent.border.color)
        }
    }

    OpacityMask {
        anchors.fill:zona_mask
        source: immagine_zona
        maskSource: zona_mask
    }

    Rectangle
    {
        id: zona_mask
        anchors
        {
            fill: parent
            topMargin: parent.border.width
            bottomMargin: parent.border.width
            leftMargin: parent.border.width
            rightMargin: parent.border.width
        }
        visible: false
        color: "white"
        radius: parent.radius-parent.border.width
    }

    Text {
        text:ex_name
        anchors
        {
            left:parent.left
            right:parent.right
            leftMargin: 50
            top: parent.top
            topMargin: 50
            //                    verticalCenter: parent.verticalCenter
        }
        color: parametri_generali.coloreTesto
        wrapMode: TextEdit.WordWrap
        font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 30
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignTop

        layer.enabled: true
        layer.effect: DropShadow {
            verticalOffset: 2
            color: "#80000000"
            radius: 1
            samples: 3
        }
    }

    Image {
        id: immagine_zona
        layer.enabled: true
        fillMode: Image.Stretch
        visible: false
        mipmap: true
        anchors
        {
            fill: parent
            leftMargin: 5
            rightMargin: 5
            topMargin: 5
            bottomMargin: 5
        }
        source: "file://"+PATH+"/"+image_name
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
