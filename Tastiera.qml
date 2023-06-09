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


state: "letter"

states: [
    State {
        name: "letter"
    },
    State {
        name: "letter_min"
    },
    State {
        name: "symbols"
    },
    State {
        name: "numbers"
    },
    State {
        name: "symbols1"
    }

]

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


        KeyBotton{ text: component.state==="letter" ? "1" : component.state==="letter_min" ? "1" : component.state==="numbers" ? "1" : "ä"}
        KeyBotton{ text: component.state==="letter" ? "2" : component.state==="letter_min" ? "2" : component.state==="numbers" ? "2" : "Ä"}
        KeyBotton{ text: component.state==="letter" ? "3" : component.state==="letter_min" ? "3" : component.state==="numbers" ? "3" : "ë"}
        KeyBotton{ text: component.state==="letter" ? "4" : component.state==="letter_min" ? "4" : component.state==="numbers" ? "4" : "Ë"}
        KeyBotton{ text: component.state==="letter" ? "5" : component.state==="letter_min" ? "5" : component.state==="numbers" ? "5" : "ï"}
        KeyBotton{ text: component.state==="letter" ? "6" : component.state==="letter_min" ? "6" : component.state==="numbers" ? "6" : "Ï"}
        KeyBotton{ text: component.state==="letter" ? "7" : component.state==="letter_min" ? "7" : component.state==="numbers" ? "7" : "ö"}
        KeyBotton{ text: component.state==="letter" ? "8" : component.state==="letter_min" ? "8" : component.state==="numbers" ? "8" : "Ö"}
        KeyBotton{ text: component.state==="letter" ? "9" : component.state==="letter_min" ? "9" : component.state==="numbers" ? "9" : "ü"}
        KeyBotton{ text: component.state==="letter" ? "0" : component.state==="letter_min" ? "0" : component.state==="numbers" ? "0" : "Ü"}
        KeyBotton{ text: component.state==="letter" ? "-" : component.state==="letter_min" ? "-" : component.state==="numbers" ? "-" : "$"}
    }

    Row
    {
        spacing: parent.spacing


        KeyBotton{ text: component.state==="letter" ? "Q" : component.state==="letter_min" ? "q" : component.state==="numbers" ? "" : "!"}
        KeyBotton{ text: component.state==="letter" ? "W" : component.state==="letter_min" ? "w" : component.state==="numbers" ? "" : '"'}
        KeyBotton{ text: component.state==="letter" ? "E" : component.state==="letter_min" ? "e" : component.state==="numbers" ? "" : "£"}
        KeyBotton{ text: component.state==="letter" ? "R" : component.state==="letter_min" ? "r" : component.state==="numbers" ? "" : "€"}
        KeyBotton{ text: component.state==="letter" ? "T" : component.state==="letter_min" ? "t" : component.state==="numbers" ? "" : "%"}
        KeyBotton{ text: component.state==="letter" ? "Y" : component.state==="letter_min" ? "y" : component.state==="numbers" ? "" : "&"}
        KeyBotton{ text: component.state==="letter" ? "U" : component.state==="letter_min" ? "u" : component.state==="numbers" ? "" : "/"}
        KeyBotton{ text: component.state==="letter" ? "I" : component.state==="letter_min" ? "i" : component.state==="numbers" ? "" : "("}
        KeyBotton{ text: component.state==="letter" ? "O" : component.state==="letter_min" ? "o" : component.state==="numbers" ? "" : ")"}
        KeyBotton{ text: component.state==="letter" ? "P" : component.state==="letter_min" ? "p" : component.state==="numbers" ? "" : "["}
        KeyBotton{ text: component.state==="letter" ? "À" : component.state==="letter_min" ? "à" : component.state==="numbers" ? "" : "]"}
    }

    Row
    {
        spacing: parent.spacing

        KeyBotton{ text: component.state==="letter" ? "A" : component.state==="letter_min" ? "a" : component.state==="numbers" ? "" : "="}
        KeyBotton{ text: component.state==="letter" ? "S" : component.state==="letter_min" ? "s" : component.state==="numbers" ? "" : "?"}
        KeyBotton{ text: component.state==="letter" ? "D" : component.state==="letter_min" ? "d" : component.state==="numbers" ? "" : "^"}
        KeyBotton{ text: component.state==="letter" ? "F" : component.state==="letter_min" ? "f" : component.state==="numbers" ? "" : "Ç"}
        KeyBotton{ text: component.state==="letter" ? "G" : component.state==="letter_min" ? "g" : component.state==="numbers" ? "" : "@"}
        KeyBotton{ text: component.state==="letter" ? "H" : component.state==="letter_min" ? "h" : component.state==="numbers" ? "" : "°"}
        KeyBotton{ text: component.state==="letter" ? "J" : component.state==="letter_min" ? "j" : component.state==="numbers" ? "" : "#"}
        KeyBotton{ text: component.state==="letter" ? "K" : component.state==="letter_min" ? "k" : component.state==="numbers" ? "" : "*"}
        KeyBotton{ text: component.state==="letter" ? "L" : component.state==="letter_min" ? "l" : component.state==="numbers" ? "" : ","}
        KeyBotton{ text: component.state==="letter" ? "É" : component.state==="letter_min" ? "é" : component.state==="numbers" ? "" : ";"}
        KeyBotton{ text: component.state==="letter" ? "È" : component.state==="letter_min" ? "è" : component.state==="numbers" ? "" : "."}
    }

    Row
    {
        spacing: parent.spacing

        KeyBotton{ text: component.state==="letter" ? "Z" : component.state==="letter_min" ? "z" : component.state==="numbers" ? "" : ":"}
        KeyBotton{ text: component.state==="letter" ? "X" : component.state==="letter_min" ? "x" : component.state==="numbers" ? "" : "_"}
        KeyBotton{ text: component.state==="letter" ? "C" : component.state==="letter_min" ? "c" : component.state==="numbers" ? "" : "ç"}
        KeyBotton{ text: component.state==="letter" ? "V" : component.state==="letter_min" ? "v" : component.state==="numbers" ? "" : "|"}
        KeyBotton{ text: component.state==="letter" ? "B" : component.state==="letter_min" ? "b" : component.state==="numbers" ? "" : "'"}
        KeyBotton{ text: component.state==="letter" ? "N" : component.state==="letter_min" ? "n" : component.state==="numbers" ? "" : "\\"}
        KeyBotton{ text: component.state==="letter" ? "M" : component.state==="letter_min" ? "m" : component.state==="numbers" ? "" : "~"}
        KeyBotton{ text: component.state==="letter" ? "Ì" : component.state==="letter_min" ? "ì" : component.state==="numbers" ? "" : "`"}
        KeyBotton{ text: component.state==="letter" ? "Ò" : component.state==="letter_min" ? "ò" : component.state==="numbers" ? "" : "ß"}
        KeyBotton{ text: component.state==="letter" ? "Ù" : component.state==="letter_min" ? "ù" : component.state==="numbers" ? "" : "-"}
        KeyBotton{ text: component.state==="letter" ? "Ñ" : component.state==="letter_min" ? "ñ" : component.state==="numbers" ? "" : "+"}
    }

    Row
    {
        spacing: parent.spacing

        Rectangle {


            property string text: component.state==="letter" ? "abc" : component.state==="letter_min" ? ":@!" : component.state==="numbers" ? "123" : "ABC"
            color: component.colore;
            radius: height*0.1
            width: component.keysize*2+1*component.spacing;
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
                    if (component.state==="letter")
                        component.state="letter_min"
                    else if (component.state==="letter_min")
                        component.state="symbols"
                    else if (component.state==="symbols")
                        component.state="letter"
                    else if (component.state==="numbers")
                        component.state="numbers"
                    else
                        component.state="letter"
                }
            }
        }

        Rectangle {


            property string text: " "
            color: component.colore;
            radius: height*0.1
            width: component.keysize*4+3*component.spacing;
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


            property string text: qsTr("CANCELLA")
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
