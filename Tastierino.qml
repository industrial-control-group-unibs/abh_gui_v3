import QtQuick 2.0

Item {
id: component
width: 800

property string lettera: ""
property string colore: "white"
property string testo: ""
property string font_colore: "black"
property real keysize: (width-spacing*4)/3
height: spacing*5+keysize*4

property real spacing: 5



Column {

    anchors
    {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom
        leftMargin: parent.spacing
        rightMargin: parent.spacing
        topMargin: parent.spacing
        bottomMargin: parent.spacing
    }

    spacing: parent.spacing

    Row
    {
        spacing: parent.spacing


        KeyBotton{ text: "1" }
        KeyBotton{ text: "2" }
        KeyBotton{ text: "3" }
    }

    Row
    {
        spacing: parent.spacing

        KeyBotton{ text: "4" }
        KeyBotton{ text: "5" }
        KeyBotton{ text: "6" }
    }

    Row
    {
        spacing: parent.spacing

        KeyBotton{ text: "7" }
        KeyBotton{ text: "8" }
        KeyBotton{ text: "9" }
    }

    Row
    {
        spacing: parent.spacing


        Rectangle {


            property string text: "CANCELLA"
            color: component.colore;
            radius: height*0.1
            width: component.keysize*3+2*component.spacing;
            height: component.keysize;
            Text {
                anchors.centerIn: parent
                font.pointSize: 24;
                text: parent.text
                font.family:  "Helvetica" //".AppleSystemUIFont"  //sudo apt-get install fonts-paratype

                color: component.font_colore
            }
            MouseArea
            {
                anchors.fill: parent
                onPressed: {
                    component.testo=component.testo.slice(0, -1)
                }
            }
        }
    }

}

//A – B – C – D – E – F – G – H – I – J – K – L – M – N – O – P – Q – R – S – T – U – V – W – X – Y – Z


}
