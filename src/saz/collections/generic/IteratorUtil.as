package saz.collections.generic
{
	public class IteratorUtil
	{
		
		/**
		 * IIteratorをArrayにして返す. 
		 * @param iterator	IIteratorの実装インスタンス. 
		 * @return iteratorの各要素を格納した配列. 
		 * 
		 */
		static public function toArray(iterator:IIterator):Array{
			var res:Array = [];
			while(iterator.next()){
				res.push(iterator.current);
			}
			return res;
		}
		
		
		
		/**
		 * いわゆるeach. 
		 * @param iterator
		 * @param callback	引数はArray#forEachと同じ. <br/>
		 * function(item:*, index:int, collection:IIterator):void
		 * 
		 */
		static public function forEach(iterator:IIterator, callback:Function):void{
			var index:int = 0;
			while(iterator.next()){
				callback(iterator.current, index, iterator);
			}
		}
		
	}
}