import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;

/**
 * @author colin
 */
class BitmapText {
	private var txf:TextField;
	private var bmp:Bitmap;

	public function BitmapText(base:MovieClip){
		txf = base['txf'];
		txf.autoSize = true;

		bmp = new Bitmap(base,new BitmapData(500,txf._height+20,true,0),PixelSnapping.ALWAYS,false);
		bmp.bitmapData.draw(txf);
		txf._visible = false;
		txf.text = "";
	}
}
