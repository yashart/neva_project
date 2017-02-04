import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import "../pages"

Window {
    visible: false
    title:qsTr("Все треки")
    minimumWidth: 300
    minimumHeight: 400

    ColumnLayout {
        spacing: 2
        ToolBar {
            id: tracksWindowToolBar
            z: 1
            style: ToolBarStyle {
                background: Rectangle {
                    implicitHeight: 25
                    implicitWidth: pictureWindow.width
                    border.color: "#999"
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: "#fff" }
                        GradientStop { position: 1 ; color: "#eee" }
                    }
                }
            }
            RowLayout {
                GroupBox {
                    RowLayout {
                        ExclusiveGroup { id: tracksWindowToolsGroup }
                        anchors.fill: parent
                        ToolButton {
                            iconSource: "qrc:/img/track_icon/plus24.png"
                            iconName: "add"
                            exclusiveGroup: tracksWindowToolsGroup
                            onClicked: getParseFileDialog.open()
                        }
                        ToolButton {
                            iconSource: "qrc:/img/track_icon/del24.png"
                            iconName: "add_tank"
                            exclusiveGroup: tracksWindowToolsGroup
                        }
                        ToolButton {
                            iconSource: "qrc:/img/track_icon/edit24.png"
                            iconName: "add_tank"
                            exclusiveGroup: tracksWindowToolsGroup
                        }
                    }
                }
            }
        }
        Rectangle {
            width: parent.width;
            height: trackWindow.height - tracksWindowToolBar.height
            anchors.top: tracksWindowToolBar.bottom
            Component {
                id: contactDelegate
                CheckBox{
                property int trackId: id
                text: qsTr(name)
                checked: (is_check === "true") ? true : false
                onClicked:{
                    if (checked == true){
                        pointsModel.addId(id);
                        tracksModel.setChecked(id);
                        linesModel.addId(id);
                    }
                    if (checked == false){
                        pointsModel.delId(id);
                        tracksModel.setUnchecked(id);
                        linesModel.delId(id);
                    }
                    pointsModel.updateModel();
                    tracksModel.updateModel();
                }
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.RightButton
                    onClicked: {
                        var lat = dataBase.getAvgLat(trackId)
                        var lon = dataBase.getAvgLon(trackId)
                        if (lat !== 0 && lon !== 0 && parent.checked == true)
                        {
                            pageMap.changeMapCenter(lat, lon)
                        }
                    }
                }
            }
        }


            ScrollView {
                width: parent.width
                height: parent.height
                ListView {
                    anchors.margins: 10
                    spacing: 10
                    id: tracksList
                    model: tracksModel
                    delegate: contactDelegate
                }
            }

            ListModel {
                    id: dataModel

                    ListElement {
                        color: "orange"
                        txt: "one"
                    }
                    ListElement {
                        color: "skyblue"
                        txt: "two"
                    }
                }
        }
    }

    FileDialog {
        id: getParseFileDialog
        title: "Выберите csv файл"
        folder: shortcuts.home
        onAccepted: {
            console.log(fileUrl);
            dataBase.parseCSV(fileUrl);
        }
        onRejected: {
            console.log("Canceled");
        }
    }
}

