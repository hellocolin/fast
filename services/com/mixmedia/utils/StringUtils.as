
/**
 * @author colin
 */
class com.mixmedia.utils.StringUtils {
	public static function trim(str:String):String{
		while (str.charAt(0) == " ") {
			str = str.substring(1, str.length);
		}
		while (str.charAt(str.length-1) == " ") {
			str = str.substring(0, str.length-1);
		}
		return str;
	}

	public static function entityDecode(str:String):String{
		return String(str).split("&lt;").join("<").split("&gt;").join(">").split("&amp;").join("&").split("&quot;").join('"').split("&nbsp;").join(" ");
	}

	public static function replace(rawString:String,stringToFind:String,stringToReplace:String):String{
		return rawString.split(stringToFind).join(stringToReplace);
	}

}
