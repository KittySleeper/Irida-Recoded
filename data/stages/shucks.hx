import StringTools;

var bloom:CustomShader;
var colorShit:CustomShader;

function postCreate() {
    p1_light.origin.y = p1_glow.origin.y = 0;

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

function update(elapsed:Float) {
    p1_light.angle = p1_glow.angle = Math.sin(Conductor.songPosition / 1000) * 7.5;
}

function phaseOne() {
    // if (Options.gameplayShaders)
    //     for (i in [bloom, colorShit])
    //         camGame.addShader(i);

    for (obj in PlayState.instance.stage.stageSprites.keys())
        PlayState.instance.stage.stageSprites.get(obj).visible = true;

    gf.visible = true;
}

function chairPhase() {
    for (obj in PlayState.instance.stage.stageSprites.keys())
        if (!StringTools.contains(obj, "chair"))
            PlayState.instance.stage.stageSprites.get(obj).visible = false;
        else
            PlayState.instance.stage.stageSprites.get(obj).visible = true;

    new FlxTimer().start(0.05, (t) -> {
        gf.visible = dad.visible = boyfriend.visible = false;
    });

    chair_introtop.playAnim('intro', true);
    chair_introbottom.playAnim('intro', true);

    chair_introtop.animation.finishCallback = (anim:String) -> {
        chair_introtop.visible = false;
        boyfriend.visible = true;
    };

    chair_introbottom.animation.finishCallback = (anim:String) -> {
        chair_introbottom.visible = false;
        dad.visible = gf.visible = true;
    };
}

function runningPhase() {
    for (obj in PlayState.instance.stage.stageSprites.keys())
        if (!StringTools.contains(obj, "run"))
            PlayState.instance.stage.stageSprites.get(obj).visible = false;
        else
            PlayState.instance.stage.stageSprites.get(obj).visible = true;

    gf.visible = run_legsdetg.visible = false;

    run_bg.playAnim("intro");

    run_bg.animation.finishCallback = (anim:String) -> {
        run_bg.playAnim("hall", true);
    };

    dad.animation.finishCallback = (anim:String) -> {
        run_legsdetg.visible = true;
    };

    new FlxTimer().start(0.05, (t) -> {
        dad.playAnim("intro", true);
        dad.animation.finishCallback = (anim:String) -> {
            run_legsdetg.visible = true;
        };    
    });
}

function thereisbloodthereisbodies()
    run_bg.playAnim("hallbloody", true);

function shuckyducky()
    run_bg.playAnim("end", true);

function normalLight() {
    if (Options.gameplayShaders) {
        FlxTween.tween(bloom, {Intensity: 1}, 1.25, {ease: FlxEase.circInOut});
        FlxTween.tween(colorShit, {contrast: 30, hue: -10, saturation: -10, brightness: 0}, 1.25, {ease: FlxEase.circInOut});
    }
}

function darkLight() {
    if (Options.gameplayShaders) {
        FlxTween.tween(bloom, {Intensity: -0.05}, 1.25, {ease: FlxEase.circInOut});
        FlxTween.tween(colorShit, {contrast: 50, hue: 1.25, saturation: 100, brightness: -50}, 1.25, {ease: FlxEase.circInOut});
    }
}

function brightLight() {
    if (Options.gameplayShaders) {
        FlxTween.tween(bloom, {Intensity: 1.35}, 0.95, {ease: FlxEase.circInOut});
        FlxTween.tween(colorShit, {contrast: 0.35, hue: -25, saturation: 20, brightness: 5}, 0.95, {ease: FlxEase.circInOut});
    }
}