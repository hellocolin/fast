import mx.utils.Delegate;

import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author colin
 */
class ScrollBar extends MovieClip{
	private var target : IScrollable;
	private var btnUp:  RepeatClick;
	private var btnDown:RepeatClick;
	private var thumbBG:MovieClip;
	private var mcThumb:ButtonClip;
	private var thumbDist:Number;
	private var steps:Number;
	private var thumbIsDown:Boolean = false;

	private function onLoad():Void{
		btnUp   = new RepeatClick(ButtonClip(this['b$up']));
		btnDown = new RepeatClick(ButtonClip(this['b$down']));

		btnUp.addEventListener(  ButtonClipEvent.MOUSE_DOWN, Delegate.create(this,up));
		btnDown.addEventListener(ButtonClipEvent.MOUSE_DOWN, Delegate.create(this,down));

		thumbBG = this['mcScrollbarThumbBg'];
		mcThumb.addEventListener(MouseEvent.MOUSE_DOWN, Delegate.create(this,thumbDown));
		mcThumb.addEventListener(MouseEvent.MOUSE_UP  , Delegate.create(this,thumbUp));
		
		thumbDist = thumbBG._height-mcThumb._height;
	}

	private function onEnterFrame():Void{
		if(thumbIsDown!=true)return;
		target.setIndex(Math.round((mcThumb._y - thumbBG._y)/thumbDist*target.getMax()));
	}

	private function thumbDown() : Void {
		thumbIsDown = true;
		mcThumb.startDrag(true, mcThumb._x, thumbBG._y, mcThumb._x, thumbBG._y+thumbDist);
	}

	private function thumbUp():Void{
		thumbIsDown = false;
		mcThumb.stopDrag();
		updateButtons();
	}

	public function setTarget(target:IScrollable) : Void {
		this.target = target;
		updateButtons();
	}

	private function up():Void{
		target.setIndex(target.getIndex()-1);
		updateButtons();
	}

	private function down():Void{
		target.setIndex(target.getIndex()+1);
		updateButtons();
	}

	private function updateButtons():Void{
		ButtonClip(this['b$up'])._alpha   = (target.getIndex()<=0)?20:100;
		ButtonClip(this['b$down'])._alpha = (target.getIndex()>=target.getMax())?20:100;
		mcThumb._y = Math.round(thumbBG._y + (target.getIndex()/target.getMax()*thumbDist));	
	}
}