package saz.collections {
	/**
	 * インスタンス参照をidで管理する. 適当版. 同じオブジェクトが複数登録できてしまうなど、要改良. 
	 * jp.nium.collections.IdGroupCollectionのマネ. 
	 * 
	 * @author saz
	 * @see	http://asdoc.progression.jp/4.0/jp/nium/collections/IdGroupCollection.html
	 */
	public class IdCollection {
		
		private static var $instance:IdCollection = null;
		
		private var _items:Object;
		
		public function IdCollection(caller:Function = null) {
			if (IdCollection.getInstance != caller) {
				throw new Error("IdCollectionクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != IdCollection.$instance) {
				throw new Error("IdCollectionインスタンスはひとつしか生成できません。");
			}
			
			//ここからいろいろ書く
			_items = { };
		}
		
		/**
		 * アイテムを登録する. あるいは削除する. 
		 * @param	item	対象アイテム. 
		 * @param	id	登録するid. 指定しない場合は、アイテムを削除する. 
		 * @return	成功すればtrue、失敗すればfalse. 
		 */
		public function register(item:*, id:String = null):Boolean {
			if (item == null) throw new ArgumentError("IdCollection.register():引数が正しくありません。");
			if (getItem(id) != null) return false;
			
			if (id != null) {
				_items[id] = item;
			}else {
				for (var name:String in _items) {
					if (_items[name] == item) delete _items[name];
				}
			}
			return true;
		}
		
		/**
		 * 登録されているアイテムを返す. 
		 * @param	id	id.
		 * @return	指定アイテム. 存在しなければnullを返す. 
		 */
		public function getItem(id:String):* {
			if (id == null) return null;
			
			return _items[id];
		}
		
		
		/**
		 * インスタンスを生成する。
		 * @return
		 */
		public static function getInstance():IdCollection {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new IdCollection(arguments.callee);
			}
			return $instance;
		}
		
	}
}	
	
