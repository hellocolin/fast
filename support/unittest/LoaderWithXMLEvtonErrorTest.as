import mx.utils.Delegate;

	private var className:String = "LoaderWithXMLEvtonErrorTest";

	private var eventType:Object;
	private var instanceType:Object;
	private var targetType:Object;

	public function LoaderWithXMLEvtonErrorTest(testMethod:String) {
		super(testMethod);
	}

	public function run():Void {
		eventType = LoaderEvent;
		instanceType = Loader;
		targetType = XMLEvt;
		filePath = "failLoad.xml";

		instance = new Loader(new LoadXML(),4);
		instance.addEventListener(LoaderEvent.COMPLETE, Delegate.create(super,resumeTest));
		instance.addEventListener(IOErrorEvent.IO_ERROR, Delegate.create(super,resumeTest));
		instance.load(filePath);
	}

	public function testEventIsError():Void{
		assertTrue("Event must IOErrorEvent:", event instanceof IOErrorEvent == true);
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