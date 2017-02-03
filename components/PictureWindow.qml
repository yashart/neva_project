import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtPositioning 5.2

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
            height: pictureWindow.height
            Layout.preferredWidth: pictureWindow.width
            Layout.preferredHeight: pictureWindow.height - 50

            Image {
                id: image
                asynchronous: false
                //width: pictureWindow.width
                height: pictureWindow.height - 50
                source: "file:///home/yashart/Downloads/Furmanovka/DSC01751.JPG"
                fillMode: Image.PreserveAspectFit
                Drag.active: dragArea.drag.active
                z: 1
                cache: false
                Component.onCompleted: {
                    //console.log("Completed!");
                }

                property var lat: 0
                property var lon: 0
                property var azimuth: 0
                ListView {
                    anchors.fill: image
                    id: pointsOnPicture

                    model: pointsPhotoModel
                    delegate: Image {
                        x: (((lon-image.lon)/dragArea.offsetLon*Math.cos(image.azimuth*3.1415/180)-
                           (image.lat-lat)/dragArea.offsetLat*Math.sin(image.azimuth*3.1415/180))/2 + 0.5)*image.paintedWidth
                        y: (((image.lat-lat)/dragArea.offsetLat*Math.cos(image.azimuth*3.1415/180)-
                           (image.lon-lon)/dragArea.offsetLon*Math.sin(image.azimuth*3.1415/180))/2 + 0.5)*image.paintedHeight
                        z: 2
                        source: "qrc:///img/popupIconsSet/" + type + ".png"
                        cache: false
                        asynchronous: false
                        Component.onCompleted: {
                            /*console.log("point completed");
                            console.log(image.status);*/
                            var src = image.source;
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                /*console.log("11231!!!");
                                console.log(lat + "   " + lon);
                                console.log(image.lat + "  " + image.lon);
                                console.log(parent.x, parent.y);*/
                            }
                        }
                        Timer {
                        interval: 500; running: true; repeat: true
                            onTriggered: {
                                parent.x = -1;
                                parent.y = -1;
                                parent.x = (((lon-image.lon)/dragArea.offsetLon*Math.cos(image.azimuth*3.1415/180)-
                                             (image.lat-lat)/dragArea.offsetLat*Math.sin(image.azimuth*3.1415/180))/2 + 0.5)*image.paintedWidth;
                                parent.y = (((image.lat-lat)/dragArea.offsetLat*Math.cos(image.azimuth*3.1415/180)-
                                             (image.lon-lon)/dragArea.offsetLon*Math.sin(image.azimuth*3.1415/180))/2 + 0.5)*image.paintedHeight;
                            }
                        }
                    }
                }
                MouseArea {
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    anchors.margins: 0
                    drag.target: image
                    property var offsetLon: 0.00150 // эксперементальным путем
                    property var offsetLat: 0.0016 // эксперементальным путем
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
                    onPositionChanged: {
                        //console.log(dragArea.mouseX, dragArea.mouseY);
                    }
                    onClicked: {
                        //console.log('Click Image  ' + image.paintedHeight + ' ' + image.paintedWidth);
                        popupMapMenu.visible = false;
                        popupMapMenu.x = dragArea.mouseX + pichWidow.x;
                        popupMapMenu.y = dragArea.mouseY + pichWidow.y + 70;
                        /*console.log(image.lon + ((2*dragArea.mouseX/image.paintedWidth-1)*Math.cos(image.azimuth*3.1415/180)+
                                     (2*dragArea.mouseY/image.paintedHeight-1)*Math.sin(image.azimuth*3.1415/180))*
                        offsetLon);*/

                        popupMapMenu.setCoordinates(
                                    QtPositioning.coordinate(
                                        image.lat + ((2*dragArea.mouseX/image.paintedWidth-1)*Math.sin(image.azimuth*3.1415/180)-
                                                     (2*dragArea.mouseY/image.paintedHeight-1)*Math.cos(image.azimuth*3.1415/180))*
                                        offsetLat,
                                        image.lon + ((2*dragArea.mouseX/image.paintedWidth-1)*Math.cos(image.azimuth*3.1415/180)+
                                                     (2*dragArea.mouseY/image.paintedHeight-1)*Math.sin(image.azimuth*3.1415/180))*
                                        offsetLon
                                        ));
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

        /*ImageSlideView {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom
            id: imageSlideView
        }*/
    }
    function createTrackPath(source)
    {
        imageSlideView.addPicture(source);
    }
    function changeImageSource(source, imageName, azimuth, lat, lon)
    {
        image.source = "";
        image.source = source;
        image.azimuth = 90 + azimuth;
        image.lat = lat;
        image.lon = lon;
        image.rotation = azimuth;
        image.x = photoFrame.x;
        image.y = photoFrame.y;
        image.scale = 1;
        pichWidow.title = source;
    }
    function getFolderSource()
    {
        return imageSlideView.getFolderSource();
    }
    function getXmlModel()
    {
        return xmlModel;
    }
    function refreshImage()
    {
        var imgSrc = image.source;
        //image.source = "";
        //image.source = imgSrc;
    }
}
