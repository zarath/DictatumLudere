import QtQuick
import QtQuick.Controls
import QtMultimedia
import Qt.labs.platform
import QtCore

ApplicationWindow {
    Settings{
        property alias folder: fileDialog.folder
        property alias last_file: playRecording.source
    }

    id: window
    visible: true
    width: 433
    height: 150
    title: qsTr("DictatumLudere")

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate{
                text: qsTr("Open File")
                width: parent.width
                onClicked: {
                    fileDialog.visible = true
                }
            }

            ItemDelegate{
                text: qsTr("Quit")
                width: parent.width
                onClicked: {
                    Qt.quit()
                }
            }

        }
    }

    MediaPlayer{
        id: playRecording
        source: ""
        audioOutput: AudioOutput {
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        fileMode: FileDialog.OpenFile
        onAccepted: {
            console.log("You chose: " + fileDialog.file)
            playRecording.source = fileDialog.file
            var ok = loader.prepare(fileDialog.file)
            visible = false
            drawer.close()
        }
        onRejected: {
            console.log("Canceled")
            visible = false
            drawer.close()
        }
        Component.onCompleted: visible = false
    }

    StackView {
        id: stackView
        initialItem: "Home.qml"
        anchors.fill: parent
    }

}
