import mx.utils.Delegate;

	private var className:String = "LoaderWithLoadXMLTest";

	private var eventType:Object;
	private var instanceType:Object;
	private var targetType:Object;

	public function LoaderWithLoadXMLTest(testMethod:String) {
		super(testMethod);
	}

	public function run():Void {
		eventType = LoaderEvent;
		instanceType = Loader;
		targetType = XMLEvt;
		filePath = "http://www.colvia.com/FAST/test.html";
		
		instance = new Loader(new LoadXML());
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