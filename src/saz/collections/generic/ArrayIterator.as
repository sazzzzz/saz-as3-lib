package saz.collections.generic
{
	import flash.errors.IllegalOperationError;

	public class ArrayIterator implements IIterator
	{
		private var _target:Array;
		private var _targetLength:int;
		private var _index:int = -1;
		
		public function ArrayIterator(target:Array)
		{
			_target = target;
			_targetLength = target.length;
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