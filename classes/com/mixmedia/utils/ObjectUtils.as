
/**
 * @author colin
 */
class com.mixmedia.utils.ObjectUtils {
	private function isObjectInstanceOfType(obj:Object,type:Function):Boolean{
		//handle primitive types
		if(type==String  && typeof(obj) == "string")  return true;
		if(type==Number  && typeof(obj) == "number")  return true;
		if(type==Boolean && typeof(obj) == "boolean") return true;
		if(type==Object  && typeof(obj) == "object")  return true;
		if(type==Function&& typeof(obj) == "function")return true;
		
		return obj instanceof type;
	}
}
