
/**
 * @author colin
 */
class com.mixmedia.utils.ArrayUtils {
	
	public static function suffle(ary:Array) : Void {
		var nLength:Number,nRandom:Number,temp:Array,i:Number;
		nLength = ary.length;
		for (i = 0; i < nLength; i++) {
			nRandom = Math.floor(Math.random()*nLength);
			temp = ary[i];
			ary[i] = ary[nRandom];
			ary[nRandom] = temp;
		}
	}
}
