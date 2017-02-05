import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import Qt.labs.folderlistmodel 2.1
import "../pages"


ScrollView {
    verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOn
    RowLayout {
        LayoutMirroring.enabled: true
        LayoutMirroring.childrenInherit: true
        Repeater {
            model: imagesModel
            delegate: Rectangle {
                width: 166
                height: imageSlideView.height - 10
                MouseArea{
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        source: "image://colors/" + dir + url
                        autoTransform: true
                        smooth: true
                        asynchronous: true
                    }
                    onClicked: {
                        pageMap.changeMapCenter(lat, lon);
                        pageMap.changeViewPortCenter(lat, lon);
                        pictureWindow.changeImageSource("file:///" + dir + url, url, 0, lat, lon);
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
