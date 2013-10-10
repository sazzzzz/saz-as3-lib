package saz.test {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	/**
	 * テスト用出力。まとめて1フレームごとに出力。
	 * @author saz
	 * @example <listing version="3.0" >
	 * Log.isFirebug = true;
	 * Log.init(stage);
	 * Log.log("This is test message.");
	 * </listing>
	 */
	public class Log {
		

		/**
		 * メッセージをバッファして、ENTER_FRAMEでまとめて出力するか、すぐに出力するか。
		 * @return 
		 * 
		 */
		/*public static function get isBuffer():Boolean
		{
			return _isBuffer;
		}
		public static function set isBuffer(value:Boolean):void
		{
			_isBuffer = value;
		}
		private static var _isBuffer:Boolean = false;*/
		public static var enableBuffer:Boolean = false;

		
		public static var enableTrace:Boolean = true;
		public static var enableFirebug:Boolean = false;
		
		private static var _running:Boolean = false;
		private static var _dsp:DisplayObject;
		private static var _msgs:Array = [];
		private static var _needPrint:Boolean = false;
		
		static public function get isInit():Boolean {
			return _isInit;
		}
		private static var _isInit:Boolean = false;
		
		/**
		 * 初期化＆処理開始.
		 * @param	dsp
		 */
		public static function init(dsp:DisplayObject):void {
			if (_isInit) return;
			
			_isInit = true;
			_dsp = dsp;
			start();
		}
		
		/**
		 * 出力処理開始. （init()をコールすると自動で開始するので、通常使いません)
		 */
		public static function start():void {
			_running = true;
			_dsp.addEventListener(Event.ENTER_FRAME, $loop);
		}
		
		/**
		 * 出力処理停止. ただし停止中もlog()で受け取ったメッセージは、バッファに溜めてる. 
		 */
		public static function stop():void {
			_running = false;
			_dsp.removeEventListener(Event.ENTER_FRAME, $loop);
		}
		
		/**
		 * 出力. 
		 * @param	value
		 */
		public static function log(value:*):void {
			_needPrint = true;
			_msgs.push(value.toString());
			
			if (_running && !enableBuffer) $print();
		}
		
		private static function $loop(e:Event):void {
			if (_needPrint) {
				$print();
			}
		}
		
		private static function $print():void {
			if (_needPrint) {
				var msg:String = _msgs.join("\r");
				if (enableTrace) trace(msg);
				if (enableFirebug && ExternalInterface.available) ExternalInterface.call("console.log", msg);
				_needPrint = false;
				_msgs.length = 0;
			}
		}
		
		
	}

}