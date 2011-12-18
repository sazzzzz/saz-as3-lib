package saz.collections.generic
{
	import flash.errors.IllegalOperationError;
	
	public class ObjectIterator implements IIterator
	{
		private var _target:Object;
		//private var _index:int = -1;
		
		//private var _array:Array;
		private var _iterator:IIterator;
		private var _inited:Boolean = false;
		
		public function ObjectIterator(target:Object)
		{
			_target = target;
		}
		
		private function _init():void {
			_inited = true;
			//_array = _toArray(_target);
			_iterator = new ArrayIterator(_toArray(_target));
		}
		
		/**
		 * object -> array
		 * @param	obj
		 * @return
		 * 
		 * @see	saz.util.ObjectUtil#toArray
		 */
		private function _toArray(obj:Object):Array {
			// ▽ループ　ActionScript3.0 Flash CS3
			// http://1art.jp/flash9/chapter/125/
			var res:Array = [];
			var item:Object;
			
			// for in
			/*for (var p:String in _target) {
				//
				item = obj[p];
				res.push(item);
			}*/
			
			// for each
			for each(item in _target){
				res.push(item);
			}
			return res;
		}
		
		/**
		 * @see IIterator#current
		 */		
		public function get current():Object
		{
			if (!_inited) _init();
			return _iterator.current;
		}
		
		/**
		 * @see IIterator#next()
		 */		
		public function next():Boolean
		{
			if (!_inited) _init();
			return _iterator.next();
		}
		
		/**
		 * @see IIterator#reset()
		 */		
		public function reset():void
		{
			if (!_inited) _init();
			_iterator.reset();
		}
	}
}