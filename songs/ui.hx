// i weirdly love the way i coded this idk why

var uiParams:Dynamic = {
    hudType: "default",
    mainColor: 0xFF8B0000,
    secondaryColor: 0xFF140000,
    flipped: false
};

function postCreate() {
    regenHud();
}

function postUpdate(elapsed) {
    iconP2.x = uiParams.flipped ? healthBarBG.x + healthBarBG.width - iconP2.width - 10 : healthBarBG.x + 10;
    iconP1.x = uiParams.flipped ? healthBarBG.x + 10 : healthBarBG.x + healthBarBG.width - iconP1.width - 10;
}

function regenHud() {
    iconP1.flipX = uiParams.flipped;
    iconP2.flipX = iconP1.flipX;
    healthBar.flipX = uiParams.flipped;

    var iridaHealthBarBG:FunkinSprite = insert(members.indexOf(iconP1), new FunkinSprite(0, FlxG.height * 0.8, Paths.image("game/bars/" + uiParams.hudType)));
    iridaHealthBarBG.screenCenter(FlxAxes.X);
    iridaHealthBarBG.flipY = downscroll;
    iridaHealthBarBG.camera = camHUD;

    healthBar.setGraphicSize(iridaHealthBarBG.width * 0.85, iridaHealthBarBG.height * 0.25);

    for (txt in [scoreTxt, missesTxt, accuracyTxt]) {
        txt.setPosition(iridaHealthBarBG.x + 200, iridaHealthBarBG.y + iridaHealthBarBG.height * 0.65);
        txt.fieldWidth = iridaHealthBarBG.width * 0.6;
        txt.font = Paths.font("SuperMario256.ttf");
        txt.color = uiParams.mainColor;
        txt.borderColor = uiParams.secondaryColor;
        txt.size = 20;
    }

    accuracyTxt.removeFormat(accFormat); //idk why we have to do ts lmao

    healthBarBG.destroy();
    healthBarBG = iridaHealthBarBG;

    for (strumline in strumLines.members) {
        for (strum in strumline.members) {
            strum.kill();
            strumline.remove(strum);
        }

        strumline.generateStrums();
    }
}

function onStrumCreation(e) {
    e.sprite = "game/notes/" + uiParams.hudType;
    e.cancelAnimation();
}