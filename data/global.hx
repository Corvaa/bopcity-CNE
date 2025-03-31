import funkin.backend.MusicBeatTransition;
import funkin.backend.utils.WindowUtils;
import funkin.menus.MainMenuState;
import lime.graphics.Image;

static var redirectStates:Map<FlxState, String> = [
    MainMenuState =>  "MainBopCityMenu",
    FreeplayState =>  "FreeplayBopCity",
];

function preStateSwitch() {
    WindowUtils.winTitle = "FNF: Vs BopCity";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('me'))));

    for (redirectState in redirectStates.keys()) {
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) {
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
        }
    }
}

function destroy() WindowUtils.resetTitle();