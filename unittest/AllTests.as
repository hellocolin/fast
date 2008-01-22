
class AllTests extends asunit.framework.TestSuite {
	private var className:String = "AllTests";

	public function AllTests() {
		super();
/*
		addTest(new LoaderWithLoadSWFonErrorTest());
		addTest(new LoaderWithLoadSWFTest());
		addTest(new LoaderWithLoadFLVTest());
		addTest(new LoaderWithXMLEvtTest());
		addTest(new LoadFLVTest());
		addTest(new LoadSWFTest());
		addTest(new LoadXMLTest());
		addTest(new MouseEventTest());
		addTest(new XMLEvtTest());
		addTest(new LoaderWithLoadFLVonErrorTest());
		addTest(new LoaderWithXMLEvtonErrorTest());
		addTest(new LoaderWithLoadXMLTest());
		addTest(new LoaderWithLoadXMLonErrorTest());
		
		addTest(new QueueTest());
*/	
//		addTest(new JSTest());
		addTest(new DelegateTest());
	}
}
