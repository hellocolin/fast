﻿import com.mixmedia.mx.view.ButtonEvt;

 * @author Colin
 */
class ButtonClip extends MovieClip implements IButtonClip ,IFASTEventDispatcher{
	private var hitArea:Button;
	private var base:ButtonEvt;
	
	public function ButtonClip() {
		if(this[hitArea]==null)hitArea = MovieClipTools.findButton(this);
		base = new ButtonEvt(hitArea);
		base.setCurrentTarget(this);
	}

	public function addElement(element : IButtonElement) : Void {
		base.addElement(element);
	}

	public function addEventListener(event : String, handler : Function) : Void {
		base.addEventListener(event, handler);
	}

	public function removeEventListener(event : String, handler : Function) : Void {
		base.removeEventListener(event, handler);
	}

	public function setCurrentTarget(currentTarget : Object) : Void {
		base.setCurrentTarget(currentTarget);
	}

	public function select() : Void {
		base.select();
	}
}