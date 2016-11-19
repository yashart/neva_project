import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Window {
    visible: false
    title:qsTr("Все треки")
    minimumWidth: 300
    minimumHeight: 400

    Button{
        id: add
        height: 40
        text:"Добавить"
        width: parent.width / 3
        onClicked: {
            dataBase.parseUD();
        }
    }
    Button{
        id: del
        width: parent.width / 3
        height: add.height
        anchors.left: add.right
        text:"Удалить"
    }
    Button{
        id: chg
        width: parent.width / 3
        height: add.height
        anchors.left: del.right
        text:"Проверить"
    }


    Rectangle {
        width: parent.width;
        height: parent.height - add.height
        anchors.top: add.bottom

        Component {
            id: contactDelegate

            CheckBox{
                property int trackId: idd
                text: qsTr(name)
                onCheckedStateChanged:{
                    if (checked == true){
                        pointsModel.addId(idd);
                    }
                    if (checked == false){
                        pointsModel.delId(idd);
                    }
                    pointsModel.updateModel()
                }
            }

        }

        ListModel {
            id: trks

            ListElement {
                idd: 1
                name: "Тихорец1"
            }
            ListElement {
                idd: 2
                name: "Тихорецк2"
            }
            ListElement {
                idd: 3
                name: "Тихорецк3"
            }
        }

        ScrollView {
            width: parent.width
            height: parent.height
            ListView {
                anchors.margins: 10
                spacing: 10
                id: tracksList
                model: trks
                delegate: contactDelegate
            }
        }


    }
}
