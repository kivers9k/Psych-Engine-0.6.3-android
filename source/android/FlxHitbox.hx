package android;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.ui.FlxButton;
import flixel.FlxSprite;

class FlxHitbox extends FlxSpriteGroup {
	public var hitbox:FlxSpriteGroup;

	public var buttonLeft:FlxButton;
	public var buttonDown:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonRight:FlxButton;

	public var orgAntialiasing:Bool = true;
	
	public function new(?antialiasingAlt:Bool = true) {
		super();

		orgAlpha = alphaAlt;
		orgAntialiasing = antialiasingAlt;

		buttonLeft = new FlxButton(0, 0);
		buttonDown = new FlxButton(0, 0);
		buttonUp = new FlxButton(0, 0);
		buttonRight = new FlxButton(0, 0);

		hitbox = new FlxSpriteGroup();
		hitbox.add(add(buttonLeft = createhitbox(0, 0, 0xC457D3)));
		hitbox.add(add(buttonDown = createhitbox(320, 0, 0x00DAFF)));
		hitbox.add(add(buttonUp = createhitbox(640, 0, 0x00FF00)));
		hitbox.add(add(buttonRight = createhitbox(960, 0, 0xFF0000)));

		var hitbox_hint:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('androidcontrols/hitbox_hint'));
		hitbox_hint.antialiasing = orgAntialiasing;
		add(hitbox_hint);
	}

	public function createhitbox(x:Float = 0, y:Float = 0, colorYeah:Int = 0xFFFFFF) {
		var button = new FlxButton(x, y);
		button.loadGraphic(Paths.image('androidcontrols/hitbox'));
		button.antialiasing = orgAntialiasing;
		button.color = colorYeah;
		button.alpha = 0;// sorry but I can't hard lock the hitbox alpha
		button.onDown.callback = function (){FlxTween.num(0, 0.75, 0.075, {ease:FlxEase.circInOut}, function(alpha:Float){ button.alpha = alpha;});};
		button.onUp.callback = function (){FlxTween.num(0.75, 0, 0.1, {ease:FlxEase.circInOut}, function(alpha:Float){ button.alpha = alpha;});}
		button.onOut.callback = function (){FlxTween.num(button.alpha, 0, 0.2, {ease:FlxEase.circInOut}, function(alpha:Float){ button.alpha = alpha;});}
		return button;
	}

	override public function destroy():Void {
		super.destroy();

		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
	}
}
