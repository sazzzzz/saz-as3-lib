﻿package saz {
	import flash.display.Stage;
	
	/**
	 * stage参照クラス。
	 * addChildしたDisplayObject以外からでもstageを参照できるように。
	 * http://fladdict.net/blog/2007/02/as3_stage.html
	 * @author saz
	 */
	public class StageReference {
		
		public static var stage:Stage;
		
		static private var DEFAULT_STAGE_WIDTH:Number = 450;
		static private var DEFAULT_STAGE_HEIGHT:Number = 400;
		
		
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