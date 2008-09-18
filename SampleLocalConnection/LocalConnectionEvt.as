
/**
 * @author colin
 */
import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;

class LocalConnectionEvt extends AbstractEventDispatcher{
	private var base:LocalConnection;
	private var registeredConnections:Array = [];
	private var methods:Object={};
	
	public static var EVENT_ERROR:String = 'error';
	public static var EVENT_STATUS:String = 'status';

	public function LocalConnectionEvt(){
		base = new LocalConnection;
		base.onStatus = Fix.ref(this,onStatus);
	}

	public function connect(connectionName : String) : Boolean{
		if(base.connect(connectionName)==true){
			base['register'] = Fix.ref(this,registerConnection);
			return true;
		}

		return setupSecondaryConnection(connectionName);
	};

	private function setupSecondaryConnection(connectionName : String):Boolean{
		var timeStamp:Date = new Date();
		var id:String = connectionName+timeStamp.getTime();
		var lc0:LocalConnection = new LocalConnection();
		lc0.send(connectionName,'register',id);
		return base.connect(id);	
	}

	private function registerConnection(connectionName:String):Void{
		registeredConnections.push(connectionName);
	}

	public function send(connectionName : String, methodName : String, args : Object) : Boolean{
		return base.send(connectionName, methodName, args);
	};
	
	public function close() : Void{
		base.close();
	};
	
	public function domain() : String{
		return base.domain();
	};

	public function allowDomain(domain : String) : Boolean{
		return base.allowDomain(domain);
	};

	public function allowInsecureDomain(domain : String) : Boolean{
		return base.allowDomain(domain);
	};

	private function onStatus(infoObject:Object):Void{
		dispatchEvent(new Event(currentTarget,infoObject['level'],this));
	}

	public function addMethod(methodName:String,fnt:Function):Void{
		var ins:LocalConnectionEvt = this;
		base[methodName] = function():Void{
			ins.broadcastToChildConnections(methodName,arguments);
		};
		methods[methodName] = fnt;
	}
	
	private function broadcastToChildConnections(methodName:String,args:Array):Void{
		for(var i:Number=0;i<registeredConnections.length;i++){
			var lcs:LocalConnection = new LocalConnection();
			lcs.send(registeredConnections[i],methodName,args);
		}
		methods[methodName](args);
	}
}
