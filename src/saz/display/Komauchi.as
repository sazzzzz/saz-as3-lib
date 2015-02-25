package saz.display
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import saz.util.DisplayUtil;

	/**
	 * MovieClipのタイムラインアニメーションのコマを落とす。コマ打ち。
	 * @author saz
	 * 
	 * @see	http://www.wgn.co.jp/cgw/ozawa/110/
	 */
	public class Komauchi
	{
		
		/**
		 * 実行中かどうか。
		 * @return 
		 * 
		 */
		public function get running():Boolean
		{
			return _running;
		}
		private var _running:Boolean = false;

		
		/**
		 * 対象MovieClip。
		 */
		public var target:MovieClip;
		
		/**
		 * 何コマ飛ばすか。2コマ打ちなら2、3コマ打ちなら3を指定。
		 */
		public var koma:int = 3;
		
		private var _count:int = 0;
		private var _frame:int = -1;
		private var _endFrame:int = -1;
		
		
		/**
		 * コンストラクタ。
		 * @param movieclip	対象MovieClip。
		 * @param skipKoma	何コマ飛ばすか。2コマ打ちなら2、3コマ打ちなら3を指定。
		 */
		public function Komauchi(movieclip:MovieClip, skipKoma:int)
		{
			target = movieclip;
			koma = skipKoma;
		}
		
		/**
		 * 開始。
		 * @param frameOrLabel	終了フレームを指定。フレーム数をintで指定するか、フレームラベルをStringで指定。
		 */
		public function begin(frameOrLabel:Object=null):void
		{
			_beginCheckError(frameOrLabel);
			if (_running) return;		// すでに実行中なら何もしない
			
			_running = true;
			// 終了フレーム
			_endFrame = (frameOrLabel == null) ? -1 : _toFrameNum(frameOrLabel);
			
			// 初期設定
			//target.nextFrame();		// とりあえず1コマ進める。
			target.stop();
			_count = 0;
			_frame = target.currentFrame;
			
			target.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		
		/**
		 * 停止。
		 */
		public function end():void
		{
			_running = false;
			_count = 0;
			_frame = -1;
			target.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		
		//--------------------------------------
		// LISTENER
		//--------------------------------------
		
		protected function _onEnterFrame(event:Event):void
		{
			// 毎フレーム
			_count++;
			if (_overEndFrame(_frame + _count))
			{
				// endFrameまで来たら動作停止して通常再生。
				end();
				target.gotoAndPlay(_endFrame);
			}
			
			if (_count < koma) return;
			
			// コマ更新時
			_count = 0;
			
			if (_overTotalFrame(_frame + koma))
			{
				// タイムラインの終わりまできたら動作停止してstop()。
				end();
				_updateKoma(target.totalFrames);
			}
			else
			{
				_updateKoma(_frame + koma);
			}
		}
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		
		private function _beginCheckError(frameOrLabel:Object=null):void
		{
			if (frameOrLabel == null) return;
			
			// 終了フレーム
			if (typeof(frameOrLabel) != "string" && typeof(frameOrLabel) != "number")
				throw new ArgumentError("終了フレームを指定が間違っています。フレーム数を数字で指定するか、ラベルをStringで指定してください。");
			
			var f:int = _toFrameNum(frameOrLabel);
			if (!_frameIsValid(f))
			{
				if (frameOrLabel is String) throw new ArgumentError("指定した終了フレームは有効ではない。正しいラベルを指定してください。");
				if (frameOrLabel is int || frameOrLabel is Number) throw new ArgumentError("指定した終了フレームは有効ではない。終了フレームには、1～totalFramesの範囲を指定してください。");
				throw new ArgumentError("指定した終了フレームは有効ではない。");
			}
			if (f < target.currentFrame) throw new ArgumentError("終了フレームには、currentFrameより大きな値を指定してください。");
		}
		
		/**
		 * フレーム数に変換。
		 */
		private function _toFrameNum(frameOrLabel:Object):int
		{
			if (frameOrLabel == null) return -1;
			if (frameOrLabel is int) return frameOrLabel as int;
			if (frameOrLabel is Number) return int(frameOrLabel);
			if (frameOrLabel is String) return DisplayUtil.labelToFrame(target, frameOrLabel as String);
			return frameOrLabel as int;
		}
		
		/**
		 * フレーム数が有効な値か。
		 */
		private function _frameIsValid(frame:int):Boolean
		{
			return 0 < frame && frame <= target.totalFrames;
		}
		
		/**
		 * 終了フレームに到達したか。
		 */
		private function _overEndFrame(frame:int):Boolean
		{
			return -1 < _endFrame && _endFrame <= frame;
		}
		
		/**
		 * タイムラインの終わりを越えているか（指定フレームがtotalFramesより大きいか）。
		 */
		private function _overTotalFrame(frame:int):Boolean
		{
			return target.totalFrames <= frame;
		}
		
		/**
		 * 再生ヘッドを進める。
		 */
		private function _updateKoma(frame:int):void
		{
			_frame = frame;
			target.gotoAndStop(frame);
		}
		
	}
}