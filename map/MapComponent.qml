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

            if (toolBarMap.getActiveTool() == "near_photo"
                                    && mouse.button == Qt.LeftButton){
                console.log("Изображение по близости");

            }

            if(mouse.button == Qt.RightButton)
            {
                map.popupX = mouse.x;
                map.popupY = mouse.y;
                popupMapMenu.x = mouse.x + rootItem.x;
                popupMapMenu.y = mouse.y + rootItem.y;
                popupMapMenu.setCoordinates(map.toCoordinate(
                                                Qt.point(mouseX, mouseY)));
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
                source: "qrc:///img/popupIconsSet/" + type + ".png"
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
        id: cutListView

        model: pointsPhotoModel
        delegate: MapQuickItem {
            coordinate {
                latitude: lat
                longitude: lon
            }
            anchorPoint.x: markerLkPoint.width / 2;
            anchorPoint.y: markerLkPoint.height / 2;
            sourceItem: Image {
                id: markerLkPoint
                source: "qrc:///img/popupIconsSet/" + type + ".png"
            }
        }
    }

   /*MapItemView {
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
    }*/

    MapQuickItem {
                coordinate {
                    latitude: 55.930900
                    longitude: 37.521555
                }
                sourceItem: Image {
                    source: "qrc:/img/ruler.png"
                }
                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        console.log(testline.path);
                    }
                }
            }

    /*MapItemView{
         id: rulerLines
         model: rulerModel
         delegate:
             MapPolyline {
             line.width: 2
             line.color: 'red'
             path: path
         }
     }*/

    MapItemView{
        id: tracksLines
        model: linesModel
        delegate:
            MapPolyline {
            line.width: 2
            line.color: 'blue'
            path: points
        }
    }
    MapPolyline{
       id: lookAt
       line.width: 4
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
            opacity:0
            sourceItem: Image {
                id: markerTrackPoint
                z: 8
                source: "/img/photo.png"
            }

            property var image_src: -1

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    parent.opacity = 1;

                }

                onExited: {
                    parent.opacity = 0;
                }
                onClicked: {
                    map.changeViewPortCenter(lat, lon, azimuth);
                    pictureWindow.visible = true;
                    image_src = url;
                    pictureWindow.changeImageSource("file:///" + dir + url, url, azimuth, lat, lon);
                    console.log("file:///" + dir + url);
                    console.log(azimuth);
                    pointsPhotoModel.setCenter(lat, lon);
                }
            }
        }
    }

    function changeMapCenter(lat, lon) // меняем положение карты
    {
        map.center.latitude = lat; // широту
        map.center.longitude = lon; // долготу
    }
    function changeViewPortCenter(lat, lon, azimuth) // изменение положения четырехугольника отражающего примерный захват изображения
    {
        console.log(azimuth);

        var offsetLat = 0.00150; // ширина "прямоугольника захвата" полученная эксперементальным путем
        var offsetLon = 0.0016; // ширина "прямоугольника захвата" полученная эксперементальным путем

        var offset = viewPort.path; // копируем в существующие кооординаты каждой точки четырехугольника
        // Задаем их смещение ОТНОСИТЕЛЬНО ЦЕНТРА САМОГО ЧЕТЫРЕХУГОЛЬНИКА
        offset[0].latitude = offsetLat;    //смещение первой точки
        offset[0].longitude = offsetLon;
        offset[1].latitude = offsetLat;    //Смещение второй точки
        offset[1].longitude = - offsetLon;
        offset[2].latitude = - offsetLat;  // и т.д.
        offset[2].longitude = - offsetLon;
        offset[3].latitude = - offsetLat;
        offset[3].longitude = offsetLon;

        var path = viewPort.path;      // А теперь поворачиваем каждую точку и сложением с центром получаем глобалные координаты (их настоящие широту и долготу)
        for (var i = 0; i <= 3; i++){
            var ofLat = offset[i].latitude;  // для удобства сохраняем
            var ofLon = offset[i].longitude; //  смещения в переменные
            path[i].latitude = lat + rotLat(ofLat, ofLon, azimuth); // первое слагаемое центр четырехугольника, второе - поворот точки
            path[i].longitude = lon + rotLon(ofLat, ofLon, azimuth);
        }
        viewPort.path = path; // сохраняем полученные глобальные координаты

        offset = lookAt.path; // координаты вектора мгновенной скорости самолета(на самом деле направление)
        offset[0].latitude = lat; // координаты самой точки
        offset[0].longitude = lon;
        offset[1].latitude = lat + rotLat(offsetLat, 0, azimuth);   // точка, после поворота на угол,
        offset[1].longitude = lon + rotLon(offsetLat, 0, azimuth);; //  показывающая направление
        lookAt.path = offset;
        console.log(offset);
    }

    function rotLat(lat, lon, angle) // матрица поворота для широты https://ru.wikipedia.org/wiki/Матрица_поворота#.D0.9C.D0.B0.D1.82.D1.80.D0.B8.D1.86.D0.B0_.D0.BF.D0.BE.D0.B2.D0.BE.D1.80.D0.BE.D1.82.D0.B0_.D0.B2_.D0.B4.D0.B2.D1.83.D0.BC.D0.B5.D1.80.D0.BD.D0.BE.D0.BC_.D0.BF.D1.80.D0.BE.D1.81.D1.82.D1.80.D0.B0.D0.BD.D1.81.D1.82.D0.B2.D0.B5
    {
        angle = toRad(angle);
        return lat * Math.cos(angle) - lon * Math.sin(angle);
    }
    function rotLon(lat, lon, angle) // матрица поворота для долготы
    {
        angle = toRad(angle);
        return lat * Math.sin(angle) + lon * Math.cos(angle);
    }

    function toDeg (angle) {           // функция преобразования радианов в градусы
      return angle * (180 / Math.PI);
    }

    function toRad (angle) {           // функция преобразования градусов в радианы
      return angle * (Math.PI / 180);
    }

    function addUserPoint(pointData){  // рудимент. В будущем исчезнет
        locationsCoordinates.append(pointData);
    }
    function toCoordinates(point){ // функция которая устанавливает положение карты. Создана для того, чтобы изменить положение можно было из другого файла
        return map.toCoordinate(point);
    }

    function addPopupPoint(lon, lat){ // функция открывает всплывающее окно с точками
        var icon_src = popupMapMenu.getActiveToolIcon(); //  переменная содержащая путь к изображению qrc:///img/pikachu.png
        var type = popupMapMenu.getActiveTool(); // уникальное название метки, которое хранится в панели
        dataBase.createLocalPoint(lat, lon, type); // записываем в консоль
        popupMapMenu.visible = false; // прячем окно с метками
        pictureWindow.refreshImage();
    }
}
