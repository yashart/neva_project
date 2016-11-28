import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0
import QtLocation 5.3
import "menus"
import "map"
import "components"
import "pages"


ApplicationWindow {
    title: qsTr("Drone Neva Project v0.0.2")

    menuBar: mainMenu
    toolBar: toolBarMap
    visible: true
    width: 640
    height: 480
    id: rootItem

    FocusScope{
        anchors.fill: parent
        focus: true
        Keys.onDeletePressed: {
            console.log("Delete");
            dataBase.deleteLocalPoint();
            event.accepted = true;
        }

        MainMenu {
            id: mainMenu
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
        TrackWindow{
            id: trackWindow
        }
    }
}
