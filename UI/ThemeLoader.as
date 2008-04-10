import com.mixmedia.motion.MotionTween;
import com.mixmedia.mx.events.Event;
import com.mixmedia.navigation.events.NavigationEvent;
import com.mixmedia.net.Loader;

/**
 * @author Colin
 */
class ThemeLoader extends Content {
	private var loader:Loader;
	private var prefix:String;
	private var currentNavKey:String;
	private var motion:MotionTween;

	public function ThemeLoader(){
	}

	private function onNavChange(e:NavigationEvent):Void{
		var currentRootKey:String = currentNavKey.split("_")[0];
		if(e.navKey.split("_")[0]==currentRootKey)return;

		super.onNavChange(e);
	}
	
	private function onFadeOutAndLoad(e:Event):Void {
		MotionTween(e.currentTarget).removeEventListener(Event.TWEENEND,arguments.caller);
		loader.load(prefix+currentNavKey.split("_")[0]+".swf");
	}
}