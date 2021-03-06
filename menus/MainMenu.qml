import QtQuick 2.5
import QtQuick.Controls 1.4
import QtLocation 5.6
import "../components"
import "../map"

MenuBar {
    property variant fileMenu: fileMenu

    Menu {
        id: fileMenu
        title: qsTr("Файл")
        visible: false
        MenuItem {
                text: "Открыть карту"
                shortcut: "Ctrl+O"
                onTriggered: {
                    dataBase.printPoints();
                }
            }
    }

    Menu {
        id: mapMenu
        title: qsTr("Карта")
        visible: false
        MenuItem {
            text: "Очистить кэш"
            shortcut: "Ctrl+С"
            onTriggered: {
                pageMap.clearMap();
            }
        }
        MenuItem {
            text: "Тихорецк"
            onTriggered: {
                pageMap.clearMap();
                pageMap.changeSource("1");
            }
        }
        MenuItem {
            text: "Фурмановка"
            shortcut: "Ctrl+С"
            onTriggered: {
                pageMap.clearMap();
            }
        }
    }


    Menu {
        id: trackMenu
        title: qsTr("Треки")
        visible: false
        MenuItem {
                text: "Все треки"
                shortcut: "Ctrl+Alt+A"
                onTriggered: {
                    trackWindow.visible = true;
                }
            }
        MenuItem {
                text: "Открыть трек"
                shortcut: "Ctrl+Alt+O"
                onTriggered: {
                    openGPX.open()
                }
            }
        MenuItem {
                text: "Создать трек из изображений"
                shortcut: "Ctrl+Alt+M"
                onTriggered: {
                    makeGPX.open()
                }
            }
    }
    function setMenuVisible()
    {
        fileMenu.visible = true;
        trackMenu.visible = true;
        mapMenu.visible = true;
    }
}
