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
	static function hexToColor(argHex:Number,argAlpha:Number):Object{// change hex value to color transform object
		var a:Number = (argAlpha == undefined)?100:argAlpha;
		//extract RGB from Hex
		var r:Number = argHex >> 16;
		var g:Number = (argHex ^ (r << 16)) >> 8;
		var b:Number = (argHex ^ (r << 16)) ^ (g << 8);
		return {ra:0,rb:r,ga:0,gb:g,ba:0,bb:b,aa:a,bb:100};
	}
}
