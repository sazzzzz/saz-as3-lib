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
	}
}