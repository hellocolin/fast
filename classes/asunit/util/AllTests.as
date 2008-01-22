
class asunit.util.AllTests extends asunit.framework.TestSuite {
	private var className:String = "asunit.util.AllTests";

	public function AllTests() {
		super();
		addTest(new asunit.util.ArrayIteratorTest());
	}
}
