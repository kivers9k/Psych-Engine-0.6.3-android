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

	public function new() {
		super();

		buttonLeft = new FlxButton(0, 0);
		buttonDown = new FlxButton(0, 0);
		buttonUp = new FlxButton(0, 0);
		buttonRight = new FlxButton(0, 0);

		leftHint = new FlxSprite(0, 0);
		downHint = new FlxSprite(0, 0);
		upHint = new FlxSprite(0, 0);
		rightHint = new FlxSprite(0, 0);

		hitbox = new FlxSpriteGroup();
		hitbox.add(add(buttonLeft = createhitbox(0, 0, 0xC457D3)));
		hitbox.add(add(buttonDown = createhitbox(320, 0, 0x00DAFF)));
		hitbox.add(add(buttonUp = createhitbox(640, 0, 0x00FF00)));
		hitbox.add(add(buttonRight = createhitbox(960, 0, 0xFF0000)));

		hitboxHint = new FlxSpriteGroup();
		hitboxHint.add(add(leftHint = createhitboxhint(0, 0, 0xC457D3)));
		hitboxHint.add(add(downHint = createhitboxhint(320, 0, 0x00DAFF)));
		hitboxHint.add(add(upHint = createhitboxhint(640, 0, 0x00FF00)));
		hitboxHint.add(add(rightHint = createhitboxhint(960, 0, 0xFF0000)));
	}

	public function createhitbox(x:Float = 0, y:Float = 0, colorYeah:Int = 0xFFFFFF) {
		var button = new FlxButton(x, y);
		button.loadGraphic(Paths.image('androidcontrols/hitbox'));
		button.color = colorYeah;
		button.alpha = 0;
		return button;
	}

	public function createhitboxhint(x:Float = 0,y:Float = 0, colors:Int = 0xFFFFFF) {
		var buttonHint = new FlxSprite(x, y);
		buttonHint.loadGraphic(Paths.image('androidcontrols/hitbox_hint'));
		buttonHint.color = colors;
		buttonHint.alpha = 0;
		return buttonHint;
	}

	override public function destroy():Void {
		super.destroy();

		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
	}
}