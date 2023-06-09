import QtQuick 2.0

ListModel {
    ListElement { valore: ""; obbligatorio: true;  tipo: "alfanumerico"; campo: qsTr("NOME")}
    ListElement { valore: ""; obbligatorio: true;  tipo: "alfanumerico"; campo: qsTr("COGNOME")}
    ListElement { valore: ""; obbligatorio: false; tipo: "numerico";     campo: qsTr("DATA DI NASCITA")}
    ListElement { valore: ""; obbligatorio: false; tipo: "numerico";     campo: qsTr("PESO")}
    ListElement { valore: ""; obbligatorio: false; tipo: "numerico";     campo: qsTr("ALTEZZA")}
    ListElement { valore: ""; obbligatorio: false; tipo: "alfanumerico"; campo: qsTr("MAIL")}
    ListElement { valore: ""; obbligatorio: false; tipo: "numerico";     campo: qsTr("TELEFONO")}
    ListElement { valore: ""; obbligatorio: false; tipo: "alfanumerico"; campo: qsTr("INDIRIZZO")}
    ListElement { valore: ""; obbligatorio: false; tipo: "alfanumerico"; campo: qsTr("PROFESSIONE")}
    ListElement { valore: ""; obbligatorio: false; tipo: "alfanumerico"; campo: qsTr("SOCIAL MEDIA")}
    ListElement { valore: ""; obbligatorio: false; tipo: "alfanumerico"; campo: qsTr("STATO")}
}
