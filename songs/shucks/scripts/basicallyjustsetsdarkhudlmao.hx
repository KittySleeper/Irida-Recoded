function create() {
    scripts.set("uiParams", {
        hudType: "shadow",
        mainColor: FlxColor.BLACK,
        secondaryColor: FlxColor.WHITE,
        flipped: false
    });
}

function phaseOne() {
    scripts.set("uiParams", {
        hudType: "default",
        mainColor: 0xFF8B0000,
        secondaryColor: 0xFF140000,
        flipped: true
    });

    scripts.call("regenHud");
}