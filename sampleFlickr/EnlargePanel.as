
/** * @author colin */import com.mixmedia.mx.events.Event;

import flash.net.URLRequestMethod;

import mx.utils.Delegate;

import com.mixmedia.flickr.Photo;
import com.mixmedia.motion.MotionTween;
import com.mixmedia.mx.AbstractMovieClipEventDispatcher;
import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.net.LoadSWF;
import com.mixmedia.net.LoadVAR;
import com.mixmedia.net.Loader;
import com.mixmedia.view.ButtonClip;
import com.mixmedia.view.events.ButtonClipEvent;

import events.EnlargePanelEvent;

class EnlargePanel extends AbstractMovieClipEventDispatcher implements IEventDispatcher {
	public static var QUEUEID:Number;
	private var voteButton:ButtonClip;
	private var forwardButton:ButtonClip;
	private var mcPhoto:MovieClip;
	private var photoLoader:Loader;
	private var currentPhoto : Photo;
	private var fadein : MotionTween;
	private var fadeout : MotionTween;
	private var photoFadeIn:MotionTween;
	
	public function EnlargePanel(){
		mcPhoto = this.createEmptyMovieClip("mcPhoto", 100);
		photoLoader = new Loader(new LoadSWF(mcPhoto));
		photoLoader.setPreloader(mcPhoto);
		photoFadeIn = new MotionTween(MovieClip(photoLoader.getTargetContainer()));

		fadein = new MotionTween(this,{a:100});
		fadeout = new MotionTween(this,{a:0});
	}

	public function onLoad():Void {
		voteButton.addEventListener(ButtonClipEvent.CLICK, Delegate.create(this,vote));
		forwardButton.addEventListener(ButtonClipEvent.CLICK, Delegate.create(this,forward));	}
	
	public function showPhoto(photo:Photo):Void{
		if(currentPhoto!==photo){
			photoLoader.load(photo.large);
			MovieClip(photoLoader.getTargetContainer())._alpha=0;
		}
		currentPhoto = photo;
		fadein.startTween();
	}
	
	public function hide():Void{
		fadeout.startTween();
	}
	
	private function vote():Void{
		var resultLV:LoadVAR = new LoadVAR();
		var voteLV:LoadVars = new LoadVars();
		voteLV['photoid'] = currentPhoto.id;
		voteLV.sendAndLoad("vote.php",resultLV, URLRequestMethod.POST);
		resultLV.addEventListener(LoaderEvent.COMPLETE,Delegate.create(this,onVote));
	}
	
	private function onVote():Void{
		trace('voted');
	}
	
	private function forward():Void{
		dispatchEvent(new EnlargePanelEvent(this,EnlargePanelEvent.FORWARD,this,currentPhoto));
	}
}