import QtQuick 2.0
import QtQuick.Dialogs 1.2


FileDialog {
    id: fileDialog
    title: "Please choose a gpx file"
    selectFolder : true
    folder: shortcuts.home
    onAccepted: {
        var dir = fileDialog.fileUrl;
        CMakeGPX.receiveFromQml(dir);
        xmlModel.source = fileDialog.fileUrl
        //createXmlModel(fileDialog.fileUrl);
    }
    onRejected: {
        console.log("Canceled")
    }
}
