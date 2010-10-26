package saz.test {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	/**
	 * テスト用出力。まとめて1フレームごとに出力。
	 * @author saz
	 */
	public class Log {
		
		static public var isTrace:Boolean = true;
		static public var isFirebug:Boolean = false;
		
		static private var $dsp:DisplayObject;
		static private var $msgs:String = "";
		static private var $isUpdate:Boolean = false;
		
		static public function init(dsp:DisplayObject):void {
			$dsp = dsp;
			start();
		}
		
		static public function start():void {
			$dsp.addEventListener(Event.ENTER_FRAME, $loop);
		}
		
		static public function stop():void {
			$dsp.removeEventListener(Event.ENTER_FRAME, $loop);
		}
		
		static public function log(value:*):void {
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
				if (isFirebug) ExternalInterface.call("console.log", $msgs);
				$isUpdate = false;
				$msgs = "";
			}
		}
		
	}

}