import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4


Window
{
    width: 150
    height: 150
    GridLayout {
        columns: 3
        ExclusiveGroup {id: popupMapToolsGroup}
        ToolButton {
            iconSource: "/img/bullbasaur.png"
            iconName: "bullbasaur"
            checkable: true
            checked: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint()}
        }
        ToolButton {
            iconSource: "/img/charmander.png"
            iconName: "charmander"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint()}
        }
        ToolButton {
            iconSource: "/img/eevee.png"
            iconName: "eevee"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint()}
        }
        ToolButton {
            iconSource: "/img/jigglypuff.png"
            iconName: "jigglypuff"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint()}
        }
        ToolButton {
            iconSource: "/img/pikachu.png"
            iconName: "pikachu"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint()}
        }
        ToolButton {
            iconSource: "/img/pokeball.png"
            iconName: "pokeball"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint()}
        }
        ToolButton {
            iconSource: "/img/psyduck.png"
            iconName: "psyduck"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint()}
        }
        ToolButton {
            iconSource: "/img/snorlax.png"
            iconName: "snorlax"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint()}
        }
        ToolButton {
            iconSource: "/img/squirtle.png"
            iconName: "squirtle"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint()}
        }
    }
    function getActiveTool()
    {
        return popupMapToolsGroup.current.iconName;
    }
    function getActiveToolIcon()
    {
        return popupMapToolsGroup.current.iconSource;
    }
}
