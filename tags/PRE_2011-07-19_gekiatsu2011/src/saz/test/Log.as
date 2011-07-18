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
		
		public static var isTrace:Boolean = true;
		public static var isFirebug:Boolean = false;
		
		static private var $dsp:DisplayObject;
		static private var $msgs:String = "";
		static private var $isUpdate:Boolean = false;
		
		/**
		 * 初期化＆処理開始.
		 * @param	dsp
		 */
		public static function init(dsp:DisplayObject):void {
			$dsp = dsp;
			start();
		}
		
		/**
		 * 出力処理開始. （init()をコールすると自動で開始するので、通常使いません)
		 */
		public static function start():void {
			$dsp.addEventListener(Event.ENTER_FRAME, $loop);
		}
		
		/**
		 * 出力処理停止. ただし停止中もlog()で受け取ったメッセージは、バッファに溜めてる. 
		 */
		public static function stop():void {
			$dsp.removeEventListener(Event.ENTER_FRAME, $loop);
		}
		
		/**
		 * 出力. 
		 * @param	value
		 */
		public static function log(value:*):void {
			$isUpdate = true;
			$msgs += value.toString() + "\r";
		}
		
		static private function $loop(e:Event):void {
			if ($isUpdate) {
				$print();
			}
		}
		
		static private function $print():void {
			if ($isUpdate) {
				if (isTrace) trace($msgs);
				if (isFirebug && ExternalInterface.available) ExternalInterface.call("console.log", $msgs);
				$isUpdate = false;
				$msgs = "";
			}
		}
		
	}

}