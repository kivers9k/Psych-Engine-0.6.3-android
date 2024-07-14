package;

import VideoHandler;
import flixel.FlxSprite;

class SpriteVideo extends FlxSprite
{
    public var bitmap:VideoHandler;
    public var playbackRate:Float = 1;

    public function new(x:Float, y:Float, video:String, ?muteSound:Bool = true)
    {
        super(x, y);
        
        bitmap = new VideoHandler();
        bitmap.playVideo(Paths.video(video), false, muteSound);
        bitmap.visible = false;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    
        loadGraphic(bitmap.bitmapData);
        bitmap.set_rate(playbackRate);
    }

    override function destroy():Void
    {
        super.destroy();
        bitmap = null;
    }
}
