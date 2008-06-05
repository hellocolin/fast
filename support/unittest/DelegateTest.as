import mx.utils.Delegate;

import asunit.framework.TestCase;

class DelegateTest extends TestCase {
	private var className:String = "DelegateTest";

	private var fixture:Object;
	private var instance:Function;

	public function DelegateTest(testMethod:String) {
		super(testMethod);
	}
	
	public function setUp():Void{
		fixture = new Object();
		instance = Delegate.create(this,getFixture);
		//instance = this.getFixture;
	}
	
	private function getFixture():Object{
		return fixture;
	}
	
	public function tearDown():Void{
		delete fixture;
		delete instance;
	}

	public function testFunctionReference():Void{
		assertTrue('instance function must equal to fixture', getFixture() === instance());
	}
	
	public function testPassInstanceToOtherObject():Void{
		fixture['test']=instance;
		assertTrue('instance must equal after pass to other object',getFixture()===fixture['test']());
	}

	private var testVal:Object;	
	private function watcher(prop:String,oldVal:Object,newVal:Object):Object{
		testVal = newVal;
		prop=null;
		oldVal=null;
		return newVal;
	}

	public function testObjectWatch():Void{
		var obj:Object = {};
		fixture['prop'] = 'nil';
		fixture.watch('prop', Delegate.create(this,watcher));
		fixture['prop'] = obj;
		
		//assertTrue('',testVal===obj);
		assertTrue('',fixture['prop']===obj);
	}
}
