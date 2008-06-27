
/**
 * @author colin
 */
import com.mixmedia.mx.events.AbstractEventDispatcher;

class Boxer extends AbstractEventDispatcher{
	public static var TOP:String = 'TOP';
	public static var MID:String = 'MID';
	public static var BOTTOM:String = 'BOTTOM';

	private var nowGuard:String;

	public function Boxer(){
	}

	public function shot(position:String):Void{
		nowGuard = null;
		dispatchEvent(new BoxerEvent(currentTarget,BoxerEvent.ATTACK,this,position));
	}
	
	public function guard(position:String):Void{
		nowGuard = position;
		dispatchEvent(new BoxerEvent(currentTarget,BoxerEvent.GUARD, this,position));
	}

	public function hit(position:String):Void{
		dispatchEvent(new BoxerEvent(currentTarget,(nowGuard==position)?BoxerEvent.MISSED:BoxerEvent.HIT,this,position));
	}
}
