import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

var lastFocused = null;
var cammove = 9;
public var moveCam = true;
public var cancelCameraMove = false;

function create() {
    if (curSong == "hollup") {
        gf.x = -430;
        gf.y = -50;
        gf.camera = camHUD;
        remove(gf);
insert(9999, gf);
    }
}

function beatHit() {
    switch(curBeat){
    case 157:
        FlxTween.tween(gf, {x: -50}, 1.4, {ease: FlxEase.sineOut});
    case 224:
        FlxTween.tween(gf, {x: -430}, 2, {ease: FlxEase.sineOut});
    }
}

function onCameraMove(e){
    if(lastFocused != (lastFocused = curCameraTarget)){
        if(FlxG.random.bool(500)) {
        FlxTween.tween(plane, {x: -2150}, 5.4, {ease: FlxEase.sineInOut, onComplete: function() {plane.x = 10000;}});
        }
    }
}

function postUpdate() {
    if (moveCam) {
        switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
            case "singLEFT": 
                camFollow.x -= cammove;
            case "singDOWN": 
                camFollow.y += cammove;
            case "singUP": 
                camFollow.y -= cammove;
            case "singRIGHT": 
                camFollow.x += cammove;
            case "idle", "hey":
        }
    }
}

function onCameraMove(e) if(cancelCameraMove) e.cancel();