import flixel.text.FlxText.FlxTextAlign;

function new() {
    CoolUtil.playMenuSong();
}

function create() {

    var logo = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/playNow'));
		logo.screenCenter();

    var titleText = new FlxText(0,720 - 120,FlxG.width,'pres anything to start',72);
        titleText.alignment = FlxTextAlign.CENTER;
        titleText.font = Paths.font('papyrus.ttf');
        titleText.updateHitbox();
        add(titleText);
}

function update(elapsed:Float){
    if (FlxG.keys.justPressed.ENTER) {
        FlxG.switchState(new MainMenuState());
    }
}