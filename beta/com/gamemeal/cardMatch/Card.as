
/** * @author colin */
import com.gamemeal.cardMatch.CardEvent;
import com.mixmedia.mx.events.AbstractEventDispatcher;

class com.gamemeal.cardMatch.Card extends AbstractEventDispatcher{
	private var _isOpen:Boolean = false;
	public var id:String;
	
	public function Card(id:String){
		this.id = id;
	}

	public function open():Void{
		_isOpen = true;
		dispatchEvent(new CardEvent(this,CardEvent.OPEN));
	}
	
	public function close():Void{
		_isOpen = false;
		dispatchEvent(new CardEvent(this,CardEvent.CLOSE));
	}
	
	public function get isOpen():Boolean{
		return _isOpen;
	}
	public function toString():String{
		return '[object Card {id:'+id+'}]';
	}
}