import mx.utils.Delegate;

import com.mixmedia.collection.List;
import com.mixmedia.flickr.FlickrRest;
import com.mixmedia.flickr.Photo;
import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.LoadXML;
import com.mixmedia.net.Loader;

/**
 * @author colin
 */
class LocalGroupPhotoRequest extends AbstractEventDispatcher implements IGroupPhotoRequest{
	private var request : Loader;
	private var base:MovieClip;
	private var list : List;
	private var photos:Array;

	public function LocalGroupPhotoRequest(base:MovieClip,list:List){
		this.base = base;
		this.list = list;
	}
	
	public function loadPhotos(action:String):Void{
		if(action==null)action='get_home';
		request = new Loader(new LoadXML());
		request.setPreloader(base['mcPhotoPanel']);
		request.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,onPhotoInfo));
		request.load(Main.SERVER+'webservice/flickr.php?action='+action);
	}

	private function onPhotoInfo(e:LoaderEvent):Void{
		var xData:XML = FlickrRest.resultToXML(e.target.toString());
		photos = new Array();
		var photosNode:XMLNode = xData.firstChild.childNodes[0];
		for(var i:Number=0;i<photosNode.childNodes.length;i++){
			var p:Photo = Photo.make(photosNode.childNodes[i].attributes.id);
			p.vote = Number(photosNode.childNodes[i].attributes.vote);
			p.ownername = photosNode.childNodes[i].attributes.ownername;
			p.thumbnail = photosNode.childNodes[i].attributes.source;
			p.getThumbnail();
			photos.push(p);
		}
		//make the thumbnail panel
		list.setData(photos);
		dispatchEvent(new LoaderEvent(this,LoaderEvent.COMPLETE, e.target));
	}
	
	public function getResultPhotos() : Array {
		return photos;
	}
}
