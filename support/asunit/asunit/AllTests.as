 
class asunit.AllTests extends asunit.framework.TestSuite {
	private var className:String = "asunit.AllTests";

	public function AllTests() {
		super();
		addTest(new asunit.framework.AllTests());
		addTest(new asunit.util.AllTests());
	}
}
