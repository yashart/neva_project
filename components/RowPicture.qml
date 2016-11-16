import QtQuick 2.0

Rectangle {
    width: imageSlideView.width
    height: imageSlideView.height - 10
    property var source_image: ""
    Image {
        anchors.fill: parent
        source: source_image
    }
}
