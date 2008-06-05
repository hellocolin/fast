import mx.utils.Delegate;

import com.mixmedia.mx.NetStreamEvt;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IOErrorEvent;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.LoadFLV;
import com.mixmedia.net.Loader;

class LoaderWithLoadFLVonErrorTest extends LoaderTestCase {
	private var className:String = "LoaderWithLoadFLVonErrorTest";

	private var eventType:Object;
	private var instanceType:Object;
	private var targetType:Object;

	public function LoaderWithLoadFLVonErrorTest(testMethod:String) {
		super(testMethod);
	}

	public function run():Void {
		eventType = LoaderEvent;
		instanceType = Loader;
		targetType = NetStreamEvt;
		filePath = "failLoad.flv";

		instance = new Loader(new LoadFLV(new Video()),2);
		instance.addEventListener(LoaderEvent.COMPLETE, Delegate.create(super,resumeTest));
		instance.addEventListener(IOErrorEvent.IO_ERROR, Delegate.create(super,resumeTest));
		instance.load(filePath);
	}

	public function testEventIsError():Void{
		assertTrue("Event must IOError:", event instanceof IOErrorEvent == true);
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