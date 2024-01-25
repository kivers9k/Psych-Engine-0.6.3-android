package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import openfl.Lib;

using StringTools;

class MobileSettingSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Mobile Setting';
		rpcTitle = 'Mobile Setting Menu';

		var option:Option = new Option('Mobile Controls Opacity',
		'Changes Mobile Controls Opacity',
		'mobileControlOpacity',
		'float',
		0.5);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		var option:Option = new Option('Hide Hitbox Hint',
		'if checked, hitbox hint will get hidden',
		'hideHint',
		'bool',
		false);
		addOption(option);

		super();
	}

    override function update(elapsed:Float) {
        // reload virtualpad alpha
        if (controls.UI_LEFT || controls.UI_RIGHT) {
            removeVirtualPad();
            addVirtualPad(FULL, A_B_C);
        }
        super.update(elapsed);
    }
}