import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "../menus"


Window {
    visible: false
    title:qsTr("Picture Viewer")
    minimumWidth: 500
    minimumHeight: 460 + 220
    property var currentFrame: undefined
    property var surfaceViewportRatio: 3.0
    ColumnLayout {
        spacing: 2
        ToolBar {
            id: pictureWindowToolBar
            z: 1
            style: ToolBarStyle {
                background: Rectangle {
                    implicitHeight: 25
                    implicitWidth: pictureWindow.width
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
                        ExclusiveGroup { id: windowToolsGroup }
                        anchors.fill: parent
                        ToolButton {
                            iconSource: "/img/mouse_icon.png"
                            iconName: "mouse"
                            checkable: true
                            checked: true
                            exclusiveGroup: windowToolsGroup
                        }
                        ToolButton {
                            iconSource: "/img/tank.png"
                            iconName: "add_tank"
                            checkable: true
                            exclusiveGroup: windowToolsGroup
                        }
                        ToolButton {
                            iconSource: "/img/launcher.png"
                            iconName: "add_launcher"
                            checkable: true
                            exclusiveGroup: windowToolsGroup
                        }
                        ToolButton {
                            iconSource: "/img/remove_location_icon.png"
                            iconName: "remove_location"
                            checkable: true
                            exclusiveGroup: windowToolsGroup
                        }
                    }
                }
            }
        }
        Rectangle {
            id: photoFrame
            width: pictureWindow.width
            height: pictureWindow.height - imageSlideView.height - 50
            Layout.preferredWidth: pictureWindow.width
            Layout.preferredHeight: pictureWindow.height - imageSlideView.height - 50

            Flickable {
                id: flick
                anchors.fill: parent
                contentWidth: width * surfaceViewportRatio
                contentHeight: height * surfaceViewportRatio

                scale: defaultSize / Math.max(image.sourceSize.width, image.sourceSize.height)
                //Behavior on scale { NumberAnimation { duration: 0 } }
                //Behavior on x { NumberAnimation { duration: 200 } }
                //Behavior on y { NumberAnimation { duration: 200 } }
                PinchArea {
                    anchors.fill: parent
                    pinch.target: image
                    pinch.minimumRotation: -360
                    pinch.maximumRotation: 360
                    pinch.minimumScale: 0.1
                    pinch.maximumScale: 10
                    pinch.dragAxis: Pinch.XAndYAxis
                    onPinchStarted: setFrameColor();
                    property real zRestore: 0
                    onSmartZoom: {
                        if (pinch.scale > 0) {
                            image.rotation = 0;
                            image.scale = Math.min(root.width, root.height) / Math.max(image.sourceSize.width, image.sourceSize.height) * 0.85
                            image.x = flick.contentX + (flick.width - image.width) / 2
                            image.y = flick.contentY + (flick.height - image.height) / 2
                            zRestore = image.z
                            image.z = ++root.highestZ;
                        } else {
                            image.rotation = pinch.previousAngle
                            image.scale = pinch.previousScale
                            image.x = pinch.previousCenter.x - image.width / 2
                            image.y = pinch.previousCenter.y - image.height / 2
                            image.z = zRestore
                            --root.highestZ
                        }
                    }

                    MouseArea {
                        id: dragArea
                        hoverEnabled: true
                        anchors.fill: parent
                        drag.target: image
                        scrollGestureEnabled: false  // 2-finger-flick gesture should pass through to the Flickable
                        onPressed: {
                            image.z = ++root.highestZ;
                            parent.setFrameColor();
                        }
                        //onEntered: parent.setFrameColor();
                        onWheel: {
                            if (wheel.modifiers & Qt.ControlModifier) {
                                image.rotation += wheel.angleDelta.y / 120 * 5;
                                if (Math.abs(image.rotation) < 4)
                                    image.rotation = 0;
                            } else {
                                image.rotation += wheel.angleDelta.x / 120;
                                if (Math.abs(image.rotation) < 0.6)
                                    image.rotation = 0;
                                var scaleBefore = image.scale;
                                image.scale += image.scale * wheel.angleDelta.y / 120 / 10;
                            }
                        }
                    }
                    function setFrameColor() {
                        if (pictureWindow.currentFrame)
                            pictureWindow.currentFrame.border.color = "black";
                        pictureWindow.currentFrame = image;
                        pictureWindow.currentFrame.border.color = "red";
                    }
                }


                Image {
                    id: image
                    anchors.centerIn: photoFrame
                    width: pictureWindow.width
                    height: pictureWindow.height - imageSlideView.height - 50
                    source: "../img/photo_example.jpg"
                    autoTransform: true
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            var coordinates = 0;
                            var icon_src = "";
                            var type = "";
                            if(windowToolsGroup.current.iconName == "add_tank" ||
                                    windowToolsGroup.current.iconName == "add_launcher")
                            {
                                var k = 0.005;
                                var offsetLat = ((mouseY / (height)) * k - (0.5 *k)) * (-1);
                                var offsetLon = (mouseX / (width)) * k - (0.5 *k);
                                icon_src = windowToolsGroup.current.iconSource;
                                type = windowToolsGroup.current.iconName;
                                coordinates = pageMap.toCoordinates(Qt.point(mouseX/scale, mouseY/scale));
                                console.log(icon_src + " " + type + " " + coordinates.latitude);
                                pageMap.addUserPoint({"lat": coordinates.latitude,
                                                             "lon": coordinates.longitude,
                                                             "type": type.toString(),
                                                             "icon_path": icon_src.toString()});
                            }
                        }
                    }
                }
            }
            Image {
                id: currentGrig
                anchors.fill: parent
                source: "/img/grid.png"
                scale: image.scale * 2
            }
        }

        ImageSlideView {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom
            id: imageSlideView
        }
    }
    function createTrackPath(source)
    {
        imageSlideView.addPicture(source);
    }
    function changeImageSource(source, imageName)
    {
        image.source = source;
        for(var i = 0; i < xmlModel.count; i++)
        {
            if(xmlModel.get(i).src == imageName)
            {
                console.log("123");
                pageMap.changeMapCenter(xmlModel.get(i).lat, xmlModel.get(i).lon);
            }
        }
    }
    function getFolderSource()
    {
        return imageSlideView.getFolderSource();
    }
    function getXmlModel()
    {
        return xmlModel;
    }
}
