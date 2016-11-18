import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0
import QtLocation 5.3
import "menus"
import "map"
import "components"
import "pages"


ApplicationWindow {
    visible: true
    width: 640
    height: 480
    id: rootItem
    title: qsTr("Drone Neva Project v0.0.2")

    menuBar: mainMenu
    toolBar: toolBarMap

    MainMenu {
        id: mainMenu
    }

    OpenGPX {
        id: openGPX
    }

    MakeGPX {
        id: makeGPX
    }

    PageMap{
        id: pageMap
        anchors.fill: parent
        visible: false
    }

    PageAutorization{
        id: pageAutorize
        anchors.fill: parent
        visible: true
    }

    PopupMapMenu {
        id: popupMapMenu
        visible: false
    }

    PictureWindow {
        id: pictureWindow
        visible: false
    }
    XmlModel {
        id: xmlModel
    }
}
