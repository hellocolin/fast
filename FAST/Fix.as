import mx.utils.Delegate;/** * @author colin */class Fix{	static function ref(obj:Object, funct:Function):Function{		return Delegate.create(obj, funct);			}}