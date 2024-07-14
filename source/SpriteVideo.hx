package;

#if VIDEOS_ALLOWED
import VideoHandler;
import openfl.events.Event;
import flixel.graphics.FlxGraphic;
import flixel.FlxSprite;
import flixel.FlxG;

class SpriteVideo extends FlxSprite
{
    public var bitmap:VideoHandler;
    public var rate:Float = 1;
    public var volume:Float = 1;

    public function new(x:Float, y:Float, video:String, ?muteSound:Bool = true)
    {
        super(x, y);
        
        var videoPath:String = Paths.video(video);

        bitmap = new VideoHandler();
        bitmap.playVideo(videoPath);
        bitmap.visible = false;
        if (muteSound) volume = 0;

        FlxG.stage.removeEventListener(Event.ENTER_FRAME, bitmap.update);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    
        var vidBitmap = bitmap.bitmapData;
        loadGraphic(vidBitmap);

        bitmap.volume = volume;
        bitmap.rate = rate;
    }

    override function destroy():Void
    {
        super.destroy();
        bitmap.volume = 0;
        bitmap = null;
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
}
#end
