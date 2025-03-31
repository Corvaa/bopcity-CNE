import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.editors.StoryMenuState;

import flixel.input.mouse.FlxMouseEvent;

var tempBu = ['freeplay','playNow','credits','options'];
var walls:FlxSpriteGroup;
var buttons:FlxSpriteGroup;
var bg:FlxSprite;

function new() {
    CoolUtil.playMenuSong();
}

function create() {
    persistentUpdate = true;

    FlxG.worldBounds.set(FlxG.width,FlxG.height);

    FlxG.mouse.visible = true;
    bg = new FlxSprite().makeGraphic(1,1,FlxColor.ORANGE);
    bg.scale.set(FlxG.width,FlxG.height);
    bg.updateHitbox();
    add(bg);

    walls = new FlxSpriteGroup();
    add(walls);

    buttons = new FlxSpriteGroup();
    add(buttons);

    final thick = 30;
    var l = new FlxSprite(-thick).makeGraphic(thick,FlxG.height);
    l.immovable = true;
    walls.add(l);

    var r = new FlxSprite(FlxG.width).makeGraphic(thick,FlxG.height);
    r.immovable = true;
    walls.add(r);

    var u = new FlxSprite(0,-thick).makeGraphic(FlxG.width,thick);
    u.immovable = true;
    walls.add(u);

    var b = new FlxSprite(0,FlxG.height).makeGraphic(FlxG.width,thick);
    b.immovable = true;
    walls.add(b);

    generatebuttons();
}

function generatebuttons() {

    var len:Array<String> = [for (i in 0...5)'$i'];
    for (i in tempBu) {
        var random = FlxG.random.int(0,len.length-1);
        // len.remove(len[random]);
        len.insert(random,i);
    }
    trace(len);

    for (i in 0...len.length) {
        
        var graphic = !tempBu.contains(len[i]) ? 'die' : len[i];
        var spr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/' +graphic));

        spr.elasticity = 1;
        spr.velocity.y = FlxG.random.int(200,FlxG.random.bool(40) ? 400 : 700);
        spr.velocity.x = FlxG.random.int(200,FlxG.random.bool(40) ? 400 : 700);
        spr.setGraphicSize(200 * FlxG.random.float(0.7,1.4),(200 * FlxG.random.float(0.7,1.4)));
        spr.updateHitbox();

        spr.x = FlxG.random.int(0,Std.int(FlxG.width-spr.width));
        spr.y = FlxG.random.int(0,Std.int(FlxG.height-spr.height));

        buttons.add(spr); 

        FlxMouseEvent.add(spr,(o:FlxSprite)->{
            FlxMouseEvent.removeAll();
            var s:MenuSrp = o;
            switch (graphic) {
                case 'freeplay': FlxG.switchState(new FreeplayState());
                case 'credits': FlxG.switchState(new CreditsMain());
                case 'playNow':
                    PlayState.loadSong("bop-city", "normal");
                    FlxG.switchState(new PlayState());
                case 'options': FlxG.switchState(new OptionsMenu());
                case 'die':
                    final prevSize = [s.width,s.height];
                    s.loadGraphic(Paths.image('menu/die2'));
                    s.setGraphicSize(prevSize[0],prevSize[1]);
                    s.updateHitbox();
                    bg.visible = false;
                    for (i in buttons) {
                        i.velocity.set();
                        i.alpha = 0;
                    }
                    FlxG.sound.music.stop();
                    FlxTween.shake(s,0.025,Paths.sound('closegame').length/1000);

                    FlxTween.tween(s, {'scale.x': FlxG.width / s.frameWidth, 'scale.y': FlxG.height/ s.frameHeight},Paths.sound('closegame').length/1000);
                    s.alpha =1;
                    s.setColorTransform();
                    s.color = FlxColor.RED;
                    FlxG.camera.flash();
                    (FlxG.sound.play(Paths.sound('closegame')).play()).onComplete = ()->{Sys.exit(0);}
            }
            

        },null,(o:FlxSprite)->{
            o.setColorTransform(1,1,1,1,255);

        },(o:FlxSprite)->{
            o.setColorTransform(1,1,1,1);

        },false,true,false);
    }
}

function update() {
    if (!persistentUpdate) persistentUpdate = true;
    if ((FlxG.keys.justPressed.SEVEN || controls.SWITCHMOD)) {
        openSubState(controls.SWITCHMOD ? new ModSwitchMenu() : new EditorPicker());
        persistentUpdate = !(persistentDraw = true);
    }

    if (FlxG.keys.justPressed.Q) {
        FlxG.switchState(new FreeplayBopCity());
    }

    for (i in buttons) {
        FlxG.collide(i,walls);
    }
}