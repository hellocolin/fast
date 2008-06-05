import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;

/**
 * @author colin
 */
class com.mixmedia.view.BitmapText {
	private var txf:TextField;
	private var bmp:Bitmap;

	public function BitmapText(base:MovieClip,txf:TextField){
		this.txf = txf;

		bmp = new Bitmap(base,new BitmapData(txf._width, txf._height+20,true,0),PixelSnapping.ALWAYS,false);
		bmp._x = txf._x;
		bmp._y = txf._y;
		update();
		txf._visible = false;
	}
	
	private function update():Void{
		bmp.bitmapData.fillRect(bmp.bitmapData.rectangle,0);
		bmp.bitmapData.draw(txf);
	}
	
	public function set text(str:String):Void{
		txf.text = str;
		update();
	}
}
