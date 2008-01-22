import com.mixmedia.js.JS;

import asunit.framework.TestCase;

class JSTest extends TestCase {
	private var className:String = "JSTest";
	private var instance:Function;

	public function JSTest(testMethod:String) {
		super(testMethod);
	}

	public function setUp():Void {JS.enableExternalConnect=false;}
	public function tearDown():Void {JS.enableExternalConnect=true;}

	public function testNoArgument():Void{
		assertTrue('',JS.call('test')=='javascript:test();');
	}
	public function testNumberArgument():Void{
		assertTrue('',JS.call('jacall',1)=='javascript:jacall(1);');
	}
	public function testNumberAsStringArgument():Void{
		assertTrue('',JS.call('jabcall','3')=='javascript:jabcall("3");');
	}
	public function testStringArgument():Void{
		assertTrue('',JS.call('hello','world')=='javascript:hello("world");');
	}
	public function testMultiArguments():Void{
		assertTrue('',JS.call('showMenu',1,'company',2,'about')=='javascript:showMenu(1,"company",2,"about");');
	}
}
