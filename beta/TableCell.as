
/**
 * @author colin
 */
class TableCell {
	public var w:Number;
	public var h:Number;
	public var ctx:Object;
	
	public function TableCell(w:Number,h:Number,content:Object){
		this.w = w;
		this.h = h;
		this.ctx = content;
	}
	
	public function toString():String{
		return '[object TableCell] w:'+w+' h:'+h+' content:'+ctx;
	}
}
