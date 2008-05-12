import flash.display.BitmapData;
import flash.filters.DisplacementMapFilter;
import flash.geom.Matrix;
import flash.geom.Point;

/**
 * @author colin
 */
class RippleFilter {
	private static var halfMatrix:Matrix= new Matrix(0.5,0,0,0.5,0,0);
	private static var doubleMatrix:Matrix= new Matrix(2,0,0,2,0,0);
	private static var pto:Point = new Point();
	private var dots:BitmapData;
	private var blank:BitmapData;
	private var _pool:BitmapData;
	private var _texture:BitmapData;
	private var _source:BitmapData;
	public var value:Number=0;

	public function RippleFilter(w:Number,h:Number){
		dots    = new BitmapData(w,h,false,0xFFFFFF);
		blank = dots.clone();
		_source = dots.clone();
		_pool = dots.clone();

		var m:MovieClip = _root.createEmptyMovieClip('buffer', 34110);
		var pattern:BitmapData = new BitmapData(2,2,false,0xFFFFFF);
		pattern.setPixel(0, 0, 0);
		m.beginBitmapFill(pattern);
		m.lineTo(w,0);
		m.lineTo(w,h);
		m.lineTo(0,h);
		m.endFill();
		dots.draw(m);
		m.removeMovieClip();
	}

	public function set source(bmp:Object):Void{
		_source = blank.clone();
		_source.draw(bmp);
	}

	public function set texture(bmp:Object):Void{
		_texture = blank.clone();
		_texture.draw(bmp);
	}

	public function apply():BitmapData{
		var b:BitmapData = blank.clone();
		b.applyFilter(dots, _pool.rectangle, pto, new DisplacementMapFilter(_source,pto,1,1,value,value));
		_pool.draw(b,halfMatrix,null,null,null,true);
		b = blank.clone();
		b.draw(_pool, doubleMatrix, null, null, null, true);
		_pool = b.clone();
		_pool.draw(b, new Matrix(), null, 'multiply');

		if(_texture == null)return _pool;

		b = _texture.clone();
		b.applyFilter(_texture, _texture.rectangle, pto, new DisplacementMapFilter(_pool,pto,1,1,20,20));
		return b;
	}
}