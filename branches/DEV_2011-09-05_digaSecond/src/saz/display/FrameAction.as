package saz.display {
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import saz.collections.enumerator.Enumerable;
	import saz.IStartable;
	import saz.util.VarDefault;
	
	/**
	 * MovieClipのタイムラインに、フレームアクションを追加する.
	 * gotoAndPlay()で指定したフレームのアクションが実行されない！！！
	 * @author saz
	 * @see	http://blog.img8.com/archives/2009/01/004354.html
	 * @see	http://blog.888-3.com/?eid=900817
	 */
	//public class FrameAction implements IStartable {
	public class FrameAction {
		
		// TODO	拡張案：複数functionを登録可能にするとか
		
		/**
		 * 対象とするMovieClip.
		 */
		public function get target():MovieClip {
			return _target;
		}
		public function set target(value:MovieClip):void {
			_target = value;
		}
		private var _target:MovieClip;
		
		/**
		 * actionを格納するObject.
		 * フレーム番号をキーとして、Functionの配列を格納. 
		 */
		private var _actions:Object;
		private var _labelsEnum:Enumerable;
		
		
		/**
		 * コンストラクタ. 
		 * @param	target	対象とするMovieClip.
		 */
		public function FrameAction(target:MovieClip) {
			this.target = target;
		}
		
		
		private function _frameobjToFrame(frame:Object):int {
			return (frame is String) ? labelToFrame(String(frame)) : int(frame);
		}
		
		/**
		 * ラベル名からフレーム番号を返す.
		 * @param	label	フレームラベル名. 
		 * @return	フレーム番号を返す. ラベルが見つからない場合は0を返す. 
		 */
		public function labelToFrame(label:String):int {
			if (_labelsEnum == null) _labelsEnum = new Enumerable(_target.currentLabels);
			var fl:FrameLabel = _labelsEnum.detect(function(item:FrameLabel, index:int):Boolean {
				return FrameLabel(item).name == label;
			});
			return fl != null ? fl.frame : 0;
		}
		
		/**
		 * フレームアクションを追加する. 
		 * @param	frame	フレーム番号を表す数値、またはフレームのラベルを表すストリング.
		 * @param	func	追加するアクション. 
		 */
		public function addAction(frame:Object, func:Function):void {
			_target.addFrameScript(_frameobjToFrame(frame) - 1, func);
		}
		/*public function addAction(frame:Object, func:Function):void {
			if (_actions == null) _actions = { };
			var frameNum:int = _frameobjToFrame(frame);
			if (_actions[frameNum] == null) _actions[frameNum] = [];
			_actions[frameNum].push(func);
		}*/
		
		/**
		 * フレームアクションを削除する. 
		 * @param	frame	フレーム番号を表す数値、またはフレームのラベルを表すストリング.
		 */
		public function removeAction(frame:Object):void {
			_target.addFrameScript(_frameobjToFrame(frame) - 1, null);
		}
		/**
		 * フレームアクションを削除する. 
		 * @param	frame	フレーム番号を表す数値、またはフレームのラベルを表すストリング.
		 * @param	func	削除するアクション. 省略した場合は、指定フレームのアクションすべてを削除. 
		 * @return
		 */
		/*public function removeAction(frame:Object, func:Function = null):Boolean {
			if (_actions == null) return false;
			var frameNum:int = _frameobjToFrame(frame);
			
			if (func != null) {
				delete _actions[frameNum];
				//_actions[frameNum] = null;
				return true;
			}else {
				var removeIndex:int;
				var funcs:Array = _actions[frameNum];
				funcs.forEace(function(item:Function, index:int, arr:Array):void {
					if (item == func) removeIndex = index;
				});
				if (removeIndex != VarDefault.INT) {
					funcs.splice(removeIndex);
					return true;
				}
			}
			return false;
		}*/
		
		//private function _runFuncs(funcs:Array):void {
			// よくわからんエラーが。フォーカスの関係か？
			// EvalError: Error #1066: function('function body') という書式はサポートされていません。
			/*funcs.forEach(function(item:Function, index:int, arr:Array):void {
				Function(item)();
			});*/
			//for (var i:int = 0, n:int = funcs.length; i < n; i++) {
				//funcs[i]();
			//}
		//}
		
		//private function _testRun():void {
			//if (_actions[_target.currentFrame] == null) return;
			//var funcs:Array = _actions[_target.currentFrame];
			//for (var i:int = 0, n:int = funcs.length; i < n; i++) {
				//funcs[i]();
			//}
		//}
		
		//private function _target_enterFrame(e:Event):void {
			//_testRun();
		//}
		
		
		/* INTERFACE saz.IStartable */
		
		/**
		 * 処理開始.
		 */
		//public function start():void {
			//if (_actions == null) _actions = { };
			//_target.addEventListener(Event.ENTER_FRAME, _target_enterFrame);
		//}
		
		/**
		 * 処理終了.
		 */
		//public function stop():void {
			//_target.removeEventListener(Event.ENTER_FRAME, _target_enterFrame);
		//}
		
		
	}

}