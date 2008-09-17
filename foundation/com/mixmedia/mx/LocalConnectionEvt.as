
/**
 * @author colin
 */
import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;

class com.mixmedia.mx.LocalConnectionEvt extends AbstractEventDispatcher{
	private var base:LocalConnection;
	private var registeredConnections:Array;
	private var methods:Object;
	private var connName:String;
	
	private static var METHOD_REGISTER:String = '__register';
	private static var METHOD_REMOVE:String   = '__removeConn';

	public static var EVENT_ERROR:String = 'error';
	public static var EVENT_STATUS:String = 'status';
	private var id : String;

	public function LocalConnectionEvt(){
		base = new LocalConnection();
		base.onStatus = Fix.ref(this,onStatus);
		
		registeredConnections=new Array();
		methods = {};	
	}

	public function connect(connectionName : String) : Boolean{
		close();
		connName = connectionName;

		if(base.connect(connectionName)==true){
			id = connectionName;
			base[METHOD_REGISTER] = Fix.ref(this,registerConnection);
			base[METHOD_REMOVE]   = Fix.ref(this,removeConnection);
			return true;
		}
		return setupSecondaryConnection();
	};

	public function send(connectionName : String, methodName : String, args : Object) : Boolean{
		return base.send(connectionName, methodName, args);
	};
	
	public function close() : Void{
		base.send(connName,METHOD_REMOVE,id);
		connName = null;
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

	public function addMethod(methodName:String,fnt:Function):Void{
		var ins:LocalConnectionEvt = this;
		base[methodName] = function():Void{
			ins.broadcastToChildConnections(methodName,arguments);
		};
		methods[methodName] = fnt;
	}

	private function onStatus(infoObject:Object):Void{
		dispatchEvent(new Event(currentTarget,infoObject['level'],this));
	}
	
	private function broadcastToChildConnections(methodName:String,args:Array):Void{
		for(var i:Number=0;i<registeredConnections.length;i++){
			var lcs:LocalConnection = new LocalConnection();
			lcs.send(registeredConnections[i],methodName,args);
		}
		methods[methodName](args);
	}
	
	private function setupSecondaryConnection():Boolean{
		var timeStamp:Date = new Date();
		id = connName+timeStamp.getTime()+random(10000);
		base.send(connName,METHOD_REGISTER,id);
		return base.connect(id);
	}

	private function registerConnection(connectionName:String):Void{
		removeConnection(connectionName);
		registeredConnections.push(connectionName);
	}
	
	private function removeConnection(connectionName:String):Void{
		var lcTest:LocalConnection = new LocalConnection();
		for(var i:Number = 0;i<registeredConnections.length;i++){
			var isConnectEmpty:Boolean = lcTest.connect(registeredConnections[i]);
			lcTest.close();
			if((registeredConnections[i]==connectionName)||(isConnectEmpty==true)){
				registeredConnections.splice(i,1);
				i--;
			}
		}
	}
}
