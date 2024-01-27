package android;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import flixel.FlxSprite;

class FlxHitbox extends FlxSpriteGroup {
	public var hitbox:FlxSpriteGroup;
	public var hint:FlxSpriteGroup;
	public var buttonLeft:FlxButton;
	public var buttonDown:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonRight:FlxButton;
	public var buttonHintLeft:FlxSprite;
	public var buttonHintDown:FlxSprite;
	public var buttonHintUp:FlxSprite;
	public var buttonHintRight:FlxSprite;

	public function new() {
		super();

		hitbox = new FlxSpriteGroup();
		hint = new FlxSpriteGroup();
		buttonLeft = new FlxButton(0, 0);
		buttonDown = new FlxButton(0, 0);
		buttonUp = new FlxButton(0, 0);
		buttonRight = new FlxButton(0, 0);
        buttonHintLeft = new FlxSprite(0, 0);
        buttonHintDown = new FlxSprite(0, 0);
        buttonHintUp = new FlxSprite(0, 0);
        buttonHintRight = new FlxSprite(0, 0);

		hitbox.add(add(buttonLeft = createHitbox(0, 0, 0xC457D3)));
		hitbox.add(add(buttonDown = createHitbox(320, 0, 0x00DAFF)));
		hitbox.add(add(buttonUp = createHitbox(640, 0, 0x00FF00)));
		hitbox.add(add(buttonRight = createHitbox(960, 0, 0xFF0000)));

		hint.add(add(buttonHintLeft = createHitboxHint(0, 0, 0xC457D3)));
		hint.add(add(buttonHintDown = createHitboxHint(320, 0, 0x00DAFF)));
		hint.add(add(buttonHintUp = createHitboxHint(640, 0, 0x00FF00)));
		hint.add(add(buttonHintRight = createHitboxHint(960, 0, 0xFF0000)));
	}

    public function createHitbox(x:Float = 0, y:Float = 0, colors:Int = 0xFFFFFF) {
        var button:FlxButton = new FlxButton(x,y);
        button.loadGraphic(Paths.image('androidcontrols/hitbox'));
        button.updateHitbox();
        button.color = colors;
        button.alpha = 0;
        add(button);

        button.onOut.callback = function() {button.alpha = 0;}
        button.onDown.callback = function() {button.alpha = ClientPrefs.mobileControlOpacity;}
        button.onUp.callback = function() {button.alpha = 0;}

        return button;
    }

    public function createHitboxHint(x:Float = 0, y:Float = 0, colors:Int = 0xFFFFFF) {
        var buttonHint:FlxSprite = new FlxSprite(x,y);
        buttonHint.loadGraphic(Paths.image('androidcontrols/hint'));
        buttonHint.alpha = ClientPrefs.mobileControlOpacity;
        buttonHint.color = colors;
        add(buttonHint);

        return buttonHint;
    }

	override function create() {
		if (ClientPrefs.hideHint) {
			hint.visible = false;
		}
	}

	override public function destroy():Void {
		super.destroy();

		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
	}
}