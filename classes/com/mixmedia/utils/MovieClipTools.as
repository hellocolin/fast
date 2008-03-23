/**
 * @author Colin
 */
import com.mixmedia.view.net.VideoPlayer;class com.mixmedia.utils.MovieClipTools {
	public static function makeClickDisable(mc:MovieClip):Void{
		mc.onRollOver = null;
		mc.useHandCursor = false;
	};
	
	static public function notResize(mc:MovieClip):Void{
		var o:Object = {x:0,y:0};
		var p:Object = {x:100,y:100};
		mc.localToGlobal(o);
		mc.localToGlobal(p);
		var dx:Number =p['x']-o['x'];
		var dy:Number =p['y']-o['y'];
		mc._xscale = mc._xscale/dx*100;
		mc._yscale = mc._yscale/dy*100;
	}
	
	static public function captureTransform(mc:MovieClip):Object{
		return {x:mc._x,y:mc._y,r:mc._rotation,xs:mc._xscale,ys:mc._yscale};
	} 
	
	static public function killMovieClip(mc:MovieClip):Void{
		mc.swapDepths(50000);
		mc.removeMovieClip();
	}

	static public function pixelAlign(mc:MovieClip):Void{
		var o:Object = {x:0,y:0};
		mc.localToGlobal(o);
		mc._parent._x -=o['x']%1;
		mc._parent._y -=o['y']%1;
	}
	
	public static function matchSize(mcToResize:MovieClip,mcToMatch:MovieClip,isCrop:Boolean):Void{
		if(isCrop==null)isCrop=false;
		var ratioFlo:Number = mcToResize._width/mcToResize._height;
		var ratioFix:Number = mcToMatch._width/mcToMatch._height;

		if((ratioFlo>ratioFix&&isCrop==true)||(ratioFlo<ratioFix&&isCrop==false)){
			//match height
			//scale width with yscale
			mcToResize._height = mcToMatch._height;
			mcToResize._xscale = mcToResize._yscale;
		}else {
			//match width
			//scale height with xscale
			mcToResize._width = mcToMatch._width;
			mcToResize._yscale = mcToResize._xscale;
		}
		
	}
	
	public static function alignCenter(floatMc:Object,fixMc:Object):Void{
		var fixMcCenterX:Number = fixMc['_width']/2;
		var fixMcCenterY:Number = fixMc['_height']/2;
		floatMc['_x'] = fixMcCenterX-floatMc['_width'] + floatMc['_width']/2;
		floatMc['_y'] = fixMcCenterY-floatMc['_height'] + floatMc['_height']/2;
	};

	public static function alignStageXCenter(floatMc:MovieClip):Void{
		var fixMcCenterX:Number = Stage.width/2;
		floatMc._x = fixMcCenterX - floatMc._width + floatMc._width/2;
	}

	public static function alignStageYCenter(floatMc:MovieClip):Void{
		var fixMcCenterY:Number = Stage.height/2;
		floatMc._y = fixMcCenterY - floatMc._height + floatMc._height/2;
	}
	
		// ==============
	// implement from http://www.adobe.com/devnet/flash/articles/adv_draw_methods.html
	// mc.drawRect() - by Ric Ewing (ric@formequalsfunction.com) - version 1.1 - 4.7.2002
	// 
	// x, y = top left corner of rect
	// w = width of rect
	// h = height of rect
	// cornerRadius = [optional] radius of rounding for corners (defaults to 0)
	// ==============
	public static function drawRect(mc:MovieClip,x:Number, y:Number, w:Number, h:Number, cornerRadius:Number):Void {
		// if the user has defined cornerRadius our task is a bit more complex. :)
		if (cornerRadius>0) {
			// init vars
			var theta:Number, angle:Number, cx:Number, cy:Number, px:Number, py:Number;
			// make sure that w + h are larger than 2*cornerRadius
			if (cornerRadius>Math.min(w, h)/2) {
				cornerRadius = Math.min(w, h)/2;
			}
			// theta = 45 degrees in radians
			theta = Math.PI/4;
			// draw top line
			mc.moveTo(x+cornerRadius, y);
			mc.lineTo(x+w-cornerRadius, y);
			//angle is currently 90 degrees
			angle = -Math.PI/2;
			// draw tr corner in two parts
			cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
			py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
			mc.curveTo(cx, cy, px, py);
			angle += theta;
			cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
			py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
			mc.curveTo(cx, cy, px, py);
			// draw right line
			mc.lineTo(x+w, y+h-cornerRadius);
			// draw br corner
			angle += theta;
			cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
			py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
			mc.curveTo(cx, cy, px, py);
			angle += theta;
			cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
			py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
			mc.curveTo(cx, cy, px, py);
			// draw bottom line
			mc.lineTo(x+cornerRadius, y+h);
			// draw bl corner
			angle += theta;
			cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
			py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
			mc.curveTo(cx, cy, px, py);
			angle += theta;
			cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
			py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
			mc.curveTo(cx, cy, px, py);
			// draw left line
			mc.lineTo(x, y+cornerRadius);
			// draw tl corner
			angle += theta;
			cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
			py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
			mc.curveTo(cx, cy, px, py);
			angle += theta;
			cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
			px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
			py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
			mc.curveTo(cx, cy, px, py);
		} else {
			// cornerRadius was not defined or = 0. This makes it easy.
			mc.moveTo(x, y);
			mc.lineTo(x+w, y);
			mc.lineTo(x+w, y+h);
			mc.lineTo(x, y+h);
			mc.lineTo(x, y);
		}
	};
	
	public static function findButton(mc:MovieClip):Button{
		for(var name:String in mc){
			if(mc[name] instanceof Button){
				return mc[name];
			}
		}
	}		public static function findVideo(mc : MovieClip) : Video {
		for(var name:String in mc){
			if(mc[name] instanceof Video){
				return mc[name];
			}
		}	}
}