import QtQuick 2.0
import QtQuick.Dialogs 1.2


FileDialog {
    id: fileDialog
    title: "Please choose a gpx file"
    folder: shortcuts.home
    onAccepted: {
        console.log("You chose: " + fileDialog.fileUrl)
        xmlModel.source = fileDialog.fileUrl
        //createXmlModel(fileDialog.fileUrl);
    }
    onRejected: {
        console.log("Canceled")
    }
}
