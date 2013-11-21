package saz.observ
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * メソッドの値を監視する。
	 * @author saz
	 * 
	 */
	public class MethodWatcher extends WatcherBase
	{
		
		public var param:Array;
		public var paramFunc:Function;
		
		
		/**
		 * コンストラクタ。
		 * 
		 * @param watchTarget	監視対象のオブジェクト。
		 * @param methodName	監視対象メソッド名。
		 * @param param	メソッドに与える引数をArrayで指定。
		 * @param paramFunc	メソッドに与える引数を生成する関数を指定。
		 * @param readySoon	trueだとすぐにready()する。
		 * 
		 */
		public function MethodWatcher(watchTarget:Object, methodName:String, methodParam:Array=null, paramFunc:Function=null, readySoon:Boolean=true)
		{
			this.param = methodParam;
			this.paramFunc = paramFunc;
			
			super(watchTarget, methodName, readySoon);
		}
		
		override protected function getValue():Object
		{
			var args:Array = (paramFunc != null) ? paramFunc() : param || null;
			return target[name].apply(null, args);
		}
		
	}
}