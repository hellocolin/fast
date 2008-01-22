/**
 * @author Colin
 * a queue use hash to identify
 */

class com.mixmedia.utils.Queue {
	private static var insArray:Array=new Array();

	private var requestArray:Array;
	private var needRemoveFirstRequest : Boolean=false;
	
	public static function instance(queueId:Number):Queue{
		if(queueId==null)queueId=0;
		if(insArray==null)insArray = new Array();
		if(insArray[queueId]==null)insArray[queueId]= new Queue();
		return insArray[queueId];
	}

	private function Queue(){
		//creates the array that will contain our loading queue
		requestArray = new Array();
	}

	public function next():Number {
		if(needRemoveFirstRequest==true){
			remove(0);
			needRemoveFirstRequest = false;
		}

		Function(requestArray[0])();
		remove(0);
		return requestArray.length;
	};

	public function addRequest(request:Function):Number{
		//if the queue is empty, do the request immediately.
		//the item must remove by next();
		if (requestArray.length==0){
			needRemoveFirstRequest = true;
			request();
		}
	 	return requestArray.push(request);
	}; 

	public function clear():Void{
	 	//clears the array, so no more loading will be started.
	 	requestArray = new Array();
	};
	
	public static function clearAll():Void{
		for(var i:Number = 0;i<insArray.length;i++){
			insArray[i].clear();
		}
	}
	
	public function addNextRequest(request:Function):Void{
		if(requestArray.length==0){request();}
	 	requestArray.splice(0,0,request);
	}

	public function remove(index:Number):Void{
		requestArray.splice(index,1);
	}

	public function getIndexByReference(request:Function):Number{
		var i:Number;
		for (i=0;i<requestArray.length;i++){
			if (requestArray[i] === request)return i;
		}
		return -1;
	}
	
	public function getItemAt(index:Number):Function{
		return requestArray[index];
	}
	public function getLength():Number{
		return requestArray.length;
	}
}