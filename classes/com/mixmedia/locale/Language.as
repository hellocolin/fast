import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;

/**
 * @author colin
 */
class com.mixmedia.locale.Language extends AbstractEventDispatcher {
	static private var ins:Language;
	static public function instance():Language{
		if(ins==null)ins = new Language();
		return ins;
	}

	public static var LANG_EN:String = "en";
	public static var LANG_CN:String = "zh-CN";
	
	private var currentLang:String = LANG_EN;
	
	private function Language() {}
	
	public function set lang(strLang:String):Void{
		currentLang = strLang;
		dispatchEvent(new Event(currentTarget,Event.CHANGE,this));
	}

	public function get lang():String{
		return currentLang;
	}
}
