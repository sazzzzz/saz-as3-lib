package saz.external.progression4
{
	import flash.display.*;
	import flash.events.*;
	
	import jp.progression.Progression;
	import jp.progression.casts.*;
	import jp.progression.commands.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	import jp.progression.config.*;
	import jp.progression.core.proto.Configuration;
	import jp.progression.scenes.*;
	
	public class CastChildDocument extends CastDocument
	{
		
		private var _started:Boolean = false;
		
		public function CastChildDocument(managerId:String=null, rootClass:Class=null, config:Configuration=null, initObject:Object=null)
		{
			super(managerId, rootClass, config, initObject);
			
			
//			addEventListener(Event.ADDED_TO_STAGE, _addedToStage);
//			addEventListener(Event.REMOVED_FROM_STAGE, _unload);
//			addEventListener(Event.UNLOAD, _unload);
			
			if(parent != null && parent is Stage) start();
		}
		/**
		 * 処理開始。親から呼ばれる。
		 */
		public function start():void
		{
			if (_started) return;
			_started = true;
			
			_initStage();
			_initLibs();
			_initDisplay();
			_start();
		}
		
		/**
		 * デストラクタ。
		 */
		public function destroy():void
		{
//			removeEventListener(Event.ADDED_TO_STAGE, _addedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, _unload);
			removeEventListener(Event.UNLOAD, _unload);
			
			_destroy();
		}
		
		
		protected function _initProgression(id:String, container:DisplayObjectContainer, rootClass:Class = null, initObject:Object = null):void
		{
			var prog:Progression;
			if (prog != null) return;
			
			Progression.initialize(new WebConfig(null, false, false));
			prog = new Progression(id, container, rootClass, initObject);
		}
		
		//--------------------------------------
		// listners
		//--------------------------------------
		
		protected function _unload(event:Event):void
		{
			destroy();
		}		
		
		protected function _addedToStage(event:Event):void
		{
			start();
		}
		
		//--------------------------------------
		// override
		//--------------------------------------
		
		protected function _initStage():void
		{
		}
		
		protected function _initLibs():void
		{
			
		}
		
		protected function _initDisplay():void
		{
			
		}
		
		protected function _start():void
		{
		}
		
		protected function _destroy():void
		{
		}
	}
}