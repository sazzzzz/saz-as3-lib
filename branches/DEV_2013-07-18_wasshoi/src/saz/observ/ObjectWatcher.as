package saz.observ
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import saz.events.WatchEvent;
	
	public class ObjectWatcher extends EventDispatcher
	{
		
		public var target:Object;
		
		private var props:Array = [];
		private var methods:Array = [];
		
		public function ObjectWatcher(targetObj:Object)
		{
			super();
			
			target = targetObj;
		}
		
		
		public function addProperty(name:String):void
		{
			var pw:PropertyWatcher = new PropertyWatcher(target, name);
			pw.addEventListener(WatchEvent.CHANGE, _property_change);
			props.push(pw);
		}
		
		public function addMethod(name:String, param:Array=null, paramFunc:Function=null):void
		{
			var mw:MethodWatcher = new MethodWatcher(target, name, param, paramFunc);
			mw.addEventListener(WatchEvent.CHANGE, _method_change);
			methods.push(mw);
		}
		
		public function check():Boolean
		{
			return checkProps() || checkMethods();
		}
		
		
		
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