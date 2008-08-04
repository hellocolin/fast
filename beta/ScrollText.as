
/**
 * @author colin
 */
import com.mixmedia.mx.TextFieldEvt;
import com.mixmedia.view.BitmapText;

class ScrollText implements IScrollable {
	private var txtAsBmp:BitmapText;
	private var base:TextFieldEvt;
	private var max:Number;
	public function ScrollText(base:TextFieldEvt){
		this.base = base;
		for(var i:Number=1;i<3;i++){
			base.htmlText+="<br/>";
		}
		base.scroll = 1;
		max = base.maxscroll-1;
		txtAsBmp = new BitmapText(base._parent,base.toTextField());
		base.toTextField()._visible = false;
	}
	public function setIndex(value : Number) : Void {
		base.scroll = limit(value,0,max)+1;
		txtAsBmp.update();
	}

	public function getIndex() : Number {
		return base.scroll-1;
	}

	public function getMax() : Number {
		return max;
	}

	public function toString():String{
		return '[object ScrollText]';
	}

	private function limit(currentValue:Number,minValue:Number,maxValue:Number):Number{
		return Math.max(Math.min(currentValue,maxValue),minValue);
	}
}