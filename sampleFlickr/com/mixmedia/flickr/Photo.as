import mx.utils.Delegate;

import com.mixmedia.flickr.FlickrRest;
import com.mixmedia.flickr.events.PhotoEvent;
import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.LoaderEvent;

/**
 * @author colin
 */
class com.mixmedia.flickr.Photo extends AbstractEventDispatcher{
	private static var dict : Object = {};
	public static function make(id:String,vote:Number):Photo{
		if(dict[id] == null){
			dict[id] = new Photo(id,vote);
		}
		return dict[id];
	}

	public var id:String;
	public var ownername:String;
	public var title:String;
	
	public var square:String;
	public var thumbnail:String;
	public var small:String;
	public var medium:String;
	public var large:String;
	public var vote:Number=0;

	private var request : FlickrRest;

	public function Photo(id:String){
		this.id = id;
	}

	public function getThumbnail():Void{
		if(thumbnail!=null){
			dispatchEvent(new PhotoEvent(this,PhotoEvent.IMAGE_URL_LOADED));
			return;
		}
		doRequest();
	}
	
	public function toString():String{
		return "Photo {id:"+id+"}";
	}
	
	private function doRequest():Void{
		request = new FlickrRest();
		request.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,srcReady));
		request.method = 'flickr.photos.getSizes';
		request.args['photo_id'] = id;

		if(Main.TOKEN!="")request.args['auth_token'] = Main.TOKEN; 
		request.send((Main.TOKEN!=""));
	}
	
	private function srcReady(e:LoaderEvent):Void{
		var xData:XML = FlickrRest.resultToXML(FlickrRest(e.currentTarget).data);
		var photoNodes:Array = xData.firstChild.firstChild.childNodes;

		for(var i:Number=0;i<photoNodes.length;i++){
			this[photoNodes[i].attributes.label.toLowerCase()] = photoNodes[i].attributes.source;
		}
		dispatchEvent(new PhotoEvent(this,PhotoEvent.IMAGE_URL_LOADED));
	}
}
