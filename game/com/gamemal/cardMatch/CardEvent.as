import com.mixmedia.mx.events.Event;/** * @author colin */class com.gamemal.cardMatch.CardEvent extends Event {	public static var OPEN:String = 'open';	public static var CLOSE:String = 'close';	public function CardEvent(currentTarget : Object, type : String, target : Object) {		super(currentTarget, type, target);	}}