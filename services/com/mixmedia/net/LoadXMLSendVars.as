
/**
 * @author colin
 */
import flash.net.URLRequestMethod;

import mx.utils.Delegate;

import com.mixmedia.mx.XMLEvt;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.LoadVAR;
import com.mixmedia.net.LoadXML;

class com.mixmedia.net.LoadXMLSendVars implements ILoader, ISender , IFASTEventDispatcher{
	private var baseXML :LoadXML;
	private var baseLV:LoadVAR;

	public function LoadXMLSendVars(){
		baseXML     = new LoadXML();
		baseLV      = new LoadVAR();
		baseXML.setCurrentTarget(this);
		baseLV.setCurrentTarget(this);
		baseLV.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,varToXML));
	}
	
	public function getTargetContainer() : Object {
		return baseXML.getTargetContainer();
	}
	
	public function load(requestURL : String) : Void {
		baseXML.load(requestURL);
	}
	
	public function unload() : Void {
		baseXML.unload();
	}
	
	public function addEventListener(event : String, handler : Function) : Void {
		baseXML.addEventListener(event, handler);
		baseLV.addEventListener(event,handler);
		baseLV.removeEventListener(LoaderEvent.COMPLETE, Delegate.create(this,varToXML));
		baseLV.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,varToXML));
	}
	
	public function removeEventListener(event : String, handler : Function) : Void {
		baseXML.removeEventListener(event, handler);
		baseLV.removeEventListener(event,handler);		
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		baseXML.setCurrentTarget(currentTarget);
		baseLV.setCurrentTarget(currentTarget);
	}
	
	public function send(requestURL : String, dataAsKeyAndValue : Object) : Void {
		for(var name:String in dataAsKeyAndValue){
			LoadVars(baseLV.getBase())[name] = dataAsKeyAndValue[name];
		}
		baseLV.sendAndLoad(requestURL, baseLV, URLRequestMethod.POST);
	}
	
	private function varToXML():Void{
		XMLEvt(baseXML.getTargetContainer()).parseXML(baseLV.data);
	}
	
	private function toString():String{
		return "[object XMLLoaderPostFormAsVars]";
	}

	public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {
		this.addEventListener(eventType, Delegate.create(whichObject,callFunction));
	}
}
