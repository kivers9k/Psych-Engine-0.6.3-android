package;

import Reflect;

#if hscript
import hscript.Parser;
import hscript.Interp;
import hscript.Expr;
#end

using StringTools;

class FunkinHx {
	public static var parser:Parser = new Parser();
	public var interp:Interp;
	public var variables(get, never):Map<String, Dynamic>;
	
	public function get_variables()
	{
		return interp.variables;
	}

	public function new(hscript:String) {
		var interp:Interp = new Interp();
		preset();
		
		var file:String = Paths.getTextFromFile(hscript);
		var hxString:String = '';
	
		for (splitStr in file.split('\n')) {
			if (!splitStr.startsWith('import ')) {
				hxString += splitStr + '\n';
			} else {
				var lib:String = splitStr.split(' ')[1].replace(';', '');
				var libName:String = lib.split('.')[lib.split('.').length - 1];
				
				if (Type.resolveClass(lib) != null) {
					variables.set(libName, Type.resolveClass(lib));
				} else {
					#if mobile
						SUtil.applicationAlert('Library not Found!', lib);
					#else
						FunkinLua.luaTrace('Library not Found: ' + lib, false, false, FlxColor.RED);
					#end
				}
			}
		}
		
		try {
			execute(hxString);
		} catch(error:Dynamic) {
			#if mobile
				SUtil.applicationAlert('Error on Hscript!', error);
			#else
				FunkinLua.luaTrace(scriptName + ":" + lastCalledFunction + " - " + e, false, false, FlxColor.RED);
			#end
		}
	}

	public function preset() {
		variables.set('game', PlayState.instance);
		
		variables.set('Math', Math);
		variables.set('Type', Type);
		variables.set('Std', Std);
		
		variables.set('add', PlayState.instance.add);
		variables.set('remove', PlayState.instance.remove);
		variables.set('insert', PlayState.instance.insert);
	}

	public function call(func:String, arg:Dynamic) {
		var getFunc:Dynamic = variables.get(name);
		if (getFunc != null)
			return Reflect.callMethod(null, getFunc, arg);
	}

	public function execute(codeToRun:String):Dynamic {
		@:privateAccess
		HScript.parser.line = 1;
		HScript.parser.allowTypes = true;
		return interp.execute(HScript.parser.parseString(codeToRun));
	}
}