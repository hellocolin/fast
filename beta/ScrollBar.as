import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author colin
 */
class ScrollBar extends MovieClip{
	private var target : IScrollable;
	private var btnUp:  ButtonClip;
	private var btnDown:ButtonClip;
	private var thumbBG:MovieClip;
	private var mcThumb:ButtonClip;
	private var thumbDist:Number;
	private var steps:Number;
	private var thumbIsDown:Boolean = false;

	private function onLoad():Void{
		btnUp   = ButtonClip(this['b$up']);
		btnDown = ButtonClip(this['b$down']);
		btnUp.repeatPerFrame = 3;
		btnDown.repeatPerFrame = 3;

		btnUp.when(  ButtonClipEvent.MOUSE_DOWN, this,up);
		btnDown.when(ButtonClipEvent.MOUSE_DOWN, this,down);

		thumbBG = this['mcScrollbarThumbBg'];
		mcThumb.when(MouseEvent.MOUSE_DOWN, this,thumbDown);
		mcThumb.when(MouseEvent.MOUSE_UP  , this,thumbUp);
		
		thumbDist = thumbBG._height-mcThumb._height;
		updateButtons();
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
		target.updateMaxValue();
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
		mcThumb._visible = (target.getMax()>0)?true:false;
		mcThumb._y = Math.round(thumbBG._y + (target.getIndex()/target.getMax()*thumbDist));	
	}
}