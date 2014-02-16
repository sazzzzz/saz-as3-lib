package saz.model {
	import saz.events.WatchEvent;
	/**
	 * ValueHolerに対し、バインディング実行するユーティリティメソッドを定義. <br/>
	 * 仕様に関しては、mx.binding.utils.BindingUtilsを参考にした. <br/>
	 * @author saz
	 * @see	http://livedocs.adobe.com/flex/3_jp/langref/mx/binding/utils/BindingUtils.html
	 */
	public class ValueBindingUtil {
		
		/**
		 * site オブジェクトのパブリックプロパティ prop を、ValueHolderにバインド. <br/>
		 * @param	site	バインドされるプロパティを定義するオブジェクトです。
		 * @param	prop	バインドされる site オブジェクトに定義されているパブリックプロパティの名前です。
		 * @param	host	監視対象のValueHolderインスタンスです。
		 * @return	ValueWatcherインスタンス。
		 */
		static public function bindProperty(site:Object, prop:String, host:IValue):ValueWatcher {
			var w:ValueWatcher = new ValueWatcher(host,
				function(e:WatchEvent):void {
					site[prop] = e.newValue;
				}
			);
			return w;
		}
		
		/**
		 * setter 関数を、ValueHolderにバインド. <br/>
		 * @param	setter	値が変更されたときに、chain の現在の値を引数として指定して呼び出す setter メソッドです。
		 * @param	host	監視対象のValueHolderインスタンスです。
		 * @return	ValueWatcherインスタンス。
		 */
		static public function bindSetter(setter:Function, host:IValue):ValueWatcher {
			var w:ValueWatcher = new ValueWatcher(host,
				function (e:WatchEvent):void {
					//trace("ValueBindingUtil.bindSetter(", arguments);
					setter(e.oldValue, e.newValue);
				}
			);
			return w;
		}
		
	}

}