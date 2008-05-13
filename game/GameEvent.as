import com.mixmedia.mx.events.Event;

/** * @author colin */class GameEvent extends Event {
	public static var START:String = 'start';
	public static var WIN:String = 'win';
	public static var GAMEOVER:String = 'gameover';
	
	public function GameEvent(currentTarget : Object, type : String, target : Object) {		super(currentTarget, type, target);	}
}