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
        id: viewPort
        color: 'green'
        opacity: 0.5
        path: [
            { latitude: 0, longitude: 0},
            { latitude: 0, longitude: 0},
            { latitude: 0, longitude: 0},
            { latitude: 0, longitude: 0}
        ]
    }

    MapItemView {
        id: locationListView

        model: locationsModel
        delegate: MapQuickItem {
            coordinate {
                latitude: lat
                longitude: lon
            }
            anchorPoint.x: markerCustomPoint.width / 2;
            anchorPoint.y: markerCustomPoint.height / 2;
            sourceItem: Image {
                id: markerCustomPoint
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

   MapItemView {
        id: tracksLine

        model: tracksModel
        delegate: MapQuickItem {
            coordinate {
                latitude: 55.92862
                longitude: 37.520932
            }
            sourceItem: Image {
                source: "qrc:///img/pikachu.png"
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    console.log(points);
                }
            }
        }
    }

   MapItemView{
        id: tracksLines
        model: tracksModel
        delegate:
            MapPolyline {
            line.width: 1
            line.color: 'red'
            path: points
        }
    }

    MapPolyline{
        id: lookAt
        line.width: 3
        line.color: 'red'
        path:[
            { latitude: 0, longitude: 0},
            { latitude: 0, longitude: 0},
        ]

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
            anchorPoint.x: markerTrackPoint.width / 2;
            anchorPoint.y: markerTrackPoint.height / 2;
            sourceItem: Image {
                id: markerTrackPoint
                source: "/img/photo.png"
            }

            property var image_src: -1

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    map.changeViewPortCenter(lat, lon, azimuth);
                    imagesModel.updateModel();
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
    function changeViewPortCenter(lat, lon, azimuth)
    {
        console.log(azimuth);
        azimuth = azimuth;

        var offsetLat = 0.00034; // эксперементальным путем
        var offsetLon = 0.0011; // эксперементальным путем

        var offset = viewPort.path;
        offset[0].latitude = offsetLat;
        offset[0].longitude = offsetLon;
        offset[1].latitude = offsetLat;
        offset[1].longitude = - offsetLon;
        offset[2].latitude = - offsetLat;
        offset[2].longitude = - offsetLon;
        offset[3].latitude = - offsetLat;
        offset[3].longitude = offsetLon;

        var path = viewPort.path;
        for (var i = 0; i <= 3; i++){
            var ofLat = offset[i].latitude;
            var ofLon = offset[i].longitude;
            path[i].latitude = lat + rotLat(ofLat, ofLon, azimuth);
            path[i].longitude = lon + rotLon(ofLat, ofLon, azimuth);
        }
        viewPort.path = path;

        offset = lookAt.path;
        offset[0].latitude = lat;
        offset[0].longitude = lon;
        offset[1].latitude = lat + rotLat(offsetLat, 0, azimuth);
        offset[1].longitude = lon + rotLon(offsetLat, 0, azimuth);;
        lookAt.path = offset;
        console.log(offset);
    }

    function rotLat(lat, lon, angle)
    {
        angle = toRad(angle);
        return lat * Math.cos(angle) - lon * Math.sin(angle);
    }
    function rotLon(lat, lon, angle)
    {
        angle = toRad(angle);
        return lat * Math.sin(angle) + lon * Math.cos(angle);
    }

    function toDeg (angle) {
      return angle * (180 / Math.PI);
    }

    function toRad (angle) {
      return angle * (Math.PI / 180);
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
