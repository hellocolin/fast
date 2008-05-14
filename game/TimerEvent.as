import com.mixmedia.mx.events.Event;

/** * @author colin */class com.gamemal.TimerEvent extends Event {
	public static var CHANGE:String = 'change';
	public static var START:String  = 'start';
	public static var STOP:String   = 'stop';
	public static var TIMEUP:String = 'timeup';
		public function TimerEvent(currentTarget : Object, type : String, target : Object) {		super(currentTarget, type, target);	}
}