import com.mixmedia.mx.events.MouseEvent;

/**
 * @author Colin
 */
class com.mixmedia.view.events.ButtonClipEvent extends MouseEvent {
	public static var RESET:String = 'reset';
	public var highlight:Boolean;

	public function ButtonClipEvent(currentTarget:Object, type:String, target:Object, highlight:Boolean) {
		super(currentTarget,type,target);
		this.highlight = highlight;
	}
}
