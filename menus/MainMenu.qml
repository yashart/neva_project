import QtQuick 2.5
import QtQuick.Controls 1.4
import QtLocation 5.6

MenuBar {
    property variant fileMenu: fileMenu

    Menu {
        id: fileMenu
        title: qsTr("Треки")
        visible: false
        MenuItem {
                text: "Открыть трек"
                shortcut: "Ctrl+O"
                onTriggered: {
                    openGPX.open()
                }
            }
        MenuItem {
                text: "Создать трек из изображений"
                shortcut: "Ctrl+M"
                onTriggered: {
                    makeGPX.open()
                }
            }
    }
    function setMenuVisible()
    {
        fileMenu.visible = true;
    }
}
