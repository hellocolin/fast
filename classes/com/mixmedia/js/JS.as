/**
 * @author Colin
 */
class com.mixmedia.js.JS {
	public static var enableExternalConnect:Boolean=true;
	
	public static function call(method:String):String{
		var path:String ='javascript:'+method+"("+argumentsToString(arguments)+");";
		var func:Function = (enableExternalConnect==true)?getURL:trace;
		func(path);
		return path;
	}

	public static function listen(scope:Object,str:String,fnt:Function,userData:Object):Void{
		scope.watch(str,fnt,userData);
	}

	private static function argumentsToString(arg:Array):String{
		var strParameter:String = "";
		for(var i:Number=1;i<arg.length;i++){
			if(typeof(arg[i])=='number'){
				strParameter+=arg[i];
			}else{
				strParameter+="\""+String(arg[i])+"\"";
			}
			if(i<arg.length-1)strParameter+=",";
		}
		return strParameter;
	}
}