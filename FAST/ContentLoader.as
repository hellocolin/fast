import mx.utils.Delegate;

import com.mixmedia.motion.MotionTween;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.navigation.Navigation;
import com.mixmedia.navigation.events.NavigationEvent;
import com.mixmedia.net.LoadSWF;
import com.mixmedia.net.Loader;

/**
 * @author Colin
 */
class ContentLoader extends MovieClip {
	private var loader:Loader;
	private var prefix:String;
	private var currentNavKey:String;
	private var motion:MotionTween;

	public function ContentLoader(){
		loader = new Loader(new LoadSWF(this));
		loader.setPreloader(this);
		loader.setErrorIcon(this);
		loader.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,onLoadContentAndFadeIn));

		prefix = _name.split('$')[1];
		prefix = (prefix==null)?"":prefix;

		motion = new MotionTween(MovieClip(loader.getTargetContainer()));

		var n:Navigation = Navigation.instance();
		n.addEventListener(NavigationEvent.CHANGE, Delegate.create(this,onNavChange));
	}

	private function onNavChange(e:NavigationEvent):Void{
		currentNavKey = e.navKey;
		motion.startTween({a:0});
		motion.addEventListener(Event.TWEENEND, Delegate.create(this, onFadeOutAndLoad));
	}
	
	private function onFadeOutAndLoad(e:Event):Void {
		MotionTween(e.currentTarget).removeEventListener(Event.TWEENEND,arguments.caller);
		loader.load(prefix+currentNavKey+".swf");
	}

	private function onLoadContentAndFadeIn():Void{
		motion.startTween({a:100});
	}
}
