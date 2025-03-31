var debug = false;

function update() {
    if (FlxG.keys.justPressed.I) {
        debug = !debug;
        player.cpu = debug;
    }

    if (FlxG.keys.justPressed.C && generatedMusic ) endSong();
    if (FlxG.keys.justPressed.H) camHUD.visible = !camHUD.visible;
    if (FlxG.keys.justPressed.Z) defaultCamZoom += 0.1;
    if (FlxG.keys.justPressed.X) defaultCamZoom -= 0.1;

    if (FlxG.keys.justPressed.K) {
        vocals.pitch += .1;
        inst.pitch += .1;
    }

    if (FlxG.keys.justPressed.J) {
        vocals.pitch -= .1;
        inst.pitch -= .1;
    }

    if (!debug || startingSong || !canPause || paused || health <= 0) return;

    IShow(FlxG.keys.pressed.PERIOD ? 20 : 1);
}

function IShow(s:float = 1) {
    FlxG.timeScale = inst.pitch = vocals.pitch = s;

    for (i in 0...strumLines.length) strumLines.members[i].vocals.pitch = FlxG.timeScale;
}

function onGamePause() IShow(1);
function onSongEnd() IShow(1);
function destroy() FlxG.timeScale = 1;