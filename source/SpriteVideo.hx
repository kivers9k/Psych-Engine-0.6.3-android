package;

#if VIDEOS_ALLOWED
import VideoHandler;
import flixel.graphics.FlxGraphic;
import flixel.FlxSprite;
import flixel.FlxG;

class SpriteVideo extends FlxSprite
{
    private var bitmap:VideoHandler;
    public var rate:Float = 1;
    public var muteVolume:Bool = true;

    public function new(x:Float, y:Float, video:String)
    {
        super(x, y);
        
        var videoPath:String = Paths.video(video);

        bitmap = new VideoHandler();
        bitmap.playVideo(videoPath);
        bitmap.alpha = 0;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
        bitmap.volume = (muteVolume ? 0 : 1);
        bitmap.rate = rate;
    
        var vidBitmap = bitmap.bitmapData;
        loadGraphic(vidBitmap);
    }

    public function stop() {
        bitmap.stop();
    }
    
    public function pause() {
        bitmap.pause();
    }

    public function resume() {
        bitmap.resume();
    }

    override function destroy():Void
    {
        super.destroy();
        bitmap = null;
    }
}
#end
