import mx.utils.Delegate;

import com.mixmedia.locale.Language;
import com.mixmedia.mx.AbstractMovieClipEventDispatcher;
import com.mixmedia.mx.events.Event;

/**
   @author Colin Leung
*/

class com.mixmedia.view.locale.LocalizeMC extends AbstractMovieClipEventDispatcher implements ILocaleClip{
	private var lang:Language;
	
	public function LocalizeMC(){
		lang = Language.instance();
		lang.addEventListener(Event.CHANGE, Delegate.create(this,onLangChange));
	}
	
	private function onLoad():Void{
		this.gotoAndPlay(lang.lang);
	}

	private function onLangChange():Void{
		this.gotoAndStop(lang.lang);
	}
}