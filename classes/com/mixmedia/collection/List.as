import com.mixmedia.collection.IList;
import com.mixmedia.collection.events.ListEvent;
import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.view.IInput;
/**
 * @author colin
 */
class com.mixmedia.collection.List extends AbstractEventDispatcher implements IList, IInput, IEventDispatcher{
	private var _value:Number;
	private var index:Number=0;
	private var items:Array;
	public var itemsCountPerPage : Number=1;

	public function List(){
		items = new Array();
	}
	
	public function setData(data:Array):Void{
		items = data;
		dispatchEvent(new ListEvent(currentTarget,ListEvent.UPDATE, this, null,items));
	}

	public function setValue(value:Number):Void{		_value = value;
		if(_value>items.length-1)_value = items.length-1;
		if(_value<0)_value=0;
		index = 0;
		dispatchEvent(new ListEvent(currentTarget,ListEvent.CHANGE,this,_value,items[_value]));
	}

	public function getValue() : Object {
		return _value;
	}
	
	public function setIndex(value : Number) : Void {
		var maxPage:Number = getMax();
		if(value>=maxPage-1)value=maxPage-1;
		if(value<0)value=0;
		index = value;
		
		dispatchEvent(new ListEvent(currentTarget,ListEvent.CHANGEPAGE,this,_value,items[_value]));
	}
	
	public function getIndex() : Number {
		return index;
	}
	
	public function getMax() : Number {
		return Math.ceil(items.length / itemsCountPerPage);
	}		public function getItemIndex(item : Object) : Number {		for(var i:Number = 0;i<items.length;i++){			if(items[i]===item)return i;		}		return -1;	}
}
