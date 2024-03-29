package saz.external.progression4 {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import jp.nium.utils.ObjectUtil;
	import jp.progression.casts.*;
	import jp.progression.commands.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	import jp.progression.commands.managers.*;
	import jp.progression.commands.media.*;
	import jp.progression.commands.net.*;
	import jp.progression.commands.tweens.*;
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
		/*public var completeLabel:String = "complete";*/
		public var endLabel:String = "end";
		
		/**
		 * completeLabelで指定したラベルに到達した時に、停止するかどうか. 
		 */
		public var autoStop:Boolean = true;
		
		/**
		 * targetのcurrentFrameをチェックして停止してたらplay()するフラグ. 
		 */
		public var forcePlay:Boolean = false;
		
		private var _frameAction:FrameAction;
		
		
		
		private var _frame:int = 0;
		
		// カレントフレームをチェック
		private function _target_enterFrame(e:Event):void {
			// フレーム進んでなかったら、むりやり再生
			if (_frame == target.currentFrame) target.play();
			_frame = target.currentFrame;
		}
		
		
		
		/**
		 * 新しい DoTimeline インスタンスを作成します。
		 */
		public function DoTimeline( movieClip:MovieClip, startLabel:String, endLabel:String, initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
			
			target = movieClip;
			this.startLabel = startLabel;
			this.endLabel = endLabel;
			
			if (forcePlay) target.addEventListener(Event.ENTER_FRAME, _target_enterFrame);
			
			var that:DoTimeline = this;
			// 実行したいコマンド群を登録します。
			addCommand(
				// 準備
				function():void {
					if(!_frameAction) _frameAction = new FrameAction(target);
					if (_frameAction.labelToFrame(startLabel) == 0 || _frameAction.labelToFrame(endLabel) == 0)
						throw new Error("DoTimeline ラベルが存在しません");
					if (_frameAction.labelToFrame(startLabel) > _frameAction.labelToFrame(endLabel))
						throw new Error("DoTimeline ラベルの順番が逆です");
					
					if (that.autoStop){
						_frameAction.setAction(endLabel, function():void {
							target.stop();
							that.dispatchEvent(new Event("resume"));
						});
					}else{
						_frameAction.setAction(endLabel, function():void {
							//trace("completeLabel",completeLabel);
							that.dispatchEvent(new Event("resume"));
						});
					}
					
					//trace(target+".currentFrame=", target.currentFrame);
					target.gotoAndPlay(startLabel);
					//trace(target+".currentFrame=", target.currentFrame);
					
					Func(this).listen(that, "resume");
					DoTimeline(that).addEventListener(ExecuteEvent.EXECUTE_INTERRUPT, DoTimeline(that)._onInterrupt);
				},
				
				// 後処理
				function():void {
					// フレームアクションを削除
					_frameAction.removeAction(endLabel);
					DoTimeline(that).removeEventListener(ExecuteEvent.EXECUTE_INTERRUPT, DoTimeline(that)._onInterrupt);
					target.removeEventListener(Event.ENTER_FRAME, DoTimeline(that)._target_enterFrame);
				}
			);
		}
		
		
		
		
		
		// 中断された時の処理. 
		private function _onInterrupt(e:Event):void {
			_frameAction.removeAction(endLabel);
			removeEventListener(ExecuteEvent.EXECUTE_INTERRUPT, arguments.callee);
			target.removeEventListener(Event.ENTER_FRAME, _target_enterFrame);
		}
		
		override public function toString():String
		{
			if (startLabel)
			{
				return ObjectUtil.formatToString(this, "DoTimeline", "target", "startLabel", "completeLabel", "state");
			}else{
				// dispose()後にエラーが出ることがあるので、それ対策
				return ObjectUtil.formatToString(this, "DoTimeline");
			}
		}
		
		
		/**
		 * インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。
		 */
		override public function clone():Command {
			return new DoTimeline( target, startLabel, endLabel, this );
		}
	}
}
