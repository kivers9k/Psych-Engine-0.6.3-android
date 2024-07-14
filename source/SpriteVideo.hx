package;

import VideoHandler;
import flixel.FlxG;
import flixel.FlxSprite;

class SpriteVideo extends FlxSprite {
    public var playbackRate:Float = 1;
    public var pause:Bool = false;
    public var bitmap:VideoHandler;
    public function new(x:Float, y:Float, video:String) {
        super(x ,y);

        bitmap = new VideoHandler();
        bitmap.playVideo(Paths.video(video));
        bitmap.visible = false;
        bitmap.volume = 0;

        FlxG.stage.removeEventListener('enterFrame', bitmap.update);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        loadGraphic(bitmap.bitmapData);

        bitmap.set_rate(playbackRate);
        if (pause) {
            bitmap.pause();
        } else {
            bitmap.resume();
        }
    }
}