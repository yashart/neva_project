import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

import "../menus"
import "../map"


Window {    
    id:pichWidow
    visible: false
    title:qsTr("Picture Viewer")
    minimumWidth: 500
    minimumHeight: 460 + 220
    property var currentFrame: undefined
    property var surfaceViewportRatio: 3.0

    ColumnLayout {
        Rectangle {
            id: photoFrame
            width: pictureWindow.width
            height: pictureWindow.height - imageSlideView.height
            Layout.preferredWidth: pictureWindow.width
            Layout.preferredHeight: pictureWindow.height - 50

            Image {
                id: image
                width: pictureWindow.width
                height: pictureWindow.height - imageSlideView.height - 50
                source: "../img/photo_example.jpg"
                autoTransform: true
                fillMode: Image.PreserveAspectFit
                Drag.active: dragArea.drag.active
                MouseArea {
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: image
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
                    onClicked: {
                        popupMapMenu.visible = false;
                        popupMapMenu.x = dragArea.mouseX + pichWidow.x;
                        popupMapMenu.y = dragArea.mouseY + pichWidow.y + 70;
                        popupMapMenu.visible = true;
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
                console.log("123"); // Сомнительно место, которое, судя по всему не нужно
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
