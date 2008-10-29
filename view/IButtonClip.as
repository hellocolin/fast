
/**
 * @author Colin
 */
interface IButtonClip extends IEventDispatcher{
	function addElement(element:IButtonElement):Void;
	function getElements():Array;
	function select():Void;
	function setMouseOverDelay(num:Number):Void;
	function clearMouseOver():Void;
	function setMouseOutDelay(num:Number):Void;
	function clearMouseOut():Void;
}
