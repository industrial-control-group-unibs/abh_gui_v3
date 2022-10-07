import QtQuick 2.0

Item {
id: component
width: 800

property string lettera: ""
property string colore: "white"
property string testo: ""
property string font_colore: "black"
property real keysize: (width-spacing*12)/11
height: spacing*6+keysize*5

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


        KeyBotton{ text: "1"}
        KeyBotton{ text: "2"}
        KeyBotton{ text: "3"}
        KeyBotton{ text: "4"}
        KeyBotton{ text: "5"}
        KeyBotton{ text: "6"}
        KeyBotton{ text: "7"}
        KeyBotton{ text: "8"}
        KeyBotton{ text: "9"}
        KeyBotton{ text: "0"}
        KeyBotton{ text: "-"}
    }

    Row
    {
        spacing: parent.spacing


        KeyBotton{ text: "Q"}
        KeyBotton{ text: "W"}
        KeyBotton{ text: "E"}
        KeyBotton{ text: "R"}
        KeyBotton{ text: "T"}
        KeyBotton{ text: "Y"}
        KeyBotton{ text: "U"}
        KeyBotton{ text: "I"}
        KeyBotton{ text: "O"}
        KeyBotton{ text: "P"}
        KeyBotton{ text: "À"}
    }

    Row
    {
        spacing: parent.spacing

        KeyBotton{ text: "A"}
        KeyBotton{ text: "S"}
        KeyBotton{ text: "D"}
        KeyBotton{ text: "F"}
        KeyBotton{ text: "G"}
        KeyBotton{ text: "H"}
        KeyBotton{ text: "J"}
        KeyBotton{ text: "K"}
        KeyBotton{ text: "L"}


        KeyBotton{ text: "É"}
        KeyBotton{ text: "È"}
    }

    Row
    {
        spacing: parent.spacing

        KeyBotton{ text: "Z"}
        KeyBotton{ text: "X"}
        KeyBotton{ text: "C"}
        KeyBotton{ text: "V"}
        KeyBotton{ text: "B"}
        KeyBotton{ text: "N"}
        KeyBotton{ text: "M"}

        KeyBotton{ text: "Ì"}
        KeyBotton{ text: "Ò"}
        KeyBotton{ text: "Ù"}
        KeyBotton{ text: "Ñ"}
    }

    Row
    {
        spacing: parent.spacing
        Rectangle {


            property string text: " "
            color: component.colore;
            radius: height*0.1
            width: component.keysize*6+5*component.spacing;
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
                    component.testo+=" "
                }
            }
        }
        Rectangle {


            property string text: "CANCELLA"
            color: component.colore;
            radius: height*0.1
            width: component.keysize*5+4*component.spacing;
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
