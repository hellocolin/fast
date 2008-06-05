import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;

import com.mixmedia.utils.MovieClipTools;

/**
 * @author colin
 */
class BitmapText {
	private var txf:TextField;
	private var bmp:Bitmap;

	public function BitmapText(base:MovieClip){
		txf = MovieClipTools.findTextField(base);
		txf.autoSize = true;

		bmp = new Bitmap(base,new BitmapData(txf._width, txf._height+20,true,0),PixelSnapping.ALWAYS,false);
		bmp.bitmapData.draw(txf);
		txf._visible = false;
	}
}
