import com.mixmedia.mx.events.Event;
/** * @author colin */class com.gamemeal.cardMatch.CardMatchGameEvent extends Event {
	public static var MATCH:String = 'match';
	public static var NOTMATCH:String = 'notMatch';
		public function CardMatchGameEvent(currentTarget : Object, type : String, target : Object) {		super(currentTarget, type, target);	}
}