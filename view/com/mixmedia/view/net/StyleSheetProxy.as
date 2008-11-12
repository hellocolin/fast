
/**
 * @author colin
 * singleton proxy
 * this is a proxy class to load external stylesheet (.css) file.
 * to use:
	SiteStyle.instance().when(SiteStyle.EVENT_COMPLETED, this, whenStyleLoaded);
	SiteStyle.instance().load();

 * if the css file not loaded, the complete event will dispatch until css file loaded.
 * if the css file loaded, the complete event will dispatch immediately.
 */
import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.LoadCSS;
import com.mixmedia.view.net.Loader;

import TextField.StyleSheet;

class com.mixmedia.view.net.StyleSheetProxy extends AbstractEventDispatcher{
	static private var ins:StyleSheetProxy;
	static public function instance():StyleSheetProxy{
		if(ins==null)ins = new StyleSheetProxy();
		return ins;
	}
	
	public static var EVENT_COMPLETED:String = "complete";

	private var isLoaded   :Boolean = false;
	private var isRequested:Boolean = false;

	private var base:Loader;
	private function StyleSheetProxy(){
		base = new Loader(new LoadCSS());
		base.when(LoaderEvent.COMPLETE, this, loaded);
	}
	
	private function loaded() : Void {
		dispatchEvent(new Event(currentTarget,StyleSheetProxy.EVENT_COMPLETED,this));
		isLoaded = true;
	}

	private function request(url:String):Void{
		if(isRequested==true)return;
		base.load(url);
		isRequested = true;
	}

	public function load(url:String):Void{
		url=(url==null)?'style.css':url;
		(isLoaded==true)?loaded():request(url);
	}

	public function getStyleSheet():StyleSheet{
		return StyleSheet(base.getTargetContainer());
	}

	public function clear():Void{
		getStyleSheet().clear();
		isLoaded = false;
	}
}
