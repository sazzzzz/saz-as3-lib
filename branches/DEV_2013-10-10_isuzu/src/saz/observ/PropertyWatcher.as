package saz.observ
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import saz.events.WatchEvent;
	
	/**
	 * プロパティの値を監視する。
	 * @author saz
	 * 
	 */
	public class PropertyWatcher extends WatcherBase
	{
		
		
		/**
		 * コンストラクタ。
		 * 
		 * @param watchTarget	監視対象のオブジェクト。
		 * @param propName	監視対象プロパティ名。
		 * @param readySoon	trueだとすぐにready()する。
		 * 
		 */
		public function PropertyWatcher(watchTarget:Object, propName:String, readySoon:Boolean=true)
		{
			super(watchTarget, propName, readySoon);
		}
		
		
		
		
		override protected function getValue():Object
		{
			return target[name];
		}
		
		
		
	}
}