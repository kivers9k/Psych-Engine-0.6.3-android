package;

import VideoHandler as MP4Handler;
import flixel.FlxG;
import flixel.FlxSprite;

class SpriteVideo extends FlxSprite
{
    public var bitmap:MP4Handler;
    public function new(X:Float, Y:Float, video:String)
    {
        super(X, Y);        
        setPosition(X, Y);
        
        bitmap = new MP4Handler();
        bitmap.playVideo(Paths.video(video));
        bitmap.visible = false;
        bitmap.volume = 0;

        FlxG.stage.removeEventListener('enterFrame', bitmap.update);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
        loadGraphic(bitmap.bitmapData);
        bitmap.set_rate(PlayState.instance.playbackRate);
    }

    override function destroy():Void
    {
        super.destroy();
        bitmap = null;
    }
}
