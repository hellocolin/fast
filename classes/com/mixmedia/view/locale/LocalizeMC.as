import mx.utils.Delegate;

import com.mixmedia.locale.Language;
import com.mixmedia.mx.events.Event;
import com.mixmedia.view.locale.ILocaleClip;

/**
   @author Colin Leung
*/


class com.mixmedia.view.locale.LocalizeMC extends MovieClip implements ILocaleClip{
	private var lang:Language;
	
	public function LocalizeMC(){
		lang = Language.instance();
		lang.addEventListener(Event.CHANGE, Delegate.create(this,onLangChange));
	}

	private function onLangChange():Void{
		this.gotoAndStop(lang.lang);
	}
}