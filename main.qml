import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Dialogs 1.3
import QtMultimedia 5.13

ApplicationWindow {
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

    Audio{
        id: playRecording
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        selectMultiple: false
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrl)
            playRecording.source = fileDialog.fileUrl
            var ok = loader.prepare(fileDialog.fileUrl)
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
