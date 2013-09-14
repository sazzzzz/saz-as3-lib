package saz.observ
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import saz.events.WatchEvent;
	
	/**
	 * プロパティとメソッドをまとめてウォッチ。
	 * @author saz
	 * 
	 */
	public class ObjectWatcher extends EventDispatcher implements IObjectWatcher
	{
		
		public var target:Object;
		
		private var props:Array = [];
		private var methods:Array = [];
		
		/**
		 * コンストラクタ。
		 * @param targetObj	ウォッチ対象オブジェクト。
		 * 
		 */
		public function ObjectWatcher(targetObj:Object)
		{
			super();
			
			target = targetObj;
		}
		
		
		
		public function ready():void
		{
			props.forEach(function(item:WatcherBase, index:int, arr:Array):void
			{
				item.ready();
			});
			methods.forEach(function(item:WatcherBase, index:int, arr:Array):void
			{
				item.ready();
			});
		}
		
		
		/**
		 * 登録されている全てのプロパティ、メソッドの値のチェックを行う。
		 * @return 
		 * 
		 */
		public function check():Boolean
		{
			return checkProps() || checkMethods();
		}
		
		
		
		/**
		 * ウォッチするプロパティを追加。
		 * @param name
		 * 
		 */
		public function addProperty(name:String):void
		{
			var pw:PropertyWatcher = new PropertyWatcher(target, name);
			pw.addEventListener(WatchEvent.CHANGE, _property_change);
			props.push(pw);
		}
		
		/**
		 * ウォッチするプロパティをまとめて追加。
		 * @param names
		 * 
		 */
		public function addProperties(names:Array):void
		{
			names.forEach(function(item:String, index:int, arr:Array):void
			{
				addProperty(item);
			});
		}
		
		
		
		/**
		 * ウォッチするメソッドを追加。
		 * @param name
		 * @param param
		 * @param paramFunc
		 * 
		 */
		public function addMethod(name:String, param:Array=null, paramFunc:Function=null):void
		{
			var mw:MethodWatcher = new MethodWatcher(target, name, param, paramFunc);
			mw.addEventListener(WatchEvent.CHANGE, _method_change);
			methods.push(mw);
		}
		
		/**
		 * ウォッチするメソッドをまとめて追加。
		 * @param names
		 * @param params
		 * @param paramFuncs
		 * 
		 */
		public function addMethods(names:Array, params:Array=null, paramFuncs:Array=null):void
		{
			names.forEach(function(item:String, index:int, arr:Array):void
			{
				addMethod(item, (params != null) ? params[index] : null, (paramFuncs != null) ? paramFuncs[index] : null);
			});
		}
		
		
		
		
		//--------------------------------------
		// private
		//--------------------------------------
		
		
		
		private function checkProps():Boolean
		{
			var res:Boolean = false;
			
			props.forEach(function(item:WatcherBase, index:int, arr:Array):void
			{
				res = res || item.check();
			});
			
			return res;
		}
		
		private function checkMethods():Boolean
		{
			var res:Boolean = false;
			
			methods.forEach(function(item:WatcherBase, index:int, arr:Array):void
			{
				res = res || item.check();
			});
			
			return res;
		}
		
		
		
		
		protected function _property_change(event:Event):void
		{
			dispatchEvent(event);
		}
		
		protected function _method_change(event:Event):void
		{
			dispatchEvent(event);
		}		
	}
}