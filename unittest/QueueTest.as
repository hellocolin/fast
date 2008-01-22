import mx.utils.Delegate;

import com.mixmedia.utils.Queue;

import asunit.framework.TestCase;

class QueueTest extends TestCase {	
	private var instance:Queue;
	private var className:String = "QueueTest";
	private var iid:Number;

	public function QueueTest(testMethod:String) {
		super(testMethod);
	}

	private var queueItem1:Object = {};
	private var queueItem2:Object = {};
	private var queueItem3:Object = {};
	private var queueItem4:Object = {};
	private var compareItem1:Object;
	private var compareItem2:Object;
	private var compareItem3:Object;
	private var compareItem4:Object;
	private function setQueueItem1():Void{compareItem1=queueItem1;}
	private function setQueueItem2():Void{compareItem2=queueItem2;}	
	private function setQueueItem3():Void{compareItem3=queueItem3;}
	private function setQueueItem4():Void{compareItem4=queueItem4;}
	private var que:Queue;

	public function run():Void{
		clearInterval(iid);

		que = Queue.instance(25);
		que.addRequest(Delegate.create(this, setQueueItem1));//run immediately, store as
		que.addRequest(Delegate.create(this, setQueueItem2));//store as item1
		que.addRequest(Delegate.create(this, setQueueItem3));//store as item2
		que.addRequest(Delegate.create(this, setQueueItem4));//store as item3

		iid = setInterval(Delegate.create(this,resumeTest1),random(1000)+500);
	}

	private function resumeTest1():Void {
		clearInterval(iid);
		que.next();//assign compareItem2=queueItem2;
		iid = setInterval(Delegate.create(this,resumeTest2),random(1000)+500);
	}

	private function resumeTest2():Void {
		clearInterval(iid);
		super.run();
	}

	public function testQueueLength():Void{
		var queueLength:Number = que.getLength();
		assertTrue('queue length should be 2, now '+queueLength, queueLength==2);
	}

	public function testItem0():Void{assertTrue('item must match QueueItem1',que.getItemAt(0)['func']===setQueueItem3);}
	public function testItem1():Void{assertTrue('item must match QueueItem3',que.getItemAt(1)['func']===setQueueItem4);}

	public function testCompare1():Void{assertTrue("Item must equare:", compareItem1===queueItem1);}
	public function testCompare2():Void{assertTrue("Item must equare:", compareItem2===queueItem2);}
	public function testCompare3():Void{assertTrue("Item must null", compareItem3==null);}
	public function testNext():Void{
		var itemCount:Number = que.next();
		assertTrue("test Item left",itemCount==1);
	}

	public function testItem0_2():Void{assertTrue('item must match QueueItem1',que.getItemAt(0)['func']===setQueueItem4);}
	public function testCompare3_2():Void{assertTrue("Item must equare:", compareItem3===queueItem3);}

	public function testNext_2():Void{
		var itemCount:Number = que.next();
		assertTrue('test Item left',itemCount==0);
	}

	public function testItem0_3():Void{assertTrue('item must match QueueItem1',que.getItemAt(0)['func']==null);}
	public function testCompare4():Void{assertTrue("Item must equare:", compareItem4===queueItem4);}
/*


	public function testNext1():Void{
		var itemLeft:Number = que.next();
		assertTrue("Item must left 2:", itemLeft==2);
	}
	
	public function testCompare2():Void{
		que.next();
		assertTrue("Item must equare:", compareItem2===queueItem2);
	}

	public function testCompare3():Void{
		assertTrue("Item must equare:", compareItem3===queueItem3);
	}*/
}
