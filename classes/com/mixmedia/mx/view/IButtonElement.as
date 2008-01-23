import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author Colin
 */
interface com.mixmedia.mx.view.IButtonElement {
	function buttonOver(e:ButtonClipEvent):Void;
	function buttonOut(e:ButtonClipEvent):Void;
	function buttonDown(e:ButtonClipEvent):Void;
	function buttonReset(e:ButtonClipEvent):Void;
}
