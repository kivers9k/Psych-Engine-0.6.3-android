package;

#if VIDEOS_ALLOWED
import VideoHandler;
import flixel.graphics.FlxGraphic;
import flixel.FlxSprite;
import flixel.FlxG;

class SpriteVideo extends FlxSprite
{
    public var bitmap:VideoHandler;

    public function new(x:Float, y:Float, video:String, ?muteSound:Bool = true)
    {
        super(x, y);
        
        var videoPath:String = Paths.video(video);

        bitmap = new VideoHandler();
        bitmap.playVideo(videoPath, false, muteSound);
        bitmap.visible = false;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    
        var vidBitmap:FlxGraphic = FlxG.bitmap.add(bitmap.bitmapData, false, '');
        loadGraphic(vidBitmap);
    }

    override function destroy():Void
    {
        super.destroy();
        bitmap = null;
    }
}
#end