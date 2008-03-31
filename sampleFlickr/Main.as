
/** * @author colin */import mx.utils.Delegate;

import com.mixmedia.collection.List;
import com.mixmedia.collection.events.ListEvent;
import com.mixmedia.flickr.Photo;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.view.collection.IListCellRenderArrangement;
import com.mixmedia.view.collection.ListView;
import com.mixmedia.view.collection.RenderAsThumbnails;

class Main {	public static var API_KEY  : String = '6fbf261cfc4445d58178e674167de32f';
	public static var GROUPID  : String = '711805@N23';
	public static var SECRETKEY: String = 'b6c77edef7a6f8ab';
	public static var TOKEN : String = "";
	public static var SERVER   : String = 'http://demo.mixmedia.com/yahoo/lg/web/';
	
	private var base:MovieClip;
	private var photoListView : ListView;

	public function Main(base:MovieClip){
		ThumbPic.QUEUEID= 75;
		Photo.QUEUEID = 75;

		this.base = base;
		
		var renderMethod:IListCellRenderArrangement = new RenderAsThumbnails(ThumbPic.IDENTIFIER, base['mcPhotoPanel'],4,3);
		var photoList:List = new List();
		photoListView = new ListView(renderMethod,photoList);
		photoListView.addEventListener(ListEvent.CHANGE, Delegate.create(this,thumbClick));
		
		var r:IGroupPhotoRequest = new GroupPhotoRequest(base,photoList);
		r.loadPhotos('get_home');
		r.addEventListener(LoaderEvent.COMPLETE,Delegate.create(this, loaded));
	}
	
	private function loaded(e:LoaderEvent):Void{
		trace(IGroupPhotoRequest(e.currentTarget).getResultPhotos());
	}
	
	private function thumbClick(e:ListEvent):Void{
		trace(e.item);
	}}