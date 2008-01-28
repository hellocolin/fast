import mx.utils.Delegate;

import com.mixmedia.mx.events.ErrorEvent;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.ILoader;
import com.mixmedia.net.LoadVAR;

class LoadVarsEvtTest extends LoaderTestCase {
	private var className:String = "LoadVarsEvtTest";

	private var eventType:Object;
	private var instanceType:Object;
	private var targetType:Object;

	public function LoadVarsEvtTest(testMethod:String) {
		super(testMethod);
	}

	public function run():Void {
		eventType = LoaderEvent;
		instanceType = LoadVAR;
		targetType = LoadVars;
		filePath = "http://www.colvia.com/FAST/test.txt";

		instance = new LoadVAR();
		instance.addEventListener(LoaderEvent.COMPLETE, Delegate.create(super,resumeTest));
		instance.addEventListener(ErrorEvent.ERROR, Delegate.create(super,resumeTest));
		instance.load(filePath);
	}
	
	public function testEventNotError():Void{
		super.testEventNotError();
	}
	
	public function testEventIsLoaderEvent():Void{
		super.testEventIsLoaderEvent();
	}
	
	public function testEventCurrentTargetIsSameClassOfInstance():Void{
		super.testEventCurrentTargetIsSameClassOfInstance();
	}

	public function testEventCurrentTargetMustSameAsInstance():Void{
		super.testEventCurrentTargetMustSameAsInstance();
	}

	public function testEventTarget():Void{
		super.testEventTarget();
	}

	public function testEventTargetIsLoadVars():Void{
		assertTrue("Event target must LoadVars",event.target instanceof LoadVars == true);
	}

	public function testEventResultData():Void{
		assertTrue(event.target.toString(),event.target.toString() == 'test=12131&success=true');
	}

	public function testEnd():Void{
		super.testEnd();
	}
}