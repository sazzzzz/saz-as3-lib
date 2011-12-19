package saz.collections.generic
{
	import flash.errors.IllegalOperationError;
	
	/**
	 * IIteratorを指定回数リピートするIterator(Decorator). 
	 * @author saz
	 * 
	 */
	public class RepeatIteratorDecorator implements IIterator
	{
		
		/**
		 * ゼロで開始してから現在までにループした回数.  
		 */
		private var _count:int = 0;
		public function get count():int
		{
			return _count;
		}
		
		
		/**
		 * ループする回数.<br/>
		 * 1なら1回だけ（＝通常のIIteratorと同じ動作）. 0を指定すると永遠にループ. 
		 */
		private var _repeatCount:int = 0;
		public function get repeatCount():int
		{
			return _repeatCount;
		}
		public function set repeatCount(value:int):void
		{
			if(value < 0)throw new ArgumentError("repeatCountは0以上を指定してください。");
			_repeatCount = value;
		}
		
		
		
		private var _source:IIterator;
		
		private var _arr:Array;
		private var _sourceLength:int;
		private var _index:int = -1;
		
		private var _inited:Boolean = false;
		
		
		/**
		 * コンストラクタ. 
		 * @param source	対象の（decorateする）IIterator. 
		 * @param repeat	ループする回数.
		 * 
		 */
		public function RepeatIteratorDecorator(source:IIterator, repeat:int = 0)
		{
			_source = source;
			repeatCount = repeat;
		}
		
		
		private function _init():void{
			_inited = true;
			
			_arr = IteratorUtil.toArray(_source);
			_sourceLength = _arr.length;
		}
		
		
		public function get current():*
		{
			if (!_inited) _init();
			
			return _arr[_index];
		}
		
		public function next():Boolean
		{
			if (!_inited) _init();
			
			_index++;
			if(_index >= _sourceLength){				// 末尾を過ぎた
				_count++;
				/*if (_repeatCount == 0) {	// 無限ループ
					_index = 0;
				} else {					// 無限じゃない
					if (_count < _repeatCount){		// ループする
						_index = 0;
					}else{							// 終了
						return false;
					}
				}*/
				if (_repeatCount == 0 || (_repeatCount > 0 && _count < _repeatCount)){
					_index = 0;
				}else{
					return false;
				}
			}
			return true;
		}
		
		public function reset():void
		{
			if (!_inited) _init();
			
			_index = -1;
			_count = 0;
		}
	}
}