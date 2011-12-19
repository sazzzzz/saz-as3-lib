package saz.collections.generic
{
	import flash.errors.IllegalOperationError;

	public class ArrayIterator implements IIterator
	{
		private var _target:Array;
		private var _targetLength:int;
		private var _index:int = -1;
		
		/**
		 * コンストラクタ. 
		 * @param target	対象とするArray（コレクション）インスタンス. 
		 * 
		 * @example <listing version="3.0" >
		 * // Iteratorはダミークラス
		 * var i:IIterator = new ArrayIterator(collection);
		 * var item;
		 * while(i.next()){
		 *   item = i.current;
		 *   // do something...
		 *   
		 * }
		 * </listing>
		 */		
		public function ArrayIterator(target:Array)
		{
			_target = target;
			_targetLength = target.length;
			
			// for in に対応する試み…
			/*for(var i:int = 0, n:int = target.length; i < n; i++){
				//this["" + i] = target[i];								// #1056: saz.collections.generic.ArrayIterator のプロパティ 0 を作成できません。
				this.prototype["" + i] = target[i];					// #1119: 未定義である可能性が高いプロパティ prototype に静的型 saz.collections.generic:ArrayIterator の参照を使用してアクセスしています。
			}*/
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