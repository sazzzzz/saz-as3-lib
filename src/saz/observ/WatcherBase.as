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
	public class WatcherBase extends EventDispatcher
	{

		/**
		 * 監視対象のオブジェクト。
		 */
		public var target:Object;
		
		/**
		 * 監視対象プロパティ名。
		 */
		public var name:String = "";
		

		/**
		 * 前の値。
		 * @return 
		 * 
		 */
		final public function get oldValue():Object
		{
			return _oldValue;
		}
		private var _oldValue:Object;
		

		/**
		 * 最新の値。
		 * @return 
		 * 
		 */
		final public function get newValue():Object
		{
			return _newValue;
		}
		private var _newValue:Object;

		private var isReady:Boolean = false;

		
		/**
		 * コンストラクタ。
		 * @param watchTarget
		 * @param propName
		 * 
		 */
		public function WatcherBase(watchTarget:Object, name:String, readySoon:Boolean=true)
		{
			super();
			
			this.target = watchTarget;
			this.name = name;
			
			if (readySoon) ready();
		}
		
		/**
		 * プロパティチェック前の準備を行う。
		 * 
		 */
		final public function ready():void
		{
			if (isReady) return;
			
			isReady = true;
			_oldValue = getValue();
			_newValue = _oldValue;
		}
	
		/**
		 * プロパティのチェックを行う。
		 * @return 前回から変更があればtrue、なければfalse。
		 * 
		 */
		final public function check():Boolean
		{
			if (!isReady) throw new Error("check()の前にready()を実行してください。");
			
			_oldValue = _newValue;
			_newValue = getValue();
			
			if (_oldValue != _newValue) dispatch();
			return _oldValue != _newValue;
		}
		
		
		final protected function dispatch():void
		{
			dispatchEvent(new WatchEvent(WatchEvent.CHANGE, name, _oldValue, _newValue));
		}
		
		
		
		
		
		//--------------------------------------
		// subclass
		//--------------------------------------
		
		
		
		protected function getValue():Object
		{
			return null;
		}
		
	}
}