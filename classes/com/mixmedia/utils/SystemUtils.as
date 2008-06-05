
/**
 * @author Colin
 */
class com.mixmedia.utils.SystemUtils {
	public static function isPlayerHigherThanRequirement(targetVersion:String):Boolean{
		var currVersion:String = System.capabilities.version;
		var currVersionArray:Array = currVersion.split(" ");
		var currVersionNumber:String = currVersionArray[currVersionArray.length-1];
		currVersionArray = currVersionNumber.split(",");
		
		var targetVersionArray:Array = targetVersion.split(",");
		for(var i:Number=0;i<currVersionArray.length;i++){
			if(Number(currVersionArray[i])<Number(targetVersionArray[i]))return false;
			if(Number(currVersionArray[i])>Number(targetVersionArray[i]))return true;
		}
		return true;
	}
	
	public static function getMovieURLPath(mc:MovieClip):String{
		var pathArray:Array = mc._url.split("/");
		pathArray.pop();

		return (pathArray.length==0)?"":(pathArray.join("/")+"/");
	}
	
	public static function getMovieFileName(mc:MovieClip,withExtension:Boolean):String{
		withExtension = (withExtension==null)?true:false;
		
		var pathArray:Array = mc._url.split("/");
		var fileName:String = unescape(pathArray.pop().toString());
		return (withExtension)?fileName:fileName.split(".swf")[0];
	}
}