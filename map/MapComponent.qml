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
            var coordinates = 0;
            var icon_src = "";
            var type = "";
            if((toolBarMap.getActiveTool() == "add_launcher" || toolBarMap.getActiveTool() == "add_tank")
                    && (mouse.button == Qt.LeftButton))
            {
                icon_src = toolBarMap.getActiveToolIcon();
                type = toolBarMap.getActiveTool();
                coordinates = map.toCoordinate(Qt.point(mouse.x,mouse.y));
                locationsCoordinates.append({"lat": coordinates.latitude,
                                             "lon": coordinates.longitude,
                                             "type": type.toString(),
                                             "icon_path": icon_src.toString()});
                console.log(toolBarMap.getActiveToolIcon());
            }
            if(toolBarMap.getActiveTool() == "remove_location" && mouse.button == Qt.LeftButton)
            {
                coordinates = map.toCoordinate(Qt.point(mouse.x,mouse.y));
                var pointItem;
                for(var i = 0; i < locationsCoordinates.count; i++)
                {
                    pointItem = locationsCoordinates.get(i);
                    if(((pointItem.lat - coordinates.latitude)*(pointItem.lat - coordinates.latitude) < 3e-7)&&
                            ((pointItem.lon - coordinates.longitude)*(pointItem.lon - coordinates.longitude) < 3e-7)){
                        locationsCoordinates.remove(i);
                    }
                }
                console.log("!");
            }
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

    ListModel {
        id: locationsCoordinates
    }
    MapItemView {
        id: locationListView

        model: locationsCoordinates
        delegate: MapQuickItem {
            coordinate {
                latitude: lat
                longitude: lon
            }
            sourceItem: Image {
                source: icon_path
            }
        }
    }

    MapPolyline {
        id: track1
        line.width: 3
        line.color: 'blue'
    }
    function addTrack(path)
    {
        track1.path = path;
    }

    MapItemView{
        id: secondView
        model: pointsModel
        delegate: MapQuickItem {
            anchorPoint.x: image.width/4
            anchorPoint.y: image.height

            coordinate: QtPositioning.coordinate(lat, lon)

            sourceItem: Image {
                id: image
                source: "qrc:/img/photo.png"
            }

            property var image_src: -1

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    pictureWindow.data
                    pictureWindow.visible = true;
                    image_src = comment;
                    var true_src = comment;
                    console.log(comment)
                    pictureWindow.changeImageSource("file:///D:/DSC00854.JPG", "DSC00854.JPG");
                    console.log(pointsModel.rowCount())
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
        var icon_src = popupMapMenu.getActiveToolIcon();
        var type = popupMapMenu.getActiveTool();
        var coordinates = map.toCoordinate(Qt.point(map.popupX,map.popupY));
        locationsCoordinates.append({"lat": coordinates.latitude,
                                     "lon": coordinates.longitude,
                                     "type": type.toString(),
                                     "icon_path": icon_src.toString()});
        popupMapMenu.visible = false;
    }
}
