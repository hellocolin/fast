import com.mixmedia.mx.events.ErrorEvent;

/**
 * @author Colin
 */
class com.mixmedia.mx.events.IOErrorEvent extends ErrorEvent{
	public static var IO_ERROR:String = "ioError";

	public function IOErrorEvent(currentTarget : Object, type:String,target:Object,text:String){
		super(currentTarget,type,target,text);
	}
}