import mx.utils.Delegate;

import com.mixmedia.collection.List;
import com.mixmedia.flickr.Photo;
import com.mixmedia.flickr.events.PhotoEvent;
import com.mixmedia.motion.MotionTween;

import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.mx.view.BitmapText;
import com.mixmedia.net.LoadSWF;
import com.mixmedia.net.Loader;
import com.mixmedia.utils.MovieClipTools;
import com.mixmedia.view.ButtonClip;
import com.mixmedia.view.collection.IListCell;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author colin
 */
class ThumbPic extends MovieClip implements IListCell {
	public static var QUEUEID:Number;
	public static var IDENTIFIER:String = 'ThumbPic';
	
	private var model:Photo;
	private var list:List;
	private var txtUsername:BitmapText;
	private var txtVote:BitmapText;

	private var btn:ButtonClip;
	
	private var picLoader:Loader;
	private var fadein:MotionTween;
	private var index : Number;

	public function ThumbPic() {
		txtUsername = new BitmapText(this,this['username']);
		txtVote     = new BitmapText(this,this['vote']);
		
		var img:MovieClip = this.createEmptyMovieClip('img', 500);
		img.setMask(this['pic']);
		img._alpha=0;
		fadein = new MotionTween(img,{a:100});

		picLoader = new Loader(new LoadSWF(img), QUEUEID);
		picLoader.setPreloader(this);
		picLoader.setErrorIcon(this);
		picLoader.addEventListener(LoaderEvent.READY, Delegate.create(this,picLoaded));
	}

	private function onLoad():Void{
		btn.setCurrentTarget(this);
		btn.addEventListener(ButtonClipEvent.CLICK, Delegate.create(this, enlarge));	
	}
	
	private function displayPic(e:PhotoEvent) : Void {
		picLoader.load(Photo(e.currentTarget).thumbnail);
	}

	private function picLoaded(e:LoaderEvent) : Void {
		MovieClipTools.matchSize(e['targetContainer'], this['pic'], false);
		MovieClipTools.alignCenter(e['targetContainer'], this['pic']);
		fadein.startTween();
	}

	private function enlarge():Void{
		list.setValue(list.getItemIndex(model));
	}
	
	public function setModel(model : Object) : Void {
		this.model = Photo(model);
		this.model.addEventListener(PhotoEvent.IMAGE_URL_LOADED, Delegate.create(this,displayPic));
		this.model.getThumbnail();
		txtUsername.text = this.model.ownername;
		txtVote.text     = this.model.vote.toString() + ((this.model.vote>1)?" Votes":" Vote");
	}
	
	public function getRowHeight() : Number {
		return 136;
	}

	public function getColWidth() : Number {
		return 110;
	}
	
	public function addEventListener(event : String, handler : Function) : Void {
		btn.addEventListener(event, handler);
	}
	
	public function removeEventListener(event : String, handler : Function) : Void {
		btn.removeEventListener(event, handler);
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		btn.setCurrentTarget(currentTarget);
	}
	
	public function setList(list : List) : Void {
		this.list = list;
	}		public function getModel() : Object {
		return model;
	}
}
