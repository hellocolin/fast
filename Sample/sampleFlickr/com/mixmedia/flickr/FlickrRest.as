import mx.utils.Delegate;

import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.LoadVAR;
import com.mixmedia.utils.BindMovieClip;
import com.mixmedia.utils.MD5;
import com.mixmedia.utils.Queue;
import com.mixmedia.view.status.ProgressIcon;

/**
 * @author colin
 */

class com.mixmedia.flickr.FlickrRest implements IEventDispatcher{
	private static var endPoint : String = "http://api.flickr.com/services/rest/";
	private static var api_key:String = Main.API_KEY;
	private static var secretKey:String = Main.SECRETKEY;
	private static var crypt:MD5 = new MD5();

	public static function resultToXML(str:String):XML{
		var xData:XML = new XML();
		xData.ignoreWhite = true;
		xData.parseXML(str);
		return xData;
	}

	private var request:LoadVars;
	private var result:LoadVAR;
	private var _data:String;
	private var queueId : Number;

	public function FlickrRest(queueId:Number){
		this.queueId = queueId;
		
		request = new LoadVars();
		request['api_key'] = api_key;

		result  = new LoadVAR();
		result.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,onLoadComplete));
		result.setCurrentTarget(this);
	}

	public function send(needSign:Boolean):Void{
		if(queueId!=null){
			var r:Function = Delegate.create(this, (needSign)?doSendWithSign:doSend);
			Queue.instance(queueId).addRequest(r);
			return;
		}

		(needSign==true)?doSendWithSign():doSend();
	}
	
	private function doSendWithSign():Void{
		request['api_sig'] = sign(request);
		doSend();
	}
	
	private function doSend():Void{
		request.sendAndLoad(endPoint,result.getBase(),'POST');
		makePreloader();
	}
	

	public function set method(method:String):Void{
		request['method'] = method;
	}
	public function get args():LoadVars{
		return request;
	}

	public function addEventListener(event : String, handler : Function) : Void {
		result.removeEventListener(LoaderEvent.COMPLETE, Delegate.create(this,onLoadComplete));
		result.addEventListener(event, handler);
		result.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,onLoadComplete));
	}
	
	public function removeEventListener(event : String, handler : Function) : Void {
		result.addEventListener(event, handler);
	}

	public function setCurrentTarget(currentTarget : Object) : Void {
		result.setCurrentTarget(currentTarget);
	}

	private function sign(obj:Object):String{
		return crypt.hash(secretKey+getString(obj,true));
	}
	
	private function getString(obj:Object,useForSign:Boolean):String{
		useForSign = (useForSign==null)?false:useForSign;
		//sort the arguments
		var ary:Array = [];
		for(var name:String in obj){
			if(name =='addEventListener'||name=='currentTarget'||name=='dispatchEvent'||name=='dispatchQueue'||name=='removeEventListener'||name=='base'){}else{
				ary.push({arg:name,value:obj[name]});
			}
		}
		ary.sortOn("arg");
		
		//create sign string
		var str:String = "";
		for(var i:Number=0;i<ary.length;i++){
			str += (useForSign==true || i==0)?"":"&";
			str += ary[i]["arg"];
			str += (useForSign==true)?"":"=";
			str += ary[i]["value"];
		}
		return str;		
	}
	
	private function getSignedString(obj:Object):String{
		return getString(obj)+"&api_sig="+sign(obj);
	}

	private var preloaderParent : MovieClip; 
	private var preloaderID : String;

	private var errorIconParent : MovieClip;
	private var errorIconID : String;
	private function makePreloader():Void{
		if(preloaderParent==null)preloaderParent=_root;
		if(errorIconParent==null)errorIconParent=_root;

		var preloader:ProgressIcon = ProgressIcon(BindMovieClip.make(BindMovieClip.PROGRESS, preloaderParent, preloaderID));
		preloader.setMonitorTarget(result);
	}

	private function killPreloader():Void{
		BindMovieClip.remove(BindMovieClip.PROGRESS, preloaderParent);
	}
	
	public function setPreloader(preloaderParent:MovieClip,symbolIdentifier:String):Void{
		this.preloaderParent = preloaderParent;
		this.preloaderID = (symbolIdentifier==null)?preloaderID:symbolIdentifier;
	}
	
	public function setErrorIcon(errorIconParent:MovieClip,symbolIdentifier:String):Void{
		this.errorIconParent = errorIconParent;
		this.errorIconID = (symbolIdentifier==null)?errorIconID:symbolIdentifier;
	}

	public function getTargetContainer():Object{
		return result.getTargetContainer();
	}

	private function onLoadComplete() : Void {
		if(queueId!=null)Queue.instance(queueId).next();
		_data = result.data;
		killPreloader();
	}

	public function get data():String{
		return _data;
	}

	private function onError():Void{
		BindMovieClip.make(BindMovieClip.ERROR,errorIconParent,errorIconID);
		killPreloader();
	}
}
