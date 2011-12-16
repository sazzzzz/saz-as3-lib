package saz.collections.generic
{
	import flash.errors.IllegalOperationError;
	
	public class ObjectIterator implements IIterator
	{
		private var _target:Object;
		private var _targetLength:int;
		private var _index:int = -1;
		
		public function ObjectIterator(target:Object)
		{
			_target = target;
			
		}
		
		/**
		 * @see IIterator#current
		 */		
		public function get current():Object
		{
			if(_index >= _targetLength) throw new IllegalOperationError("対象コレクションの末尾を過ぎました。");
			
			return _target[_index];
		}
		
		/**
		 * @see IIterator#next()
		 */		
		public function next():Boolean
		{
			if(_targetLength != _target.length) throw new IllegalOperationError("対象コレクションの要素が変更されました。");
			
			_index++;
			return _index < _targetLength;
		}
		
		/**
		 * @see IIterator#reset()
		 */		
		public function reset():void
		{
			if(_targetLength != _target.length) throw new IllegalOperationError("対象コレクションの要素が変更されました。");
			
			_index = -1;
		}
	}
}