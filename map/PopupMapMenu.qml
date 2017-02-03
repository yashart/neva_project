import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4


Window
{
    width: 150
    height: 150
    ColumnLayout {
        ToolBar {
            RowLayout {

                ToolButton {
                    iconSource: "/img/popupIconsSet/pikachu.png"
                    exclusiveGroup: iconsSets
                    onClicked: {
                        popupSet1Icon1.visible = true;
                        popupSet1Icon2.visible = true;
                        popupSet1Icon3.visible = true;
                        popupSet1Icon4.visible = true;
                        popupSet1Icon5.visible = true;
                        popupSet1Icon6.visible = true;
                        popupSet1Icon7.visible = true;
                        popupSet1Icon8.visible = true;
                        popupSet1Icon9.visible = true;

                        popupSet2Icon1.visible = false;
                        popupSet2Icon2.visible = false;
                        popupSet2Icon3.visible = false;
                        popupSet2Icon4.visible = false;
                        popupSet2Icon5.visible = false;
                        popupSet2Icon6.visible = false;
                        popupSet2Icon7.visible = false;
                        popupSet2Icon8.visible = false;
                        popupSet2Icon9.visible = false;
                    }
                }
                ToolButton {
                    iconSource: "/img/popupIconsSet/4.png"
                    exclusiveGroup: iconsSets
                    onClicked: {
                        popupSet1Icon1.visible = false;
                        popupSet1Icon2.visible = false;
                        popupSet1Icon3.visible = false;
                        popupSet1Icon4.visible = false;
                        popupSet1Icon5.visible = false;
                        popupSet1Icon6.visible = false;
                        popupSet1Icon7.visible = false;
                        popupSet1Icon8.visible = false;
                        popupSet1Icon9.visible = false;

                        popupSet2Icon1.visible = true;
                        popupSet2Icon2.visible = true;
                        popupSet2Icon3.visible = true;
                        popupSet2Icon4.visible = true;
                        popupSet2Icon5.visible = true;
                        popupSet2Icon6.visible = true;
                        popupSet2Icon7.visible = true;
                        popupSet2Icon8.visible = true;
                        popupSet2Icon9.visible = true;
                    }
                }
            }
        }

        GridLayout {
            columns: 3
            ExclusiveGroup {
                id: popupMapToolsGroup
                property var lon: 0
                property var lat: 0
            }
            ToolButton {
                id: popupSet1Icon1
                iconSource: "/img/popupIconsSet/bullbasaur.png"
                iconName: "bullbasaur"
                checkable: true
                checked: true
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id:popupSet1Icon2
                iconSource: "/img/popupIconsSet/charmander.png"
                iconName: "charmander"
                checkable: true
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet1Icon3
                iconSource: "/img/popupIconsSet/eevee.png"
                iconName: "eevee"
                checkable: true
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet1Icon4
                iconSource: "/img/popupIconsSet/jigglypuff.png"
                iconName: "jigglypuff"
                checkable: true
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet1Icon5
                iconSource: "/img/popupIconsSet/pikachu.png"
                iconName: "pikachu"
                checkable: true
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet1Icon6
                iconSource: "/img/popupIconsSet/pokeball.png"
                iconName: "pokeball"
                checkable: true
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet1Icon7
                iconSource: "/img/popupIconsSet/psyduck.png"
                iconName: "psyduck"
                checkable: true
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet1Icon8
                iconSource: "/img/popupIconsSet/snorlax.png"
                iconName: "snorlax"
                checkable: true
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet1Icon9
                iconSource: "/img/popupIconsSet/squirtle.png"
                iconName: "squirtle"
                checkable: true
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            //------------------Set2
            ToolButton {
                id: popupSet2Icon1
                iconSource: "/img/popupIconsSet/1.png"
                iconName: "1"
                checkable: true
                visible: false
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id:popupSet2Icon2
                iconSource: "/img/popupIconsSet/2.png"
                iconName: "2"
                checkable: true
                visible: false
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet2Icon3
                iconSource: "/img/popupIconsSet/3.png"
                iconName: "3"
                checkable: true
                visible: false
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet2Icon4
                iconSource: "/img/popupIconsSet/4.png"
                iconName: "4"
                checkable: true
                visible: false
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet2Icon5
                iconSource: "/img/popupIconsSet/5.png"
                iconName: "5"
                checkable: true
                exclusiveGroup: popupMapToolsGroup
                visible: false
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet2Icon6
                iconSource: "/img/popupIconsSet/6.png"
                iconName: "6"
                checkable: true
                visible: false
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet2Icon7
                iconSource: "/img/popupIconsSet/7.png"
                iconName: "7"
                checkable: true
                visible: false
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet2Icon8
                iconSource: "/img/popupIconsSet/8.png"
                iconName: "8"
                checkable: true
                visible: false
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
            ToolButton {
                id: popupSet2Icon9
                iconSource: "/img/popupIconsSet/9.png"
                iconName: "9"
                checkable: true
                visible: false
                exclusiveGroup: popupMapToolsGroup
                onClicked: {pageMap.addPopupPoint(popupMapToolsGroup.lon, popupMapToolsGroup.lat)}
            }
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
