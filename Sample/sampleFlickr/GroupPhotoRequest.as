import mx.utils.Delegate;

import com.mixmedia.collection.List;
import com.mixmedia.flickr.FlickrRest;
import com.mixmedia.flickr.Photo;
import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;

/**
 * @author colin
 */
class GroupPhotoRequest extends AbstractEventDispatcher implements IGroupPhotoRequest{
	private var base:MovieClip;
	private var list : List;
	private var photos:Array;

	public function GroupPhotoRequest(base:MovieClip,list:List){
		this.base = base;
		this.list = list;
	}
	
	public function loadPhotos(action:String):Void{
		var r:FlickrRest = new FlickrRest();
		r.setPreloader(base['mcPhotoPanel']);
		r.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,onPhotoInfo));
		r.method = 'flickr.groups.pools.getPhotos';
		r.args['group_id'] = Main.GROUPID;
		r.send();
		action;
	}

	private function onPhotoInfo(e:LoaderEvent):Void{
		photos = new Array();
		var xData:XML = FlickrRest.resultToXML(FlickrRest(e.currentTarget).data);

		var photosNode:XMLNode = xData.firstChild.childNodes[0];
		for(var i:Number=0;i<photosNode.childNodes.length;i++){
			var p:Photo = Photo.make(photosNode.childNodes[i].attributes.id);
			p.ownername = photosNode.childNodes[i].attributes.ownername;
			photos.push(p);
		}
		//make the thumbnail panel
		list.setData(photos);
		dispatchEvent(new LoaderEvent(this, LoaderEvent.COMPLETE, e.currentTarget));
	}
	
	public function getResultPhotos() : Array {
		return photos;
	}
}
