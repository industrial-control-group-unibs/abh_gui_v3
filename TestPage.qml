

import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12

import QtQuick.Layouts 1.1

import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls 2.3



Item {
    anchors.fill: parent

    implicitHeight: 1920/2
    implicitWidth: 1080/2

    Barra_superiore{}


    Item {
        id: root
        Item {
            id: appContainer
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: impo
            anchors.right: parent.right
            anchors.bottom: inputPanel.top
        }

        InputPanel {
            id: inputPanel
            externalLanguageSwitchEnabled: true
            onExternalLanguageSwitch: languageDialog.show(localeList, currentIndex)

        }
    }
}
