import funkin.menus.MainMenuState;
import funkin.game.HealthIcon;

import flixel.util.FlxGradient;
import flixel.text.FlxText;
import flixel.math.FlxMath;

var songs:Array<Array<String>> =[
"bop-city",
"egghead",
"mayor-of-ohio",
"crashout",
"backrooms",
"camera-man",
"irony",
"grimace",
"pibby-adin-ross",
"sigma",
"tiktok-voice",
"rio-de-janeiro",
"hollup",
"skibidi-toilet",
"chicken-nugget",
"tiktok-rizz-party",
"vexbolts",
"fat-city",
"bloogy",
"fanum-tax",
"piracy",
"finale",
"yo",
"werewolf"];
var curSelected:Int = 0;
var curDifficulty:Int = 1;
var text:Array<Alphabe> = [];
var sexo:Array<Alphabe> = [];
var portraits:FlxSpriteGroup;
var offsetY = 0;
var LerpVal;
var iconArray:Array<HealthIcon> = [];

function new() {
    CoolUtil.playMenuSong();
}

function create() {
    placeholder = new FlxSprite(0,0).loadGraphic(Paths.image("menus/freeplay/1"));
    placeholder.screenCenter();
    add(placeholder);

    for (i in 0...songs.length) {
    var t = new FlxText(800, 0, 0, StringTools.replace(songs[i], '-', ' '));
    t.setFormat(Paths.font('papyrus.ttf'), 50, FlxColor.WHITE, 'center');
    add(t);
    text.push(t);

    var p = new FlxText(150, 550, 0, StringTools.replace(songs[i], '-', ' '));
    p.setFormat(Paths.font('papyrus.ttf'), 30, FlxColor.WHITE);
    add(p);
    sexo.push(p);
    }

    portraits = new FlxSpriteGroup();
    add(portraits);

    for (i in songs) {
        var spr = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/' + i));

        spr.setGraphicSize(500,500);
        spr.updateHitbox();
        spr.x = 30;
        spr.y = 30;
        spr.alpha = 0;
        add(spr);
        portraits.add(spr);

        var icon:HealthIcon = new HealthIcon('menus/freeplay/icons/'+songs[curSelected]);
        icon.sprTracker = sexo;
        icon.y = 530;
        icon.x = 150;
        icon.scale.set(0.5,0.5);
        icon.updateHitbox();
        iconArray.push(icon);
        add(icon);
    }

    var frame = new FlxSprite().makeGraphic(1,1,FlxColor.BLACK);
    frame.scale.set(500 + 20,500 + 20);
    frame.updateHitbox();
    frame.x = portraits.members[0].x - 20/2;
    frame.y = portraits.members[0].y - 20/2;
    insert(members.indexOf(portraits),frame);

    changeSelect(0);
}

function update(elapsed) {
    FlxG.sound.music.volume = 0.5;

    lerpVal = Math.exp(-elapsed * 9.6);

    for (i in 0...text.length) {
    var sex = text[i];
    sex.y = 320 + (120 * i) - offsetY;
    var scaleTxt = (i == curSelected ? 1.2 : 1);
    var s = FlxMath.lerp(scaleTxt,sex.scale.x,lerpVal);
    sex.scale.set(s,s);
    }

    for (i in 0...sexo.length) {
        sexo[i].alpha = (i == curSelected ? 1 : 0);
    }

    offsetY = FlxMath.lerp(offsetY, curSelected * 120, lerpVal * 1);

    if (controls.BACK) {
        FlxG.switchState(new MainMenuState());
    }

    if (controls.UP_P || controls.DOWN_P) {
        FlxG.sound.play(Paths.sound('scrollmenu'));
        changeSelect(controls.UP_P ? -1 : 1);
    }

    if (controls.ACCEPT) {
        PlayState.loadSong(songs[curSelected], "normal");
        FlxG.switchState(new PlayState());
    }
}

function changeSelect(_:Int) {
    portraits.members[curSelected].alpha = 0;
    curSelected = FlxMath.wrap(curSelected + _,0,songs.length-1);
    portraits.members[curSelected].alpha = 1;
}