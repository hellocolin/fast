import mx.utils.Delegate;

import com.mixmedia.mx.XMLEvt;
import com.mixmedia.mx.events.ErrorEvent;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.ILoader;
import com.mixmedia.net.LoadXML;

class LoadXMLTest extends LoaderTestCase {
	private var className:String = "LoadXMLTest";

	private var eventType:Object;
	private var instanceType:Object;
	private var targetType:Object;

	public function LoadXMLTest(testMethod:String) {
		super(testMethod);
	}

	public function run():Void {
		eventType = LoaderEvent;
		instanceType = LoadXML;
		targetType = XMLEvt;
		filePath = "http://www.colvia.com/FAST/test.html";

		instance = new LoadXML();
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

	public function testEventTargetIsXML():Void{
		assertTrue("Event must XML",event.target instanceof XML == true);
	}

	public function testEventResultData():Void{
		assertTrue("result must match",event.target.toString() == '<font face="_sans"><p>this is first paragraph</p><p>this is line 2</p></font>');
	}

	public function testEnd():Void{
		super.testEnd();
	}
}