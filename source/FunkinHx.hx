package;

import flixel.util.FlxColor;
import sys.io.File;

import hscript.Parser;
import hscript.Interp;
import hscript.Expr;

using StringTools;

class FunkinHx {
	public static var Function_Stop:Dynamic = "##PSYCHLUA_FUNCTIONSTOP";
	public static var Function_Continue:Dynamic = "##PSYCHLUA_FUNCTIONCONTINUE";

	public static var parser:Parser = new Parser();
	public var interp:Interp = new Interp();
	
	public var variables(get, never):Map<String, Dynamic>;
	public function get_variables():Dynamic {
		return interp.variables;
	}

	public function new(hxPaths:String) {
		preset();
		
		// the
		var contents:String = File.getContent(hxPaths);
		var lines:String = '';
		
		for (splitStr in contents.split('\n')) {
			if (!splitStr.startsWith('import')) {
				lines += splitStr + '\n';
			} else {
				var lib:String = splitStr.split(' ')[1].replace(';', '');
				var libName:String = lib.split('.')[lib.split('.').length - 1];
				
				if (Type.resolveClass(lib) != null) {
					interp.variables.set(libName, Type.resolveClass(lib));
				} else {
					#if (windows || mobile)
						SUtil.applicationAlert('Library not Found!', lib);
					#else
						FunkinLua.luaTrace('Library not Found: ' + lib, false, false, FlxColor.RED);
					#end
				}
			}
		}
		
		try {
			execute(lines);
		} catch(error:Dynamic) {
			#if (windows || mobile)
				SUtil.applicationAlert('Error on Hscript!', error);
			#else
				FunkinLua.luaTrace('Error on Hscript: ' + error, false, false, FlxColor.RED);
			#end
		}
		
		call('onCreate', []);
	}

	public function preset() {
		interp.variables.set('Function_Continue', Function_Continue);
		interp.variables.set('Function_Stop', Function_Stop);

		interp.variables.set('FlxG', FlxG);
		interp.variables.set('FlxSprite', FlxSprite);
		interp.variables.set('FlxCamera', FlxCamera);
		interp.variables.set('FlxTween', FlxTween);
		interp.variables.set('FlxEase', FlxEase);
		interp.variables.set('FlxTimer', FlxTimer);

		interp.variables.set('Paths', Paths);
		interp.variables.set('Character', Character);
		interp.variables.set('Alphabet', Alphabet);
		interp.variables.set('ClientPrefs', ClientPrefs);
		interp.variables.set('Conductor', Conductor);
		interp.variables.set('PlayState', PlayState);
		interp.variables.set('CustomSubstate', CustomSubstate);

		interp.variables.set('game', PlayState.instance);
		interp.variables.set('add', PlayState.instance.add);
		interp.variables.set('remove', PlayState.instance.remove);
		interp.variables.set('insert', PlayState.instance.insert);
		interp.variables.set('debugPrint', function(txt:String) {
			PlayState.instance.addTextToDebug(txt, FlxColor.WHITE);
		});
		interp.variables.set('setVar', function(name:String, args:Dynamic) {
			PlayState.instance.variables.set(name, args);
		});
		interp.variables.set('getVar', function(name:String) {
			var result:Dynamic = null;
			if (PlayState.instance.variables.exists(name)) {
				result = PlayState.instance.variables.get(name);
			}
			return result;
		});
		interp.variables.set('removeVar', function(name:String) {
			if (PlayState.instance.variables.exists(name)) {
				PlayState.instance.variables.remove(name);
				return true;
			}
			return false;
		});
		
		interp.variables.set('StringTools', StringTools);
		interp.variables.set('Reflect', Reflect);
		interp.variables.set('Math', Math);
		interp.variables.set('Type', Type);
		interp.variables.set('Std', Std);
	}

	public function call(name:String, args:Array<Dynamic>):Dynamic {
		if (interp.variables.exists(name)) {
			return Reflect.callMethod(this, interp.variables.get(name), args);
		}
		return false;
	}

	public function execute(codeToRun:String):Dynamic {
		var expr:Expr = parser.parseString(codeToRun);
		return interp.execute(expr);
	}
}
