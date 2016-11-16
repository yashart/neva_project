import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import "../map"
import "../pages"

XmlListModel {
    query: "/gpx/trk/trkseg/trkpt"

    property var folder_path: "/"

    XmlRole { name: "lat"; query: "@lat/string()"}
    XmlRole { name: "lon"; query: "@lon/string()"}
    XmlRole { name: "src"; query: "image/string()"}

    onStatusChanged: {
        if (status == XmlListModel.Ready) {
            var folder_path_local = "file:/"
            var parts = source.toString().split("/");
            for (var i = 1; i < parts.length - 1; i++)
            {
                folder_path_local += parts[i] + "/";
            }
            folder_path = folder_path_local;
            console.log(folder_path_local);
            pictureWindow.createTrackPath(folder_path_local);

            var points = []
            for(var i=0; i < count; i++) {
                var item = get(i);
                console.log(item.lat + "  " + item.lon + " " + item.src);
                points.push({latitude: item.lat, longitude: item.lon});
            }
            pageMap.addTrack(points);
        }
    }
}
