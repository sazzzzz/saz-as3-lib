package saz.collections.generic
{
	/**
	 * IIteratorを逆順にするIteratorDecorator. 
	 * @author saz
	 * 
	 */
	public class ReverseIteratorDecorator implements IIterator
	{
		
		private var _source:IIterator;
		private var _arr:Array;
		private var _arrIterator:IIterator;
		
		private var _inited:Boolean = false;
		
		
		
		/**
		 *コンストラクタ.  
		 * @param source	対象の（decorateする）IIterator.
		 * 
		 */
		public function ReverseIteratorDecorator(source:IIterator)
		{
			_source = source;
		}
		
		
		private function _init():void{
			_inited = true;
			
			_arr = IteratorUtil.toArray(_source);
			_arr.reverse();
			_arrIterator = new ArrayIterator(_arr);
		}
		
		
		public function get current():*
		{
			if (!_inited) _init();
			return _arrIterator.current;
		}
		
		public function next():Boolean
		{
			if (!_inited) _init();
			return _arrIterator.next();
		}
		
		public function reset():void
		{
			if (!_inited) _init();
			_arrIterator.reset();
		}
	}
}