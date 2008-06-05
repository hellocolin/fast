import com.mixmedia.view.events.ButtonClipEvent;
/**
 * @author colin
 */ 
class ButtonElementClip extends MovieClip implements IButtonElement {
	private var numOverFrame:Number=0;
	private var numOutFrame:Number=0;
	private var numDownFrame:Number=0;
	 
	public function ButtonElementClip() {
	}
	
	public function buttonOver(e : ButtonClipEvent) : Void {
		(e.highlight==true)?gotoAndPlay('highover'):gotoAndPlay('over');
	}
	
	public function buttonOut(e : ButtonClipEvent) : Void {
		(e.highlight==true)?gotoAndPlay('highout'):gotoAndPlay('out');
	}
	
	public function buttonDown(e : ButtonClipEvent) : Void {
	}
	
	public function buttonReset(e : ButtonClipEvent) : Void {
		(e.highlight==true)?gotoAndPlay('highnormal'):gotoAndPlay('normal');
	}
}
