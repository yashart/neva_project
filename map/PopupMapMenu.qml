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
        ExclusiveGroup {
            id: popupMapToolsGroup
            property var lon: 0
            property var lat: 0
        }
        ToolButton {
            iconSource: "/img/bullbasaur.png"
            iconName: "bullbasaur"
            checkable: true
            checked: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
        }
        ToolButton {
            iconSource: "/img/charmander.png"
            iconName: "charmander"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
        }
        ToolButton {
            iconSource: "/img/eevee.png"
            iconName: "eevee"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
        }
        ToolButton {
            iconSource: "/img/jigglypuff.png"
            iconName: "jigglypuff"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
        }
        ToolButton {
            iconSource: "/img/pikachu.png"
            iconName: "pikachu"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
        }
        ToolButton {
            iconSource: "/img/pokeball.png"
            iconName: "pokeball"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
        }
        ToolButton {
            iconSource: "/img/psyduck.png"
            iconName: "psyduck"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
        }
        ToolButton {
            iconSource: "/img/snorlax.png"
            iconName: "snorlax"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
        }
        ToolButton {
            iconSource: "/img/squirtle.png"
            iconName: "squirtle"
            checkable: true
            exclusiveGroup: popupMapToolsGroup
            onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
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
    function setCoordinates(coordinate)
    {
        popupMapToolsGroup.lon = coordinate.longitude;
        popupMapToolsGroup.lat = coordinate.latitude;
        console.log(coordinate.longitude + " !@31142 ");
    }
}
