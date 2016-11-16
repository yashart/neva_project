import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4



ToolBar {
    style: ToolBarStyle {
        background: Rectangle {
            implicitHeight: 25
            border.color: "#999"
            gradient: Gradient {
                GradientStop { position: 0 ; color: "#fff" }
                GradientStop { position: 1 ; color: "#eee" }
            }
        }
    }
    RowLayout {
        GroupBox {
            RowLayout {
                ExclusiveGroup { id: mapToolsGroup }
                anchors.fill: parent
                ToolButton {
                    iconSource: "/img/mouse_icon.png"
                    iconName: "mouse"
                    checkable: true
                    checked: true
                    exclusiveGroup: mapToolsGroup
                }
                ToolButton {
                    iconSource: "/img/tank.png"
                    iconName: "add_tank"
                    checkable: true
                    exclusiveGroup: mapToolsGroup
                }
                ToolButton {
                    iconSource: "/img/launcher.png"
                    iconName: "add_launcher"
                    checkable: true
                    exclusiveGroup: mapToolsGroup
                }
                ToolButton {
                    iconSource: "/img/remove_location_icon.png"
                    iconName: "remove_location"
                    checkable: true
                    exclusiveGroup: mapToolsGroup
                }
            }
        }
        Slider {
            value: 0.5
        }
    }
    function getActiveTool()
    {
        return mapToolsGroup.current.iconName;
    }
    function getActiveToolIcon()
    {
        return mapToolsGroup.current.iconSource;
    }
}
