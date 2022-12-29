import QtQuick 2.0

ListModel {
    ListElement { valore: ""; obbligatorio: true;  tipo: "alfanumerico"; campo: "NOME"}
    ListElement { valore: ""; obbligatorio: true;  tipo: "alfanumerico"; campo: "COGNOME"}
    ListElement { valore: ""; obbligatorio: false; tipo: "numerico";     campo: "DATA DI NASCITA"}
    ListElement { valore: ""; obbligatorio: false; tipo: "numerico";     campo: "PESO"}
    ListElement { valore: ""; obbligatorio: false; tipo: "numerico";     campo: "ALTEZZA"}
    ListElement { valore: ""; obbligatorio: false; tipo: "alfanumerico"; campo: "MAIL"}
    ListElement { valore: ""; obbligatorio: false; tipo: "numerico";     campo: "TELEFONO"}
    ListElement { valore: ""; obbligatorio: false; tipo: "alfanumerico"; campo: "INDIRIZZO"}
    ListElement { valore: ""; obbligatorio: false; tipo: "alfanumerico"; campo: "PROFESSIONE"}
    ListElement { valore: ""; obbligatorio: false; tipo: "alfanumerico"; campo: "SOCIAL MEDIA"}
    ListElement { valore: ""; obbligatorio: false; tipo: "alfanumerico"; campo: "STATO"}
}
