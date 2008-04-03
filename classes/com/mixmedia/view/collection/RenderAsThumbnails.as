
/**
 * @author colin
 */import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;

import mx.utils.Delegate;

import com.mixmedia.motion.MotionTween;
import com.mixmedia.mx.events.Event;
import com.mixmedia.view.collection.IListCell;
import com.mixmedia.view.collection.IListCellRenderArrangement;

class com.mixmedia.view.collection.RenderAsThumbnails implements IListCellRenderArrangement {
	private static var uid:Number=0;
	
	private var cellIdentifier:String;
	private var cells : Array;
	private var row : Number;
	private var col : Number;
	private var target : MovieClip;
	private var proxy  :Bitmap;
	private var fadein:MotionTween;
	private var fadeout:MotionTween;

	public function RenderAsThumbnails(cellIdentifier:String,target:MovieClip,row:Number,col:Number){
		uid++;
		this.cellIdentifier = cellIdentifier;
		this.target = target.createEmptyMovieClip("$target"+uid, 50);
		this.proxy = new Bitmap(target.createEmptyMovieClip("proxy",51),null,PixelSnapping.ALWAYS,true); 
		this.row = (row==null)?3:row;
		this.col = (col==null)?3:col;
		cells = new Array();

		fadein  = new MotionTween(this.target,{a:100});
		fadeout = new MotionTween(proxy.toMovieClip(),{a:0});
		fadeout.addEventListener(Event.TWEENEND, Delegate.create(this,onFadeout));

		this.target._alpha=0;
	}

	public function render(data : Array) : Array {
		clear();
		doRender(data);
		fadein.startTween();
		return cells;
	}

	private function doRender(data:Array):Void{
		var count:Number = Math.min(row*col,data.length);
		for(var i:Number=0;i<count;i++){
			var cell:IListCell = IListCell(target.attachMovie(cellIdentifier, "item"+i, i));
			MovieClip(cell)._x = (i%col)*cell.getColWidth();
			MovieClip(cell)._y = Math.floor(i/col)*cell.getRowHeight();

			cell.setModel(data[i]);
			cells.push(cell);
		}
	}
	public function clear():Void{
		for(var name:String in target){
			if(target[name] instanceof IListCell){
				MovieClip(target[name]).removeMovieClip();
			}
		}
		cells = new Array();
	}	public function update(data : Array) : Array {
		makeProxy();
		clear();
		doRender(data);
		return cells;
	}

	private function makeProxy():Void{
		if(fadeout.isTweening())return;
		proxy.bitmapData = new BitmapData(target._width,target._height,true,0);
		proxy.bitmapData.draw(target);
		proxy._alpha=100;
		target._alpha=0;
		fadeout.startTween();
	}

	private function onFadeout() : Void {
		fadein.startTween();
	}
}
