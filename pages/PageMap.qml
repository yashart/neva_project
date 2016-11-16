import QtQuick 2.0
import "../map"
import "../menus"


Item {
    MapPlugin {
        id: mapPlugin
    }

    MapComponent {
        id: mapComponent
    }

    ToolBarMap {
        id: toolBarMap
    }

    function addTrack(path)
    {
        mapComponent.addTrack(path);
    }
    function changeMapCenter(lat, lon)
    {
        mapComponent.changeMapCenter(lat, lon);
    }
    function addUserPoint(pointData){
        mapComponent.addUserPoint(pointData);
    }
    function toCoordinates(point){
        return mapComponent.toCoordinates(point);
    }

}
