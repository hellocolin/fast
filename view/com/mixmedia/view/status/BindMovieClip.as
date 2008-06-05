import com.mixmedia.view.status.IStatusIcon;
/**
 * @author Colin
 */
class com.mixmedia.view.status.BindMovieClip {
	public static var PROGRESS:String='Preloader';
	public static var ERROR:String='ErrorIcon';
	public static var TOOLTIP:String='toolTips';

	public static function make(type:String,attachMC:MovieClip,id:String,initObj:Object):MovieClip{
		if(id==undefined)id=type;
		return attachMC.attachMovie(id,type,1000,initObj);
	}

	public static function remove(type:String,attachMC:MovieClip) : Void {
		if(attachMC[type] instanceof IStatusIcon){
			IStatusIcon(attachMC[type]).kill();
			return;
		}

		attachMC[type].removeMovieClip();	
	}
}
