import flash.display.BitmapData;
import flash.display.PixelSnapping;

/**
 * @author colin
 */
class flash.display.Bitmap {
	static private var count:Number = 0;
	
	private var parent:MovieClip;
	private var base:MovieClip;
	
	private var _bitmapData:BitmapData;
	private var _pixelSnapping: String;
	private var _smoothing : Boolean;
	
	public function Bitmap(mc:MovieClip, bitmapData:BitmapData, pixelSnapping:String, smoothing:Boolean){
		this._bitmapData	= (bitmapData==null)	? null				:bitmapData;
		this._pixelSnapping	= (pixelSnapping==null)	? PixelSnapping.AUTO:pixelSnapping;
		this._smoothing		= (smoothing==null)		? false				:smoothing;
		parent = mc;

		count++;
		base = mc.createEmptyMovieClip("wrapper"+count, count);
		base.attachBitmap(_bitmapData, 1, pixelSnapping,_smoothing);
	}

	public function get bitmapData():BitmapData{
		return _bitmapData;
	}

	public function set bitmapData(bitmapData:BitmapData):Void{
		_bitmapData = bitmapData;
		base.attachBitmap(_bitmapData, 1, _pixelSnapping,_smoothing);
	}
	
	public function get pixelSnapping():String{
		return _pixelSnapping;
	}

	public function set pixelSnapping(pixelSnapping:String):Void{
		_pixelSnapping = pixelSnapping;
		base.attachBitmap(_bitmapData, 1, _pixelSnapping,_smoothing);
	}

	public function get smoothing():Boolean{
		return _smoothing;
	}

	public function set smoothing(smoothing:Boolean):Void{
		_smoothing = smoothing;
		base.attachBitmap(_bitmapData, 1, _pixelSnapping,_smoothing);
	}

	public function get _x():Number{
		return base._x;
	}
	
	public function set _x(x:Number):Void{
		base._x = x;
	}
	
	public function get _y():Number{
		return base._y;
	}
	
	public function set _y(y:Number):Void{
		base._y = y;
	}

	public function set _xscale(scale:Number):Void{
		base._xscale = scale;
	}

	public function get _xscale():Number{
		return base._xscale;
	}

	public function set _yscale(scale:Number):Void{
		base._yscale = scale;
	}

	public function get _yscale():Number{
		return base._yscale;
	}

	public function get _rotation():Number{
		return base._rotation;
	}

	public function set _rotation(rotation:Number):Void{
		base._rotation = rotation;
	}

	public function get _alpha():Number{
		return base._alpha;
	}
	
	public function set _alpha(alpha:Number):Void{
		base._alpha = alpha;
	}

	public function set blendMode(blendMode:Object):Void{
		base.blendMode = blendMode;
	}

	public function get blendMode():Object{
		return base.blendMode;
	}

	public function toMovieClip():MovieClip{
		return base;
	}

	public function getBounds(bounds : Object) : Object{
		return base.getBounds(bounds);
	}
}
