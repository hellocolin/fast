import mx.utils.Delegate;

import com.mixmedia.mx.events.ErrorEvent;
import com.mixmedia.mx.events.Event;

import asunit.framework.TestCase;

class LoaderTestCase extends TestCase {
	private var event:Event=null;
	private var instance:ILoader;
	private var eventType:Object;
	private var instanceType:Object;
	private var targetType:Object;
	private var filePath:String;
	private var iid:Number;
	private var isTimeout:Boolean;

	public function LoaderTestCase(testMethod:String) {
		super(testMethod);
		clearInterval(iid);
		iid = setInterval(Delegate.create(this,timeout),5000);
	}

	private function timeout():Void{
		clearInterval(iid);
		isTimeout = true;
		resumeTest(new ErrorEvent(this,ErrorEvent.ERROR,this,'timeout'));
	}

	private function resumeTest(e:Event):Void {
		clearInterval(iid);
		if(event!=null)return;
		event = e;
		super.run();
	}
	
	public function testEventNotError():Void{
		assertTrue("Event must not Error:", event instanceof ErrorEvent == false);
	}
	
	public function testEventIsLoaderEvent():Void{
		assertTrue("Event must LoaderEvent", event instanceof eventType == true);
	}
	
	public function testEventCurrentTargetIsSameClassOfInstance():Void{
		assertTrue("test currentTarget in Event:"+event.currentTarget, event.currentTarget instanceof instanceType);
	}

	public function testEventCurrentTargetMustSameAsInstance():Void{
		assertTrue("test currentTarget in Event:"+event.currentTarget, event.currentTarget === instance);
	}

	public function testEventTarget():Void{
		assertTrue("test target in Event:"+event.target, event.target instanceof targetType);
	}
	
	public function testEnd():Void{
		assertTrue("data loading Timeout", isTimeout!=true);
		instance.unload();
		delete instance;
	}
}
