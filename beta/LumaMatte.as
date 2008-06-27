/**
 * @author colin
 */
//LumaMatt -rw source:BitmapData +r po:Point;
//generate by scaffold

import flash.display.BitmapData;
import flash.geom.Point;

class LumaMatte{
	private static var po:Point = new Point(0,0);
	private var alphaChannel:BitmapData;

	public function LumaMatte(source:BitmapData){
		alphaChannel = new BitmapData(source.width,source.height,true,0x00FFFFFF);
		alphaChannel.copyChannel(source, source.rectangle, po, 1, 8);
	}

	public function addToMovieClip(mc:MovieClip):Void{
		mc.attachBitmap(alphaChannel, 1,"AUTO",true);
	}
}