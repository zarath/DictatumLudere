import QtQuick 2.13
import QtMultimedia 5.13

HomeForm{
    id: homePage

    property bool updatable: true
    property bool paddlePlay: false

    function url2title (url){
        var comps = url.toString().split('/')
        return comps[comps.length -1].split('.')[0]
    }

    function mseconds2time(msec){
        var secs = Math.floor(msec / 1000)
        msec = msec % 1000
        var mins = Math.floor(secs / 60)
        secs = secs % 60
        return (
          ""
          + (mins < 10 ? '0' : '') + mins + ":"
          + (secs < 10 ? '0' : '') + secs + "."
          + Math.floor(msec / 100)
        )
    }

    labelTitle.text: url2title(playRecording.source)
    labelDuration.text: mseconds2time(playRecording.duration)

    Timer {
        interval: 100; running: true; repeat: true
        onTriggered: {
            // footPaddle
            footPaddle.updateButtons();
            // play paddle
            if (footPaddle.getButton(1) === 1){
                playRecording.play()
                paddlePlay = true
            } else {
                if (paddlePlay) {
                    playRecording.pause()
                }
                paddlePlay = false
            }
            // rewind
            if (footPaddle.getButton(0) === 1){
                playRecording.seek(playRecording.position - (1500 * speedSlider.value))
            }
            // progress bar
            // if ((playRecording.playbackState === Audio.PlayingState) && updatable) {
            if (updatable) {
                progressBar.value = (playRecording.position + 1) / (playRecording.duration + 1)
            }
        }
    }

    // Progress bar
    //
    progressBar.onPressedChanged: {
        updatable = !progressBar.pressed
        playRecording.seek(playRecording.duration * progressBar.value)
    }
    progressBar.onValueChanged: {
        labelPosition.text = mseconds2time(playRecording.position)
        labelDuration.text = mseconds2time(playRecording.duration)
    }

    // Speed settings
    //
    buttonSpeedReset.onPressed: {
        speedSlider.value = 1.0
        playRecording.seek(playRecording.position + 1)
    }
    speedSlider.onValueChanged: {
        console.log("SPEED: " + speedSlider.value)
        playRecording.playbackRate = speedSlider.value
        playRecording.seek(playRecording.position + 1)
    }

    // Volume settings
    //
    volumeSlider.onValueChanged: {
        console.log("VOLUME: " + volumeSlider.value)
        playRecording.volume = volumeSlider.value
    }

    // Play / Pause / Fwd / Rev
    //
    button_rev.onClicked: {
        playRecording.seek(playRecording.position - (3000 * speedSlider.value))
    }
    button_play.onClicked: {
        console.log("SOURCE: " + playRecording.source)
        if (playRecording.playbackState !== Audio.PlayingState) {
            button_play.text = "PAUSE"
            playRecording.play()
        } else {
            button_play.text = "PLAY"
            playRecording.pause()
        }
    }
    button_fwd.onClicked: {
        playRecording.seek(playRecording.position + (3000 * speedSlider.value))
    }
}
