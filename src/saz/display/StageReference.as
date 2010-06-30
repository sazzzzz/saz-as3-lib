package saz.display {
	import flash.display.Stage;
	
	/**
	 * stage参照クラス。<br/>
	 * addChildしたDisplayObject以外からでもstageを参照できるように。<br/>
	 * TODO	saz.display に移動するのが妥当かな
	 * @see	http://fladdict.net/blog/2007/02/as3_stage.html
	 * @author saz
	 * @example <listing version="3.0" >
	 * StageReference.init(stage);
	 * ...
	 * trace(StageReference.stage);
	 * </listing>
	 */
	public class StageReference {
		
		public static var stage:Stage;
		
		static private var DEFAULT_STAGE_WIDTH:Number = 450;
		static private var DEFAULT_STAGE_HEIGHT:Number = 400;
		
		/**
		 * 初期化。
		 * @param	theStage	stageを渡す。
		 */
		public static function init(theStage:Stage):void {
			stage = theStage;
		}
		
		public static function get stageWidth():Number {
			return (stage != null)? stage.stageWidth:DEFAULT_STAGE_WIDTH;
		}
		
		public static function get stageHeight():Number {
			return (stage != null)? stage.stageHeight:DEFAULT_STAGE_HEIGHT;
		}
		
	}
	
}