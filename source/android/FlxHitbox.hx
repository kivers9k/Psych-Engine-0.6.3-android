package android;

import flixel.util.FlxGradient;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;

class FlxHitbox extends FlxSpriteGroup {
	//group stuff
	public var hitbox:FlxSpriteGroup;
	public var hint:FlxSpriteGroup;

    //button stuff
	public var buttonLeft:FlxButton;
	public var buttonDown:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonRight:FlxButton;

	public function new() {
		super();

		hitbox = new FlxSpriteGroup();
		hint = new FlxSpriteGroup();

        var hitboxWidth:Int = Math.floor(FlxG.width / 4);

		hitbox.add(add(buttonLeft = createhitbox(0, 0, hitboxWidth, FlxG.height, 0xC457D3)));
		hitbox.add(add(buttonDown = createhitbox(hitboxWidth, 0, hitboxWidth, FlxG.height, 0x00DAFF)));
		hitbox.add(add(buttonUp = createhitbox(hitboxWidth*2, 0, hitboxWidth, FlxG.height, 0x00FF00)));
		hitbox.add(add(buttonRight = createhitbox(hitboxWidth*3, 0, hitboxWidth, FlxG.height, 0xFF0000)));

		hint.add(add(createHitboxHint(0, 0, 0xC457D3)));
		hint.add(add(createHitboxHint(320, 0, 0x00DAFF)));
		hint.add(add(createHitboxHint(640, 0, 0x00FF00)));
		hint.add(add(createHitboxHint(960, 0, 0xFF0000)));
	}

	public function createhitbox(x:Float = 0, y:Float = 0, width:Int, height:Int, color:Int) {
		var hitboxSpr:FlxSprite = FlxGradient.createGradientFlxSprite(width, height, [0x0, color]);

		var button:FlxButton = new FlxButton(x, y);
		button.loadGraphic(hitboxSpr.pixels);
		button.updateHitbox();
		button.alpha = 0;

		button.onOut.callback = function() button.alpha = 0;
		button.onUp.callback = function() button.alpha = 0;
		button.onDown.callback = function() button.alpha = ClientPrefs.mobileControlOpacity;
		
		return button;
	}

    public function createHitboxHint(x:Float = 0, y:Float = 0, colors:Int = 0xFFFFFF) {
        var buttonHint:FlxSprite = new FlxSprite(x,y);
        buttonHint.loadGraphic(Paths.image('androidcontrols/hint'));
		if (ClientPrefs.hideHint) {
            buttonHint.alpha = 0;
		} else {
            buttonHint.alpha = ClientPrefs.mobileControlOpacity;
		}
		buttonHint.color = colors;

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
