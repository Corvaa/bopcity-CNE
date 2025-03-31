function update() {
    if (FlxG.keys.justPressed.Q) {
        PlayState.loadSong("egghead", "normal");
        FlxG.switchState(new PlayState());
    }
}