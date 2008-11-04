
/**
 * @author colin
 */
class ScrollPane extends MovieClip implements IScrollable {
	private var translateY:Number;
	private var mcMask:MovieClip;
	private var index:Number = 0;
	private var marginBottom:Number = 10;
	private var stepDistance:Number = 10;
	private var _max:Number;
	
	public function ScrollPane(){
		this.setMask(mcMask);
		translateY = _y;
		updateMaxValue();
	}
	
	public function setIndex(value : Number) : Void {
		index = limit(value,0,getMax());
 
		_y = -(index*stepDistance)+translateY;
		mcMask._y = (index*stepDistance);
	}
	
	public function getIndex() : Number {
		return index;
	}
	
	public function getMax() : Number {
		return _max;
	}
	
	private function limit(currentValue:Number,minValue:Number,maxValue:Number):Number{
		return Math.max(Math.min(currentValue,maxValue),minValue);
	}
	
	public function updateMaxValue() : Void {
		_max = (_height- mcMask._height+marginBottom)/stepDistance;
	}
}
