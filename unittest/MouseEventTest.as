import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.MouseEvent;

import asunit.framework.TestCase;

class MouseEventTest extends TestCase {
	private var className:String = "MouseEventTest";
	private var instance:Object;

	private var event:Event;
	private var currentTarget:Object;
	private var type:String;
	private var target:Object;

	public function MouseEventTest(testMethod:String) {
		super(testMethod);
	}

	public function setUp():Void{
		currentTarget = {};
		type = MouseEvent.MOUSE_DOWN;
		target = {};
		event = new MouseEvent(currentTarget,type,target);
	}

	public function tearDown():Void{
		delete currentTarget;
		delete type;
		delete target;
	}

	public function testEventCurrentTarget():Void{
		assertTrue("check parameter setting", event.currentTarget === currentTarget);
	}

	public function testEventType():Void{
		assertTrue("check parameter setting", event.type === type);
	}

	public function testEventTarget():Void{
		assertTrue("check parameter setting", event.target === target);
	}	
	
}
