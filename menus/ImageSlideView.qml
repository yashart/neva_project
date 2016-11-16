import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import Qt.labs.folderlistmodel 2.1


ScrollView {
    verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    RowLayout {
        Repeater {
            model: pictureWindow.getXmlModel()
            delegate: Rectangle {
                width: 166
                height: imageSlideView.height - 10
                MouseArea{
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        source: xmlModel.folder_path + src
                        autoTransform: true
                        smooth: false
                    }
                    onClicked: {
                        pictureWindow.changeImageSource(xmlModel.folder_path + src, src);
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
