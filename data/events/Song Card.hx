function onEvent(e) {
    if (e.event.name == "Song Card") {
        var songCard:FunkinSprite = insert(0, new FunkinSprite(0, 0, Paths.image("game/cards/" + (e.event.params[0] == "" ? PlayState.SONG.meta.name : e.event.params[0]))));
        songCard.alpha = 0;
        FlxTween.tween(songCard, {alpha: 1}, e.event.params[1], {ease: FlxEase.circInOut});
        FlxTween.tween(songCard, {alpha: 0}, e.event.params[1], {ease: FlxEase.circIn, startDelay: e.event.params[2]});
        songCard.camera = camHUD;
        songCard.screenCenter();
    }
}