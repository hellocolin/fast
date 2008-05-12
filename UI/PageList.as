import mx.utils.Delegate;

import com.mixmedia.collection.IList;
import com.mixmedia.collection.events.ListEvent;
import com.mixmedia.mx.TextFieldEvt;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.mx.events.TextEvent;
import com.mixmedia.view.collection.ListView;
import com.mixmedia.view.collection.RenderAsThumbnails;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author colin
 */
class PageList extends MovieClip implements IList, IEventDispatcher {
	private var base:ListView;
	private var listHolder:MovieClip;
	private var txfTotal:TextField;
	private var data:Array;
	private var btnNext:ButtonClip;
	private var btnPrev:ButtonClip;
	
	private var inputPage:TextFieldEvt;
	
	public function PageList() {
		listHolder = this.createEmptyMovieClip("listHolder", 1000);
		listHolder._y = 4;

		base = new ListView(new RenderAsThumbnails("",listHolder,1,100));
		base.setCurrentTarget(this);
	}
	
	public function onLoad():Void{
		inputPage = new TextFieldEvt(this['inpPageNumber']);
		inputPage.addEventListener(TextEvent.CHANGE, Delegate.create(this,changePage));

		btnNext.addEventListener(ButtonClipEvent.CLICK, Delegate.create(this,nextPage));
		btnPrev.addEventListener(ButtonClipEvent.CLICK, Delegate.create(this,prevPage));

		base.addEventListener(ListEvent.CHANGE, Delegate.create(this,updatePageNumber));
	}

	private var changePageIID:Number;
	private function changePage():Void{
		clearInterval(changePageIID);
		changePageIID = setInterval(Delegate.create(this,doChangePage),700);	
	}
	
	private function doChangePage():Void{
		clearInterval(changePageIID);

		if(isNaN(Number(inputPage.text))==true){
			inputPage.text = String((base.getValue()==null)?1:Number(base.getValue())+1);
			return;
		}
		base.setValue(Number(inputPage.text)-1);
	}

	private function updatePageNumber():Void{
		this['inpPageNumber'].text = String(Number(base.getValue())+1);
	}
	
	private function nextPage() : Void {
		var n:Number=(base.getValue()==null)?1:(Number(base.getValue())+1);
		base.setValue(n);
	}

	private function prevPage() : Void {
		var n:Number=(base.getValue()==null)?0:(Number(base.getValue())-1);
		base.setValue(n);
	}
	
	public function makePages(num:Number):Void{
		if(num==0) num = 1;
		txfTotal.text = String(num);
		data = new Array();
		for(var i:Number=0;i<num;i++){
			data[i]={label:i+1,value:i};
		}
		base.setData(data);
		listHolder._x = btnNext._x - listHolder._width;
//		btnPrev._x = listHolder._x -btnPrev._width;
		
		btnPrev._visible = (num>1);
		btnNext._visible = (num>1);
		listHolder._visible = (num>1);
	}

	public function setData(data : Array) : Void {
		base.setData(data);
	}
	
	public function getItemIndex(item : Object) : Number {
		return base.getItemIndex(item);
	}
	
	public function setValue(value : Number) : Void {
		base.setValue(value);
	}
	
	public function setIndex(value : Number) : Void {
		base.setIndex(value);
	}
	
	public function getIndex() : Number {
		return base.getIndex();
	}
	
	public function getMax() : Number {
		return base.getMax();
	}
	
	public function addEventListener(event : String, handler : Function) : Void {
		base.addEventListener(event, handler);
	}
	
	public function removeEventListener(event : String, handler : Function) : Void {
		base.removeEventListener(event, handler);
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		base.setCurrentTarget(currentTarget);
	}
}
