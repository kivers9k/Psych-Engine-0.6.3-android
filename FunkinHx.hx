package;

#if hscript
import hscript.Parser;
import hscript.Interp;
import hscript.Expr;
#end

import flixel.util.FlxColor;
import Reflect;

using StringTools;

class FunkinHx {
	public static var parser:Parser = new Parser();
	public var interp:Interp = new Interp();

	public function new(hscript:String) {
		var file:String = Paths.getTextFromFile(hscript);
		var lines:String = '';
	
		for (splitStr in file.split('\n')) {
			if (!splitStr.startsWith('import ')) {
				lines += splitStr + '\n';
			} else {
				var lib:String = splitStr.split(' ')[1].replace(';', '');
				var libName:String = lib.split('.')[lib.split('.').length - 1];
				
				if (Type.resolveClass(lib) != null) {
					interp.variables.set(libName, Type.resolveClass(lib));
				} else {
					#if mobile
						SUtil.applicationAlert('Library not Found!', lib);
					#else
						FunkinLua.luaTrace('Library not Found: ' + lib, false, false, FlxColor.RED);
					#end
				}
			}
		}
		preset();
		
		try {
			execute(lines);
		} catch(error:Dynamic) {
			#if mobile
				SUtil.applicationAlert('Error on Hscript!', error);
			#else
				FunkinLua.luaTrace('Error on Hscript: ' + error, false, false, FlxColor.RED);
			#end
		}
	}

	public function preset() {
		interp.variables.set('Paths', Paths);
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
			if (PlayState.instance.variables.exist(name)) {
				result = PlayState.instance.variables.get(name);
			}
			return result;
		});
		interp.variables.set('removeVar', function(name:String) {
			if (PlayState.instance.variables.exist(name))
				PlayState.instance.variables.remove(name);
				return true;
			}
			return false;
		});
		interp.variables.set('Math', Math);
		interp.variables.set('Map', Map);
		interp.variables.set('Type', Type);
		interp.variables.set('Std', Std);
	}

	public function call(func:String, arg:Dynamic) {
		var getFunc:Dynamic = interp.variables.get(name);
		if (getFunc != null)
			return Reflect.callMethod(null, getFunc, arg);
	}

	public function execute(codeToRun:String):Dynamic {
		@:privateAccess
		FunkinHx.parser.line = 1;
		FunkinHx.parser.allowTypes = true;
		return interp.execute(FunkinHx.parser.parseString(codeToRun));
	}
}