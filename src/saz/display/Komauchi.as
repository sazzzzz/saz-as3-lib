package saz.display
{
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * MovieClipのタイムラインアニメーションのコマを落とす。コマ打ち。
	 * @author saz
	 * 
	 * @see	http://www.wgn.co.jp/cgw/ozawa/110/
	 */
	public class Komauchi
	{
		
		public var target:MovieClip;
		public var koma:int = 3;
		
		private var _frame:int;
		private var _count:int;
		
		
		/**
		 * コンストラクタ。
		 * @param movieclip	対象MovieClip。
		 * @param skipKoma	何コマ飛ばすか。2コマ打ちなら2、3コマ打ちなら3を指定。
		 * 
		 */
		public function Komauchi(movieclip:MovieClip, skipKoma:int)
		{
			target = movieclip;
			koma = skipKoma;
		}
		
		/**
		 * 開始。
		 */
		public function begin():void
		{
			target.nextFrame();
			_count = 0;
			_frame = target.currentFrame;
			
			target.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		/**
		 * 停止。
		 */
		public function end():void
		{
			target.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		
		protected function _onEnterFrame(event:Event):void
		{
			_count++;
			if (_count < koma) return;
			
			_count = 0;
			_frame = Math.min(_frame + koma, target.totalFrames);
			target.gotoAndStop(_frame);
			
			// タイムラインの終わりまできたら自動で停止。
			if (_frame >= target.totalFrames) end();
		}
	}
}