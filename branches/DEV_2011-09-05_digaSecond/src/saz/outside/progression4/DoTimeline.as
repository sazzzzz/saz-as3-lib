package saz.outside.progression4 {
	import flash.display.MovieClip;
	import flash.events.Event;
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
	import saz.display.FrameAction;
	
	/**
	 * MovieClipのタイムラインをコマンドとして扱う.
	 * @author saz
	 */
	public class DoTimeline extends SerialList {
		
		/**
		 * 対象MovieClip. 
		 */
		public var target:MovieClip;
		
		/**
		 * 再生開始するフレームラベル. 
		 */
		public var startLabel:String = "start";
		
		/**
		 * 再生完了するフレームラベル. 
		 */
		public var completeLabel:String = "complete";
		
		/**
		 * completeLabelで指定したラベルに到達した時に、停止するかどうか. 
		 */
		public var autoStop:Boolean = true;
		
		
		
		private var _frameAction:FrameAction;
		
		/**
		 * 新しい DoTimeline インスタンスを作成します。
		 */
		public function DoTimeline( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
			
			var self:DoTimeline = this;
			// 実行したいコマンド群を登録します。
			addCommand(
				function():void {
					_frameAction = new FrameAction(target);
					if (_frameAction.labelToFrame(startLabel) == 0 || _frameAction.labelToFrame(completeLabel) == 0)
						throw new Error("DoTimeline.DoTimeline ラベルが存在しません");
					if (_frameAction.labelToFrame(startLabel) > _frameAction.labelToFrame(completeLabel))
						throw new Error("DoTimeline.DoTimeline ラベルの順番が逆です");
					
					_frameAction.addAction(completeLabel, function():void {
						if (self.autoStop) target.stop();
						self.dispatchEvent(new Event("resume"));
					});
					this.listen(self, "resume");
					target.gotoAndPlay(startLabel);
				}
			);
		}
		
		/**
		 * インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。
		 */
		override public function clone():Command {
			return new DoTimeline( this );
		}
	}
}
