import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import Qt.labs.folderlistmodel 2.1
import "../pages"


ScrollView {
    verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    RowLayout {
        Repeater {
            model: imagesModel
            delegate: Rectangle {
                width: 166
                height: imageSlideView.height - 10
                MouseArea{
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        source: "qrc:/img/photo_example.jpg"
                        autoTransform: true
                        smooth: false
                    }
                    onClicked: {
                        pageMap.changeMapCenter(lat, lon);
                        pageMap.changeViewPortCenter(lat, lon);
                        console.log("file:///" + dir + url);
                        pictureWindow.changeImageSource("file:///" + dir + url, url);
                    }
                }
            }
        }
    }

    function addPicture(source)
    {
        //folderModel.folder = source;
        console.log(source);
    }
    function getFolderSource()
    {
        return xmlModel.folder_path;
    }
}
