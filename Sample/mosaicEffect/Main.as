
/**
 * @author colin
 */
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

import mx.utils.Delegate;

class Main {
	private var i:Number;
	private var j:Number;
	private var c:Number;
	private var k:Number;

	private var base:MovieClip;
	private var buffer:Buffer32;
	private var virtualMask:Array;
	private var mask:BitmapData;
	
	private var pt:Point;
	private static var po:Point = new Point(0,0);
	private static var tileRect:Rectangle = new Rectangle(0,0,30,30);

	private var alphaMask: Bitmap;
	private var bmpColor : Bitmap;
	private var color : BitmapData;
	
	private var nextGirl:BitmapData;
	private var pixelsDisplayCount:Number=256;
	private var tmx:Matrix;

	public function Main(base:MovieClip){
		Stage.align = "TL";
		base.onEnterFrame = Delegate.create(this,loop);

		this.base = base;
		_quality = "BEST";
		createBuffer();
		createVirtualMask();
		tmx = new Matrix(1,0,0,1,-7,-6);
		mask = new BitmapData(512,512,true,0);
		color= new BitmapData(16,16,false,0);
		nextGirl = color.clone();
		
		
		var tiles:MovieClip = base.createEmptyMovieClip('tiles', 100);
		tiles.blendMode = BlendMode.LAYER;

		bmpColor = new Bitmap(tiles,color);
		bmpColor._xscale = bmpColor._yscale = 3200;

		alphaMask = new Bitmap(tiles,mask);
		alphaMask.blendMode = BlendMode.ALPHA;

		color.draw(base['girl'],tmx);
		base['girl'].gotoAndStop(random(22)+1);
		nextGirl.draw(base['girl'],tmx);

		pt = new Point();
		_quality = "LOW";
	}


	private function createVirtualMask() : Void {
		virtualMask = [];
		for(i=0;i<400;i++){
			virtualMask[i]=-random(20);
		}
	}

	private function createBuffer():Void{
		buffer = new Buffer32();
		for(i=0;i<MovieClip(base['icon'])._totalframes;i++){
			base['icon'].gotoAndStop(i);
			buffer.addToBuffer(MovieClip(base['icon']));
		}	
	}
	
	private function loop():Void{
		var st:Number = getTimer();
		mask.fillRect(mask.rectangle, 0);
		var t:BitmapData = buffer.toBitmapData();
		for(i=0;i<(16*16);i++){
			k = virtualMask[i]++;
			tileRect.x = (k&7)<<5;
			tileRect.y = (k>>3)<<5;

			pt.x = (i&15)<<5;
			pt.y = (i>>4)<<5;
			mask.copyPixels(t, tileRect, pt);
	
			if(virtualMask[i]>=64){
				virtualMask[i]=0;
				color.setPixel(i&15, i>>4, nextGirl.getPixel(i&15, i>>4));
				pixelsDisplayCount--;
			}

			if(pixelsDisplayCount<=0){
				pixelsDisplayCount = 256;
				nextGirl.fillRect(nextGirl.rectangle, 0);
				base['girl'].gotoAndStop(random(22)+1);
				nextGirl.draw(base['girl'],tmx);
			}
		}
		trace(getTimer()-st);
	}
}
