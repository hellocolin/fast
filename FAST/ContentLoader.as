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
	private var targetName:String;

	public function ContentLoader(){
		loader = new Loader(new LoadSWF(this));
		loader.setPreloader(this);
		loader.setErrorIcon(this);
		loader.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,onLoadContentAndFadeIn));

		var para:Array = _name.split('$');
		targetName	= para[1]==null?"":para[1];
		prefix		= para[2]==null?"":para[2]; 

		motion = new MotionTween(MovieClip(loader.getTargetContainer()));

		var n:Navigation = Navigation.instance();
		n.addEventListener(NavigationEvent.CHANGE, Delegate.create(this,onNavChange));
	}

	private function onNavChange(e:NavigationEvent):Void{
		//if targetName is empty, load only 
		var navTargetIsEmpty:Boolean = (e.targetContainer==""||e.targetContainer==null);
 		var criteria1:Boolean = (targetName==""&&navTargetIsEmpty);
 		var criteria2:Boolean = (navTargetIsEmpty==false&&e.targetContainer==targetName);
		if(criteria1==false&&criteria2==false)return;

		currentNavKey = e.navKey;
		motion.startTween({a:0});
		motion.addEventListener(Event.TWEENEND, Delegate.create(this, onFadeOutAndLoad));
		return;
	}

	private function onFadeOutAndLoad(e:Event):Void {
		MotionTween(e.currentTarget).removeEventListener(Event.TWEENEND,arguments.caller);
		loadAction();
	}

	private function onLoadContentAndFadeIn():Void{
		motion.startTween({a:100});
	}

	private function loadAction():Void{
		loader.load(prefix+currentNavKey+".swf");	
	}
}
