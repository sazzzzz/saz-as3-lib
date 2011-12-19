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
		
		
		/**
		 * コンストラクタ. 
		 * @param target	対象とするObject（コレクション）インスタンス. 
		 * 
		 * @example <listing version="3.0" >
		 * // Iteratorはダミークラス
		 * var i:IIterator = new ObjectIterator(collection);
		 * var item;
		 * while(i.next()){
		 *   item = i.current;
		 *   // do something...
		 *   
		 * }
		 * </listing>
		 */
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
			var res:Array = [];
			var item:Object;
			// for each		for inより早い
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