
/**
 * @author colin
 */
import flash.display.BitmapData;
import flash.geom.Point;

class Buffer32 {
	private var position:Number = 0;
	private var buf:BitmapData;
	private var blank:BitmapData;
	private var temp:BitmapData;
	private var pt:Point;

	public function Buffer32(){
		pt = new Point();
		buf = new BitmapData(320,320,true,0x00000000);
		blank = new BitmapData(32,32,true,0x00000000);
	}

	public function addToBuffer(displayObject:Object):Void{
		temp = blank.clone();
		temp.draw(displayObject);
		buf.copyPixels(temp, temp.rectangle, pt);
		pt.x = (position&7)<<5;
		pt.y = (position>>3)<<5;
		position++;
	}
	
	public function toBitmapData():BitmapData{
		return buf;
	}
}
