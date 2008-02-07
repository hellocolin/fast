
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
}