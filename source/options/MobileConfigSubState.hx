package options;

#if desktop
import Discord.DiscordClient;
#end
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxSubState;
import android.FlxHitbox;
import android.MobileControls.Config;
import android.FlxVirtualPad;

using StringTools;

class MobileConfigSubState extends BaseOptionsMenu
{
	var vpad:FlxVirtualPad;
	var hbox:FlxHitbox;
	var upPozition:FlxText;
	var downPozition:FlxText;
	var leftPozition:FlxText;
	var rightPozition:FlxText;
	var inputvari:Alphabet;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var controlitems:Array<String> = ['Pad-Right','Pad-Left','Pad-Custom','Double','Hitbox','Keyboard'];
	var curSelect:Int = 0;
	var buttonistouched:Bool = false;
	var bindbutton:FlxButton;
	var config:Config;

	public function new()
	{
		title = 'Mobile Config';
		rpcTitle = 'Mobile Config Menu';
	}

		config = new Config();
		curSelect= config.getcontrolmode();

		vpad = new FlxVirtualPad(RIGHT_FULL, NONE, ClientPrefs.globalAntialiasing);
		vpad.alpha = 0;
		add(vpad);

		hbox = new FlxHitbox(ClientPrefs.globalAntialiasing);
		hbox.visible = false;
		add(hbox);

		inputvari = new Alphabet(500, 50, controlitems[curSelect], false);
		add(inputvari);

		var ui_tex = Paths.getSparrowAtlas('androidcontrols/menu/arrows');

		leftArrow = new FlxSprite(inputvari.x - 60, inputvari.y + 50);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		add(leftArrow);

		rightArrow = new FlxSprite(inputvari.x + inputvari.width + 10, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		add(rightArrow);

		upPozition = new FlxText(10, FlxG.height - 104, 0,"Button Up X:" + vpad.buttonUp.x +" Y:" + vpad.buttonUp.y, 16);
		upPozition.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		upPozition.borderSize = 2.4;
		add(upPozition);

		downPozition = new FlxText(10, FlxG.height - 84, 0,"Button Down X:" + vpad.buttonDown.x +" Y:" + vpad.buttonDown.y, 16);
		downPozition.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		downPozition.borderSize = 2.4;
		add(downPozition);

		leftPozition = new FlxText(10, FlxG.height - 64, 0,"Button Left X:" + vpad.buttonLeft.x +" Y:" + vpad.buttonLeft.y, 16);
		leftPozition.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		leftPozition.borderSize = 2.4;
		add(leftPozition);

		rightPozition = new FlxText(10, FlxG.height - 44, 0,"Button RIght x:" + vpad.buttonRight.x +" Y:" + vpad.buttonRight.y, 16);
		rightPozition.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		rightPozition.borderSize = 2.4;
		add(rightPozition);

		var tipText:FlxText = new FlxText(10, FlxG.height - 24, 0, 'Press BACK to Go Back to Options Menu', 16);
		tipText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tipText.borderSize = 2;
		tipText.scrollFactor.set();
		add(tipText);

		changeSelect();
        super();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		leftArrow.x = inputvari.x - 60;
		rightArrow.x = inputvari.x + inputvari.width + 10;
		inputvari.screenCenter(X);
		
		for (touch in FlxG.touches.list){		
			if(touch.overlaps(leftArrow) && touch.justPressed)
			{
				changeSelect(-1);
			}
			else if (touch.overlaps(rightArrow) && touch.justPressed)
			{
				changeSelect(1);
			}
			trackbutton(touch);
		}
		
		#if android
		if (FlxG.android.justReleased.BACK)
		{
			save();
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new options.OptionsState());
		}
		#end
	}

	function changeSelect(change:Int = 0)
	{
		curSelect += change;
	
		if (curSelect < 0)
			curSelect = controlitems.length - 1;
		if (curSelect >= controlitems.length)
			curSelect = 0;
	
		inputvari.text = controlitems[curSelect];

		var daChoice:String = controlitems[Math.floor(curSelect)];

		switch (daChoice)
		{
				case 'Pad-Right':
					remove(vpad);
					vpad = new FlxVirtualPad(RIGHT_FULL, NONE, ClientPrefs.globalAntialiasing);
					add(vpad);
				case 'Pad-Left':
					remove(vpad);
					vpad = new FlxVirtualPad(FULL, NONE, ClientPrefs.globalAntialiasing);
					add(vpad);
				case 'Pad-Custom':
					remove(vpad);
					vpad = new FlxVirtualPad(RIGHT_FULL, NONE, ClientPrefs.globalAntialiasing);
					add(vpad);
					loadcustom();
				case 'Duo':
					remove(vpad);
					vpad = new FlxVirtualPad(DUO, NONE, ClientPrefs.globalAntialiasing);
					add(vpad);
				case 'Hitbox':
					vpad.alpha = 0;
				case 'Keyboard':
					remove(vpad);
					vpad.alpha = 0;
		}

		if (daChoice != "Hitbox")
		{
			hbox.visible = false;
		}

		if (daChoice != "Pad-Custom")
		{
			upPozition.visible = false;
			downPozition.visible = false;
			leftPozition.visible = false;
			rightPozition.visible = false;
		}
		else
		{
			upPozition.visible = true;
			downPozition.visible = true;
			leftPozition.visible = true;
			rightPozition.visible = true;
		}
	}

	function trackbutton(touch:flixel.input.touch.FlxTouch){
		var daChoice:String = controlitems[Math.floor(curSelect)];

		if (daChoice == 'Pad-Custom'){
			if (buttonistouched){
				if (bindbutton.justReleased && touch.justReleased)
				{
					bindbutton = null;
					buttonistouched = false;
				}else 
				{
					movebutton(touch, bindbutton);
					setbuttontexts();
				}
			}
			else 
			{
				if (vpad.buttonUp.justPressed) {
					movebutton(touch, vpad.buttonUp);
				}
				
				if (vpad.buttonDown.justPressed) {
					movebutton(touch, vpad.buttonDown);
				}

				if (vpad.buttonRight.justPressed) {
					movebutton(touch, vpad.buttonRight);
				}

				if (vpad.buttonLeft.justPressed) {
					movebutton(touch, vpad.buttonLeft);
				}
			}
		}
	}

	function movebutton(touch:flixel.input.touch.FlxTouch, button:flixel.ui.FlxButton) {
		button.x = touch.x - vpad.buttonUp.width / 2;
		button.y = touch.y - vpad.buttonUp.height / 2;
		bindbutton = button;
		buttonistouched = true;
	}

	function setbuttontexts() {
		upPozition.text = "Button Up X:" + vpad.buttonUp.x +" Y:" + vpad.buttonUp.y;
		downPozition.text = "Button Down X:" + vpad.buttonDown.x +" Y:" + vpad.buttonDown.y;
		leftPozition.text = "Button Left X:" + vpad.buttonLeft.x +" Y:" + vpad.buttonLeft.y;
		rightPozition.text = "Button RIght x:" + vpad.buttonRight.x +" Y:" + vpad.buttonRight.y;
	}

	function save() {
		config.setcontrolmode(curSelect);
		var daChoice:String = controlitems[Math.floor(curSelect)];

		if (daChoice == 'Pad-Custom'){
			config.savecustom(vpad);
		}
	}

	function loadcustom():Void{
		vpad = config.loadcustom(vpad);	
	}
}
