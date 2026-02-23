import hxvlc.flixel.FlxVideoSprite;

var videoCam:FlxCamera;
var videoMap:Map<String, FlxVideoSprite> = [];

function postCreate() {
    videoCam = FlxG.cameras.insert(new FlxCamera(), 1, false);
    videoCam.bgColor = 0xFF;

	for (event in events) {
		if (event.name == 'Play Video') {
            var video:FlxVideoSprite = new FlxVideoSprite(0, 0);
            video.load(Paths.video(event.params[0]));
            video.bitmap.onEndReached.add(video.destroy);
            video.bitmap.onFormatSetup.add(function():Void
            {
                if (video.bitmap != null && video.bitmap.bitmapData != null)
                {
                    final scale:Float = Math.min(FlxG.width / video.bitmap.bitmapData.width, FlxG.height / video.bitmap.bitmapData.height);

                    video.setGraphicSize(video.bitmap.bitmapData.width * scale, video.bitmap.bitmapData.height * scale);
                    video.updateHitbox();
                    video.screenCenter();
                }
            });
            video.camera = videoCam;
            video.visible = false;
            add(video);

            videoMap.set(event.params[0], video);
        }
    }
}

function onEvent(event){
	if (event.event.name == 'Play Video') {
        if (videoMap.exists(event.event.params[0])) {
            videoMap.get(event.event.params[0]).visible = true;
            videoMap.get(event.event.params[0]).play();
        }
    }
}