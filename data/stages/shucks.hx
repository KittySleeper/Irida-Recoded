import StringTools;

var bloom:CustomShader;
var colorShit:CustomShader;

function postCreate() {
    if (Options.gameplayShaders) {
        bloom = new CustomShader('bloom');
        bloom.Threshold = 0.005;
        bloom.Intensity = 1;

        colorShit = new CustomShader('ColorCorrection');
        colorShit.brightness = 0;
        colorShit.contrast = 30;
        colorShit.hue = -10;
        colorShit.saturation = -10;
    }

    for (obj in PlayState.instance.stage.stageSprites.keys())
        PlayState.instance.stage.stageSprites.get(obj).visible = false;

    gf.visible = false;
}

function phaseOne() {
    if (Options.gameplayShaders)
        for (i in [bloom, colorShit])
            camGame.addShader(i);

    for (obj in PlayState.instance.stage.stageSprites.keys())
        PlayState.instance.stage.stageSprites.get(obj).visible = true;

    gf.visible = true;
}

function chairPhase() {
    for (obj in PlayState.instance.stage.stageSprites.keys())
        if (!StringTools.contains(obj, "chair"))
            PlayState.instance.stage.stageSprites.get(obj).visible = false;

    gf.visible = false;
}

function normalLight() {
    FlxTween.tween(bloom, {Intensity: 1}, 1.25, {ease: FlxEase.circInOut});
    FlxTween.tween(colorShit, {contrast: 30, hue: -10, saturation: -10, brightness: 0}, 1.25, {ease: FlxEase.circInOut});
}

function darkLight() {
    FlxTween.tween(bloom, {Intensity: -0.05}, 1.25, {ease: FlxEase.circInOut});
    FlxTween.tween(colorShit, {contrast: 50, hue: 1.25, saturation: 100, brightness: -50}, 1.25, {ease: FlxEase.circInOut});
}

function brightLight() {
    FlxTween.tween(bloom, {Intensity: 1.35}, 0.95, {ease: FlxEase.circInOut});
    FlxTween.tween(colorShit, {contrast: 0.35, hue: -25, saturation: 20, brightness: 5}, 0.95, {ease: FlxEase.circInOut});
}