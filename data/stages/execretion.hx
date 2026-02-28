var bloom:CustomShader;
var colorShit:CustomShader;

var twinithinkthisstuffgouporsmth:Array<FunkinSprite> = [];

function postCreate() {
    if (Options.gameplayShaders) {
        bloom = new CustomShader('bloom');
        bloom.Threshold = 0.05;
        bloom.Intensity = 0.5;

        colorShit = new CustomShader('ColorCorrection');
        colorShit.brightness = -10;
        colorShit.contrast = 150;
        colorShit.hue = -15;
        colorShit.saturation = 25;
    }

    if (Options.gameplayShaders)
        for (i in [bloom, colorShit])
            camGame.addShader(i);

    light.y += 1500;
    sun.y += 1500;

    twinithinkthisstuffgouporsmth = [phaseone_pipe, phaseone_pipet, phaseone_pipeth, phaseone_blocks, phaseone_blockth, phaseone_blocko, phaseone_blockf, phaseone_blockt];
    for (obj in twinithinkthisstuffgouporsmth) obj.y += 1500;
}

function shiComeUpNShi() {
    for (obj in twinithinkthisstuffgouporsmth)
        FlxTween.tween(obj, {y: obj.y - 1500}, 3, {ease: FlxEase.circOut});
}

function sunComeUpNShi() {
    for (obj in [light, sun]) FlxTween.tween(obj, {y: obj.y - 1500}, 25, {ease: FlxEase.circOut});

    if (Options.gameplayShaders) {
        FlxTween.tween(bloom, {Intensity: 0.95}, 25, {ease: FlxEase.circOut});
        FlxTween.tween(colorShit, {contrast: 25, hue: 2, saturation: 5, brightness: 35}, 25, {ease: FlxEase.circOut});
    }
}

function normalLight() {
    if (Options.gameplayShaders) {
        FlxTween.tween(bloom, {Intensity: 0.5}, 1.25, {ease: FlxEase.circInOut});
        FlxTween.tween(colorShit, {contrast: 30, hue: -10, saturation: -10, brightness: 15}, 1.25, {ease: FlxEase.circInOut});
    }
}

function darkLight() {
    if (Options.gameplayShaders) {
        FlxTween.tween(bloom, {Intensity: -0.15}, 1.25, {ease: FlxEase.circInOut});
        FlxTween.tween(colorShit, {contrast: 150, hue: -15, saturation: 25, brightness: -50}, 1.25, {ease: FlxEase.circInOut});
    }
}