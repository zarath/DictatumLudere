import QtQuick 2.13
import QtQuick.Controls 2.13

Page {
    id: page
    width: 433
    height: 100
    property alias volumeSlider: volumeSlider
    property alias labelDuration: labelDuration
    property alias labelPosition: labelPosition
    property alias progressBar: progressBar
    property alias labelTitle: labelTitle
    property alias buttonSpeedReset: buttonSpeedReset
    property alias speedSlider: speedSlider
    property alias button_fwd: button_fwd
    property alias button_rev: button_rev
    property alias button_play: button_play
    x: 0

    title: qsTr("Player")

    Row {
        id: row
        width: 433
        height: 100
    }

    Label {
        id: labelTitle
        x: 0
        width: 309
        height: 17
        text: qsTr("Title")
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        transformOrigin: Item.Center
        anchors.verticalCenterOffset: -35
    }


    Button {
        id: button_rev
        x: 57
        y: 22
        width: 80
        text: "REV"
        flat: false
    }

    Button {
        id: button_play
        x: 143
        y: 22
        width: 80
        text: qsTr("PLAY")
    }

    Button {
        id: button_fwd
        x: 229
        y: 22
        width: 80
        text: qsTr("FWD")
    }


    Slider {
        id: speedSlider
        x: 315
        y: 22
        width: 91
        height: 25
        to: 2
        from: 0.5
        value: 1

        ToolTip {
            parent: speedSlider.handle
            visible: speedSlider.pressed
            text: speedSlider.value.toFixed(2)
        }

        Label {
            id: labelSpeed
            x: 8
            y: -15
            text: qsTr("Speed:")
        }

        RoundButton {
            id: buttonSpeedReset
            x: 94
            y: 1
            width: 23
            height: 23
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Reset")
        }


    }

    Slider {
        id: progressBar
        x: 57
        y: 76
        width: 252
        height: 24
        value: 0.0
        from: 0.0
        to: 1.0

        Label {
            id: labelPosition
            x: -56
            y: 4
            text: qsTr("00:00.0")
        }

        Label {
            id: labelDuration
            x: 262
            y: 4
            text: qsTr("00:00.0")
        }
    }

    Slider {
        id: volumeSlider
        x: 315
        y: 53
        width: 118
        height: 25
        ToolTip {
            text: volumeSlider.value.toFixed(2)
            visible: volumeSlider.pressed
            parent: volumeSlider.handle
        }

        Label {
            id: labelVolume
            x: 8
            y: -12
            text: qsTr("Volume:")
        }
        value: 1
        from: 0
        to: 1
    }


}
