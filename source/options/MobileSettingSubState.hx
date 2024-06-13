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
import extension.eightsines.EsOrientation;

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
		0.7);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		
		var option:Option = new Option('Change Screen Orientation',
        "what should be",
		'orientation',
		'string',
		'landscape',
        ['unspecified','portrait','landscape']);
		addOption(option);

		var option:Option = new Option('Hide Hitbox Hint',
		'if checked, hitbox hint will get hidden',
		'hideHint',
		'bool',
		false);
		addOption(option);

		super();
	}

    override function create() {
        _virtualpad.alpha = 0;
        super.create();
    }

    override function update(elapsed:Float) {
        _virtualpad.alpha = ClientPrefs.mobileControlOpacity;

        if (ClientPrefs.orientation == 'portrait') {
		    EsOrientation.setScreenOrientation(EsOrientation.ORIENTATION_PORTRAIT);
		else if (ClientPrefs.orientation == 'landscape') {
		    EsOrientation.setScreenOrientation(EsOrientation.ORIENTATION_LANDSCAPE);
		else if (ClientPrefs.orientation == 'unspecified') {
		    EsOrientation.setScreenOrientation(EsOrientation.ORIENTATION_UNSPECIFIED);
		}

        super.update(elapsed);
    }
}