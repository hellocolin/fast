/**
   ActionScript Class File -- Created with SAPIEN Technologies PrimalScript 3.1
   
   @class  
   @package
   @author Colin Leung
   @codehint 
   @example 
   @tooltip 
*/


class com.mixmedia.utils.Conversion {
	static private var toDeg:Number = 180/Math.PI;
	static private var toRad:Number = Math.PI/180;
	
	static function hexToColor(argHex:Number,argAlpha:Number):Object{// change hex value to color transform object
		if(argHex==-1)return {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0,aa:100,bb:0};
		
		var a:Number = (argAlpha == undefined)?100:argAlpha;
		//extract RGB from Hex
		var r:Number = argHex >> 16;
		var g:Number = (argHex ^ (r << 16)) >> 8;
		var b:Number = (argHex ^ (r << 16)) ^ (g << 8);
		return {ra:0,rb:r,ga:0,gb:g,ba:0,bb:b,aa:a,bb:100};
	}
	
	static function radianToDegree(r:Number):Number{
		return r*toDeg;
	}
	
	static function degreeToRadian(d:Number):Number{
		return d*toRad;
	}
}
