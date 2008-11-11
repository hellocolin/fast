
/**
 * @author colin
 */
class com.mixmedia.utils.DataCollection {
	//This class act like a dictionary to easier retrive object by key
	//TO USE:
	//Add item to the dictionary
	//DataCollection.instance().addItemWithKey(item, class, key);
	//get item from the dictionary
	//DataCollection.instance().getItemsWithKey(class,key);
	 
	static private var ins:DataCollection;
	static public function instance():DataCollection{
		if(ins==null)ins = new DataCollection();
		return ins;
	}

	private var dict:Array;
	private var types:Array;
	private function DataCollection(){
		dict =[];
		types=[];
	}
	
	public function addItemWithKey(item:Object,type:Function,key:String):Void{
		if((item instanceof type)!=true){
			trace('type mismatch in Collection.as: '+item+" , "+type.valueOf());
			return;
		};

		key = (key ==null)?'noKey':key;
		var t:Number = getIdByTypeInDict(type);
		if(dict[t][key]==null)dict[t][key] = [];
		dict[t][key].push(item);
	}
	
	public function getItemsWithKey(type:Function,key:String):Array{
		var t:Number = getIdByTypeInDict(type);
		return dict[t][key];
	}
	
	public function clear(type:Function,key:String):Void{
		var t:Number = getIdByTypeInDict(type);
		if(key!=null){
			dict[t][key] = null;
		}else{
			dict[t] = null;
		}
	}
	
	private function getIdByTypeInDict(type:Function):Number{
		for(var i:Number=0;i<types.length;i++){
			if(types[i]===type)return i;
		}
		
		types.push(type);
		dict.push({});
		return dict.length-1;
	}
}
