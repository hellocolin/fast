import mx.utils.Delegate;

import com.mixmedia.mx.XMLEvt;
import com.mixmedia.mx.events.ErrorEvent;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;

class XMLEvtTest extends LoaderTestCase {
	private var className:String = "XMLEvtTest";

	private var eventType:Object;
	private var instanceType:Object;
	private var targetType:Object;
	private var instance:XMLEvt;

	public function XMLEvtTest(testMethod:String) {
		super(testMethod);
	}

	public function run():Void {
		eventType = LoaderEvent;
		instanceType = XMLEvt;
		targetType = XMLEvt;
		filePath = "http://www.colvia.com/FAST/test.html";

		instance = new XMLEvt();
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
	
	public function testEnd():Void{
		super.testEnd();
	}
}