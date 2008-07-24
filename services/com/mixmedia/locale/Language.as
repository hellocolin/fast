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

	public static var LANG_EN:Array = ["en","eng"];
	public static var LANG_CN:Array = ["zh-CN","schi"];
	
	private var currentLang:Array = LANG_EN;
	
	private function Language() {}
	
	public function set lang(strLang:Array):Void{
		currentLang = strLang[0];
		dispatchEvent(new Event(currentTarget,Event.CHANGE,this));
	}

	public function get lang():String{
		return currentLang[0];
	}
	
	public function get id():String{
		return currentLang[1];
	}
}
