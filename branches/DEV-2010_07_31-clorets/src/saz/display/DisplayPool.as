package saz.display {
	import flash.display.*;
	/**
	 * DisplayObjectインスタンスプール。<br />
	 * 作ってはみたけど汎用性が微妙かも…。
	 * @author saz
	 */
	public class DisplayPool {
		
		/**
		 * インスタンス生成メソッド。
		 * @param	index
		 * @return
		 */
		public var atCreate:Function;
		/**
		 * 表示メソッド。
		 * @param	index
		 */
		public var atVisible:Function;
		/**
		 * 非表示メソッド。
		 * @param	index
		 */
		public var atInvisible:Function;
		
		private var $container:DisplayObjectContainer;
		private var $list:Array;
		
		/**
		 * コンストラクタ。
		 * @param	container	addChildするDisplayObjectContainerインスタンス。
		 * @example <listing version="3.0" >
		 * var spool = new DisplayPool(this);
		 * spool.atCreate=function(index:int):Bit{
		 * 	var item:Bit = new Bit();
		 * 	item.x=index*10;
		 * 	return item;
		 * }
		 * trace(spool.gets(0));
		 * trace(spool.gets(5));
		 * spool.setVisibleByIndex(4);
		 * spool.setVisibleByIndex(5);
		 * </listing>
		 */
		public function DisplayPool(container:DisplayObjectContainer = null) {
			$container = container;
			$list = new Array();
			
			atCreate = $atCreate;
			atVisible = $atVisible;
			atInvisible = $atInvisible;
		}
		
		/**
		 * 指定インデックスのインスタンスを返す。なければ作る。
		 * @param	index
		 * @return
		 */
		public function gets(index:int):*{
			if (index < $list.length) {
				return $list[index];
			}else {
				var item:*= atCreate(index);
				$list[index] = item;
				return item;
			}
		}
		
		/**
		 * インスタンス配列。
		 * @return
		 */
		public function getList():Array {
			return $list;
		}
		
		/**
		 * 先頭からn個のインスタンスを表示し、残りは非表示に。
		 * @param	count	表示する個数。
		 */
		public function setVisibleByCount(count:int):void {
			var i:int = 0;
			var len:int = $list.length;
			var item:*;
			while (i < count) {
				item = $list[i];
				atVisible(item, i);
				i++;
			}
			while (i < len) {
				item = $list[i];
				atInvisible(item, i);
				i++
			}
		}
		
		/**
		 * インデックス0～nのインスタンスを表示し、残りは非表示に。
		 * @param	index
		 */
		public function setVisibleByIndex(index:int):void {
			setVisibleByCount(index + 1);
		}
		
		/**
		 * atCreateのデフォルトメソッド。
		 * @param	index	インデックス。
		 * @return
		 */
		private function $atCreate(index:int):Sprite{
			return new Sprite();
		}
		
		/**
		 * $atVisibleのデフォルトメソッド。
		 * @param	item	対象インスタンス。
		 * @param	index	インデックス。
		 */
		private function $atVisible(item:*, index:int):void {
			trace("DisplayPool.$atVisible(", arguments);
			if (null == item) return;
			$container.addChild(item);
		}
		
		/**
		 * $atInvisibleのデフォルトメソッド。
		 * @param	item	対象インスタンス。
		 * @param	index	インデックス。
		 */
		private function $atInvisible(item:*, index:int):void {
			trace("DisplayPool.$atInvisible(", arguments);
			if (null == item) return;
			if (false == $container.contains(item)) return;
			$container.removeChild(item);
		}
		
	}

}