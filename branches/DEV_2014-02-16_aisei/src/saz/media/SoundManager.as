package saz.media
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.media.*;
	
	import saz.media.ISoundFacade;
	import saz.media.SoundFacade;

	public class SoundManager
	{
		

		/*public function get playable():Boolean
		{
			return _playable;
		}
		public function set playable(value:Boolean):void
		{
			_playable = value;
		}
		private var _playable:Boolean = true;*/

		
		private var _facs:Object = {};
		private var _datas:Object = {};
		
		
		/**
		 * 
		 * @param data	name, loops, volume, pan, sound
		 * 
		 */
		public function addData(data:Object):void
		{
			var fac:ISoundFacade;
			if (data.sounds)
			{
				fac = new MultipleSoundFacade();
				MultipleSoundFacade(fac).setDetectCallback(_makeMultiCallback());
				data.sounds.forEach(function(item:Sound, index:int, arr:Array):void
				{
					MultipleSoundFacade(fac).addFacade(new SoundFacade(item));
				});
			}else{
				fac = new SoundFacade(data.sound);
			}
			
			fac.volume = data.volume;
			fac.pan = data.pan;
			
			_addEntity(data.name, {facade:fac});
			_datas[data.name] = data;
		}
		
		public function setDatas(datas:Array):void
		{
			datas.forEach(function(item:Object, index:int, arr:Array):void
			{
				addData(item);
			});
		}
		
		
		/**
		 * 存在チェック。
		 * @param name
		 * @return 
		 * 
		 */
		public function having(name:String):Boolean
		{
			return _getEntiry(name) != null;
		}
		
		
		/**
		 * nameが有効かどうか。
		 * @param name
		 * @return 
		 * 
		 */
		public function valid(name:*):Boolean
		{
			return name != null && name != "" && having(name);
		}
		
		
		// 名前に別名をつけられるといいんじゃね？
		public function getFacade(name:String):ISoundFacade
		{
			if (!having(name))
			{
				trace("SoundManager.getFacade(", name, "サウンドが見つからない");
				return null;
			}
			return _getEntiry(name).facade;
		}
		
		public function getData(name:String):Object
		{
			return _datas[name];
		}
		
		
		
		//--------------------------------------
		// play controll
		//--------------------------------------
		
		public function play(name:String):ISoundFacade
		{
			if (!valid(name)) return null;
			
			var fac:ISoundFacade = getFacade(name);
			var dat:Object = getData(name);
			fac.play(0, dat.loops);
			return fac;
		}
		
		
		public function stop(name:String):ISoundFacade
		{
			if (!valid(name)) return null;
			
			var fac:ISoundFacade = getFacade(name);
			fac.stop();
			return fac;
		}
		
		
		
		
		public function attachSound(name:String, dispatcher:IEventDispatcher, eventType:String):void
		{
			// FIXME	detatchが必要だよね…
			if (!having(name))
			{
				trace("SoundManager.attachSound(", name, dispatcher, eventType, "サウンドが見つからない");
				return;
			}
			
			var e:Object = _getEntiry(name);
			
			var listener:Function = function(event:Event):void
			{
				SoundManager.getInstance().play(name);
			};
			dispatcher.addEventListener(eventType, listener);
			
			e.attach ||= [];
			e.attach.push({dispatcher:dispatcher, eventType:eventType, listener:listener});
		}
		
		
		
		
		
		
		
		//--------------------------------------
		// private
		//--------------------------------------
		
		
		private function _makeMultiCallback():Function
		{
			var prev:int = -1;
			return function _defaultDetector(facades:Array):SoundFacade
			{
				var index:int;
				do {
					index = Math.floor(Math.random() * facades.length);
				} while(index == prev);
				prev = index;
				return facades[index];
			}			
		}
		
		
		private function _addEntity(name:String, obj:Object):void
		{
			_facs[name] = obj;
		}
		
		private function _getEntiry(name:String):Object
		{
			return _facs[name];
		}
		
		
		
		
		
		
		private static var _instance:SoundManager = null;
		
		public function SoundManager(caller:Function = null) {
			if (caller != SoundManager.getInstance) {
				throw new Error("SoundManagerクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != SoundManager._instance) {
				throw new Error("SoundManagerインスタンスはひとつしか生成できません。");
			}
			//ここからいろいろ書く
		}
		
		/**
		 * インスタンスを生成する. 
		 * @return	インスタンス. 
		 */
		public static function getInstance():SoundManager {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == _instance) {
				_instance = new SoundManager(arguments.callee);
			}
			return _instance;
		}
	}
}