package android;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup;
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

		hitbox = new FlxSpriteGroup();
		hitbox.add(add(buttonLeft = createhitbox(0, 0, 0xC457D3)));
		hitbox.add(add(buttonDown = createhitbox(320, 0, 0x00DAFF)));
		hitbox.add(add(buttonUp = createhitbox(640, 0, 0x00FF00)));
		hitbox.add(add(buttonRight = createhitbox(960, 0, 0xFF0000)));
	}

    public function createhitbox(x:Float = 0, y:Float = 0, colors:Int = 0xFFFFFF) {
        var button:FlxButton = new FlxButton(x,y);
        button.loadGraphic(Paths.image('androidcontrols/hitbox'));
        button.updateHitbox();
        button.alpha = 0;
        button.color = colors;
        button.antialiasing = ClientPrefs.globalAntialiasing;
        button.visible = ClientPrefs.hideHint;
        add(button);

        button.onOut.callback = function() {button.alpha = 0;}
        button.onDown.callback = function() {button.alpha = ClientPrefs.mobileControlOpacity;}
        button.onUp.callback = function() {button.alpha = 0;}

        var hint:FlxSprite = new FlxSprite(x,y);
        hint.loadGraphic(Paths.image('androidcontrols/hint'));
        hint.color = colors;
        hint.antialiasing = ClientPrefs.globalAntialiasing;
        hint.alpha = ClientPrefs.mobileControlOpacity;
        hint.visible = ClientPrefs.hideHint;
        add(hint);

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