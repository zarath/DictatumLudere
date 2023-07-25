import QtQuick
import QtQuick.Controls
import QtCore
Page {
    Settings{
        property alias speed: speedSlider.value
        property alias volume: volumeSlider.value
    }

    id: page
    width: 433
    height: 100
    property alias volumeSlider: volumeSlider
    property alias labelDuration: labelDuration
    property alias labelPosition: labelPosition
    property alias progressBar: progressBar
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

    Button {
        id: button_rev
        x: 10
        y: 11
        flat: false
        width: 80
        text: qsTr("REV")
    }

    Button {
        id: button_play
        x: 100
        y: 11
        width: 120
        text: qsTr("PLAY")
    }

    Button {
        id: button_fwd
        x: 230
        y: 11
        width: 80
        text: qsTr("FWD")
    }

    Slider {
        id: speedSlider
        x: 315
        y: 14
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
            y: -13
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
        y: 71
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
        y: 48
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
