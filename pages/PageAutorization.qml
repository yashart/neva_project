import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: item1
    Label {
        text: qsTr("Авторизация")
        font.pointSize: 32
        font.family: "Verdana"
        anchors.verticalCenterOffset: -188
        anchors.horizontalCenterOffset: 1
        anchors.centerIn: parent
    }

    Rectangle {
        id: rectangle1
        x: 177
        y: 160
        width: 286
        height: 32
        color: "#ffffff"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 2;

        TextInput {
            id: login
            color: "#160800"
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 23
        }
    }

    Rectangle {
        id: rectangle2
        x: 177
        y: 243
        width: 286
        height: 30
        color: "#ffffff"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "red";
        border.width: 2;

        TextInput {
            id: pass
            text: qsTr("")
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pixelSize: 23
        }
    }

    Label {
        id: label1
        x: 195
        y: 127
        text: qsTr("Логин")
        anchors.horizontalCenterOffset: 0
        font.pointSize: 18
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Label {
        id: label2
        x: 301
        y: 211
        text: qsTr("Пароль")
        anchors.horizontalCenterOffset: 0
        font.pointSize: 18
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: button1
        x: 270
        y: 314
        text: qsTr("Войти")
        clip: false
        opacity: 1
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            if (login.text == "admin" && pass.text == "admin"){
                console.log("Верно");
                pageAutorize.visible = false;
                pageMap.visible = true;
                mainMenu.setMenuVisible();
            }
        }
    }

    Label {
        id: label3
        x: 296
        y: 94
        width: 286
        height: 13
        text: qsTr("Неверная пара логин/пароль")
        textFormat: Text.AutoText
        anchors.horizontalCenterOffset: 0
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#ff0000"
        visible: false
    }
}
