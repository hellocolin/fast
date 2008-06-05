import mx.utils.Delegate;import com.mixmedia.mx.NetStreamEvt;import com.mixmedia.mx.events.ErrorEvent;import com.mixmedia.mx.events.Event;import com.mixmedia.mx.events.LoaderEvent;import com.mixmedia.net.LoadFLV;import com.mixmedia.view.net.Loader;
class LoaderWithLoadFLVTest extends LoaderTestCase {
	private var className:String = "LoaderWithLoadFLVTest";

	private var eventType:Object;
	private var instanceType:Object;
	private var targetType:Object;

	public function LoaderWithLoadFLVTest(testMethod:String) {
		super(testMethod);
	}

	public function run():Void {
		eventType = LoaderEvent;
		instanceType = Loader;
		targetType = NetStreamEvt;
		filePath = "http://www.colvia.com/FAST/test.flv";
		
		instance = new Loader(new LoadFLV(new Video()),2);
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