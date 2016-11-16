import QtQuick 2.0
import QtLocation 5.7
import QtPositioning 5.2


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

    MouseArea {
        anchors.fill: parent
        onClicked: {
            var coordinates = 0;
            var icon_src = "";
            var type = "";
            if(toolBarMap.getActiveTool() == "add_launcher" || toolBarMap.getActiveTool() == "add_tank")
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
            if(toolBarMap.getActiveTool() == "remove_location")
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
        model: xmlModel
        delegate: MapCircle {
            center {
                latitude: lat
                longitude: lon
            }
            radius: 15.0
            color: 'green'
            border.width: 3
            property var image_src: -1
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    pictureWindow.visible = true;
                    image_src = src;
                    var true_src = src;
                    console.log(pictureWindow.getFolderSource());
                    pictureWindow.changeImageSource(pictureWindow.getFolderSource() + true_src, true_src);
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
}
