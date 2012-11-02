package saz.display.dialog {
	import flash.display.Graphics;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
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
	
	/**
	 * DialogController用ベタ背景. ステージサイズに自動追従タイプ. 
	 * 要Progression4. 
	 * @author saz
	 */
	public class StageDialogBackground extends DialogBackgroundBase {
		
		public static const ERROR_SCALEMODE:String = "Stage.scaleMode が StageScaleMode.NO_SCALE に設定されていないと正しく描画できません。";
		public static const ERROR_ALIGN:String = "Stage.align が StageAlign.TOP_LEFT に設定されていないと正しく描画できません。";
		
		private var $stage:Stage;
		
		/**
		 * 新しい StageDialogBackground インスタンスを作成します。
		 */
		public function StageDialogBackground( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
		}
		
		
		private function $stage_resize(e:Event):void {
			draw();
		}
		
		//--------------------------------------
		// オーバーライド
		//--------------------------------------
		
		override protected function init():void {
		}
		
		override protected function draw():void {
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(0);
			g.drawRect(0, 0, $stage.stageWidth, $stage.stageHeight);
		}
		
		override protected function clear():void {
			graphics.clear();
		}
		
		
		override protected function castAddedHook():void {
			$stage ||= stage;
			$stage.addEventListener(Event.RESIZE, $stage_resize);
			
			if ($stage.scaleMode != StageScaleMode.NO_SCALE) throw new Error(ERROR_SCALEMODE);
			if ($stage.align != StageAlign.TOP_LEFT) throw new Error(ERROR_ALIGN);
		}
		
		override protected function castRemovedHook():void {
			$stage.removeEventListener(Event.RESIZE, $stage_resize);
		}
		
	}
}
