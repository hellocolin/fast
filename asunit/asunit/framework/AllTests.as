
class asunit.framework.AllTests extends asunit.framework.TestSuite {
	private var className:String = "asunit.framework.AllTests";

	public function AllTests() {
		super();
		addTest(new asunit.framework.AssertTest());
		addTest(new asunit.framework.TestCaseTest());
	}
}
