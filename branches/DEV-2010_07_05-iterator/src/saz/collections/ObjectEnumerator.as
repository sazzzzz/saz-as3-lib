package saz.collections {
	/**
	 * IEnumerator インターフェースを持つ Array ラッパ。
	 * @author saz
	 */
	public class EnumeratorObject implements IEnumerator{
		
		private var $component:Object;
		
		/**
		 * コンストラクタ。
		 * @param	component	対象とするObjectインスタンス。
		 * @example <listing version="3.0" >
		 * var enum:EnumeratorObject = new EnumeratorObject(obj);
		 * </listing>
		 */
		public function EnumeratorObject(component:Object) {
			$component = component;
		}
		
		/* INTERFACE saz.collections.IEnumerator */
		
		public function forEach(callback:Function, thisObject:* = null):void {
			var i:int = -1;
			for each(var item:* in $component) {
				i++;
				//callback.apply(thisObject, [item, i, $component]);
				callback.apply(thisObject, [item, i, this]);
			}
		}
		
		/*
		// for,for in,for each,forEach速度比較
		// http://wonderfl.net/c/fx0A
		
		Array for:25
		Array for in:763
		Array for each:11		// for eachはやい！
		Array forEach1:17
		Array forEach2:34
		5
		Vector for:25
		Vector for in:286
		Vector for each:11
		Vector forEach1:16
		Vector forEach2:34
		5
		*/
		
	}

}