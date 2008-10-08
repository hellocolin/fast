//****************************************************************************
//Copyright (C) 2003-2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

/**
The Delegate class creates a function wrapper to let you run a function in the context
of the original object, rather than in the context of the second object, when you pass a
function from one object to another.
*/

class mx.utils.Delegate extends Object
{
	/**
	Creates a functions wrapper for the original function so that it runs 
	in the provided context.
	@parameter obj Context in which to run the function.
	@paramater func Function to run.
	*/
	static function create(obj:Object, funct:Function):Function
	{
		var f:Function = function():Function
		{
			var target:Object = arguments.callee['target'];
			var func:Function = arguments.callee['func'];

			return func['apply'](target, arguments);
		};

		f['target'] = obj;
		f['func'] = funct;

		return f;
	}

	function Delegate(f:Function)
	{
		funct = f;
	}

	private var funct:Function;

	function createDelegate(obj:Object):Function
	{
		return create(obj, funct);
	}
}
