/** * @author colin */import mx.utils.Delegate;import com.mixmedia.collection.events.ListEvent;import com.mixmedia.view.collection.ListView;import com.mixmedia.view.collection.RenderAsThumbnails;class Main {	private var base:MovieClip;	private var list:ListView;	public function Main(base:MovieClip){		this.base = base;		setupMultiPageList();		setupCountryList();	}	private function setupCountryList():Void{			}		private function setupMultiPageList() : Void {		var items:Array = loop(320);		list = new ListView(new RenderAsThumbnails("cell",base,5,5));		list.setData(items);		base['btnPrev'].onRelease=Delegate.create(this,prev);		base['btnNext'].onRelease=Delegate.create(this,next);		var pageListMC:MovieClip = base.createEmptyMovieClip("pageListMC", 200);		pageListMC._y = 200;		var page: ListView = new ListView(new RenderAsThumbnails("PageCell",pageListMC,1,30));		page.setData(loop(list.getMax()));				page.addEventListener(ListEvent.CHANGE, Delegate.create(this, changePage));	}	private function changePage(e:ListEvent):Void {		list.setIndex(e.value);	}	private function prev():Void{		list.setIndex(list.getIndex()-1);	}		private function next():Void{		list.setIndex(list.getIndex()+1);	}		private function loop(n:Number):Array{		var ary:Array=[];		for(var i:Number=0;i<n;i++){			ary[i]=i;		}		return ary;	};}