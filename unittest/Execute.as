import asunit.textui.TestRunner;
/**
 * @author Colin
 */

class Execute extends TestRunner{
	private static var runner:TestRunner;
	public function Execute(){
		start(AllTests);
	}

	public static function main():Void{
		runner = new Execute();
	}
}