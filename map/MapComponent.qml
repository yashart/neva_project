import QtQuick 2.0
import QtLocation 5.7
import QtPositioning 5.2
import QtQuick.Controls 1.4


Map {
    plugin: mapPlugin
    id: map

    zoomLevel: 15
    width: parent.width
    height: parent.height

    center{
        latitude: 55.929236
        longitude: 37.522469
    }

    property var popupX: 0
    property var popupY: 0

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            popupMapMenu.visible = false;
            if(mouse.button == Qt.RightButton)
            {
                map.popupX = mouse.x;
                map.popupY = mouse.y;
                popupMapMenu.x = mouse.x + rootItem.x;
                popupMapMenu.y = mouse.y + rootItem.y;
                popupMapMenu.visible = true;
                console.log("Right button: " + map.popupX + " " + map.popupY);
            }
        }
    }


    MapPolygon{
        property real lat: 55.92862
        property real lon: 37.520932
        property real ofLat: 0.00034
        property real ofLon: 0.0011

        color: 'green'
        path: [
            { latitude: lat+ofLat, longitude: lon + ofLon},
            { latitude: lat+ofLat, longitude: lon - ofLon},
            { latitude: lat - ofLat, longitude: lon - ofLon},
            { latitude: lat - ofLat, longitude: lon + ofLon}
        ]
        opacity: 0.5
}

    MapItemView {
        id: locationListView

        model: locationsModel
        delegate: MapQuickItem {
            coordinate {
                latitude: lat
                longitude: lon
            }
            sourceItem: Image {
                source: "qrc:///img/" + type + ".png"
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    if( mouse.button == Qt.LeftButton){
                        dataBase.prepareDeletePoint(id);
                    }
                }
            }
        }
    }

   /*MapItemView {
        id: tracksLine

        model: tracksModel
        delegate: MapQuickItem {
            coordinate {
                latitude: points[0].latitude
                longitude: points[0].longtitude
            }
            sourceItem: Image {
                source: "qrc:///img/pikachu.png"
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    if( mouse.button == Qt.LeftButton){
                    }
                }
            }
        }
    }*/

    MapItemView{
        id: tracksLines
        model: tracksModel
        delegate:
            MapPolyline {
            line.width: 3
            line.color: 'red'
            path: [
                { latitude: points[0].latitude, longitude: points[0].longtitude},
                { latitude: points[1].latitude, longitude: points[1].longtitude}
            ]
        }
    }

    function addTrack(path)
    {
        track1.path = path;
    }

    MapItemView{
        id: secondView
        model: pointsModel
        delegate: MapQuickItem {
            coordinate: QtPositioning.coordinate(lat, lon)

            sourceItem: Image {
                source: "/img/photo.png"
            }

            property var image_src: -1

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    imagesModel.updateModel()
                    pictureWindow.data;
                    pictureWindow.visible = true;
                    image_src = url;
                    pictureWindow.changeImageSource("file:///" + dir + url, url);
                    console.log("file:///" + dir + url);
                }
            }
        }
    }


    function changeMapCenter(lat, lon)
    {
        map.center.latitude = lat;
        map.center.longitude = lon;
    }
    function addUserPoint(pointData){
        locationsCoordinates.append(pointData);
    }
    function toCoordinates(point){
        return map.toCoordinate(point);
    }

    function addPopupPoint(){
        var icon_src = popupMapMenu.getActiveToolIcon(); //  qrc:///img/pikachu.png
        var type = popupMapMenu.getActiveTool(); // pikachu
        var coordinates = map.toCoordinate(Qt.point(map.popupX,map.popupY));
        console.log(coordinates.latitude + " " + coordinates.longitude);
        dataBase.createLocalPoint(coordinates.latitude, coordinates.longitude, type);
        dataBase.deleteLocalPoint(0);
        popupMapMenu.visible = false;
    }
}
