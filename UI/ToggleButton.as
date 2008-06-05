import mx.utils.Delegate;

import com.mixmedia.mx.AbstractMovieClipEventDispatcher;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.utils.MovieClipTools;
import com.mixmedia.view.ButtonEvt;

/**
 * @author Colin
 */
class ToggleButton extends AbstractMovieClipEventDispatcher{
	private var _isEnable:Boolean;
	private var mcOnIcon:MovieClip;
	private var mcOffIcon:MovieClip;

	private var hitArea:Button;
	private var base:ButtonEvt;

	public function ToggleButton() {
		if(this[hitArea]==null)hitArea = MovieClipTools.findButton(this);
		base = new ButtonEvt(hitArea);
		base.setCurrentTarget(this);

		isEnable = true;

		base.addEventListener(MouseEvent.CLICK, Delegate.create(this,toggleEnable));
		base.addEventListener(MouseEvent.MOUSE_OVER, Delegate.create(this,over));
		base.addEventListener(MouseEvent.MOUSE_OUT, Delegate.create(this,out));
	}
	
	private function onLoad():Void{
		syncIcon();	
	}

	private function toggleEnable():Void{
		isEnable = !isEnable;
	}

	public function set isEnable(bln:Boolean):Void{
		if(_isEnable!=bln)dispatchEvent(new Event(this, Event.CHANGE));

		_isEnable = bln;
		syncIcon();
	}

	public function get isEnable():Boolean{
		return _isEnable;
	}

	private function syncIcon():Void{
		mcOnIcon._visible = isEnable;
		mcOffIcon._visible = !isEnable;
	}
	
	private function over():Void{
		dispatchEvent(new MouseEvent(this,MouseEvent.MOUSE_OVER));
	}

	private function out():Void{
		dispatchEvent(new MouseEvent(this,MouseEvent.MOUSE_OUT));
	}
}