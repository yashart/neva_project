import QtQuick 2.0
import "../map"
import "../menus"


Item
{
    MapPlugin {
        id: mapPlugin
    }

    MapComponent {
        id: mapComponent
    }

    ToolBarMap {
        id: toolBarMap
    }

    function changeSource(source){
        //mapPlugin.
       // var plugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin {id: mapboxPlugin; name: "mapbox";    PluginParameter { name: "mapbox.access_token"; value: "pk.eyJ1IjoicHJvbWlzdHJpbyIsImEiOiJjaW1wNmIzaHQwMDJ5d2FtNGNhb28zZTRsIn0.nYE56atkirjFdB5oEkpYVA" }  PluginParameter { name: "mapbox.map_id"; value: "promistrio.1i2blkkj" }}', mapComponent);
        //mapComponent.plugin = plugin;
    }

    function clearMap()
    {
        mapComponent.clearData();
    }

    function addTrack(path)
    {
        mapComponent.addTrack(path);
    }
    function changeMapCenter(lat, lon)
    {
        mapComponent.changeMapCenter(lat, lon);
    }
    function changeViewPortCenter(lat, lon, azimuth)
    {
        mapComponent.changeViewPortCenter(lat, lon, azimuth);
    }

    function addUserPoint(pointData){
        mapComponent.addUserPoint(pointData);
    }
    function toCoordinates(point){
        return mapComponent.toCoordinates(point);
    }
    function addPopupPoint(lon, lat)
    {
        mapComponent.addPopupPoint(lon, lat);
    }

}
