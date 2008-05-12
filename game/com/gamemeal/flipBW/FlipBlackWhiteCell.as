import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IEventDispatcher;

/**
 * @author colin
 */
class com.gamemeal.flipBW.FlipBlackWhiteCell extends AbstractEventDispatcher implements IEventDispatcher{
	private var _state:Boolean = false;

	public function FlipBlackWhiteCell(state:Boolean){
		_state = state;
	}
	
	public function swap():Void{
		_state = !_state;
		dispatchEvent(new Event(this,Event.CHANGE));
	}
	
	public function get state():Boolean{
		return _state;
	}
}