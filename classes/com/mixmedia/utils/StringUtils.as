
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
}
