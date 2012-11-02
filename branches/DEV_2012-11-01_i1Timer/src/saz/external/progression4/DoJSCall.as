package saz.external.progression4 {
	import jp.progression.casts.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	import jp.progression.commands.managers.*;
	import jp.progression.commands.media.*;
	import jp.progression.commands.net.*;
	import jp.progression.commands.tweens.*;
	import jp.progression.commands.*;
	import jp.progression.data.*;
	import jp.progression.events.*;
	import jp.progression.scenes.*;
	import net.takimo.delegates.*;
	import net.takimo.events.*;
	
	/**
	 * JSCallコマンド. もちろんJSDelegateが必要.
	 * @author saz
	 * @see	http://thinkit.co.jp/story/2010/10/06/1748?page=0,1
	 * @see	http://github.com/takimo/as3jsdelegate
	 */
	public class DoJSCall extends Command {
		
		public static var delegate:JSDelegate;
		
		public var method:String;
		public var params:*;
		
		private var $call:JSCall;
		
		/**
		 * 新しい DoJSCall インスタンスを作成します。
		 * @param	methodName
		 * @param	jsParams
		 * @param	initObject
		 */
		public function DoJSCall( methodName:String, jsParams:* = null, initObject:Object = null ) {
			if (methodName) method = methodName;
			if (jsParams) params = jsParams;
			
			// 親クラスを初期化します。
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 
			//executeComplete();
			if (!delegate) delegate = new JSDelegate();
			
			if (!$call) {
				$call = new JSCall(method, params);
			}else {
				$call.method = method;
				$call.params = params;
			}
			$call.addEventListener(JSCallEvent.RECIVE, $call_recive);
			delegate.execute($call);
		}
		
		private function $call_recive(e:JSCallEvent):void {
			latestData = e.result;
			executeComplete();
		}
		
		/**
		 * 中断されるコマンドの実装です。
		 */
		private function _interrupt():void {
			$call.removeEventListener(JSCallEvent.RECIVE, $call_recive);
		}
		
		/**
		 * インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。
		 */
		override public function clone():Command {
			return new DoJSCall( null, null, this );
		}
		
		public function get call():JSCall {
			if (!$call) $call = new JSCall(method, params);
			return $call;
		}
		
	}
}
