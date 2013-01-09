package
{
	import caurina.transitions.properties.ColorShortcuts;
	
	import com.bit101.components.MinimalComps;
	
	import flash.display.*;
	
	import jp.progression.Progression;
	import jp.progression.casts.CastSprite;
	import jp.progression.config.AIRConfig;
	import jp.progression.debug.Debugger;
	
	import mx.core.FlexGlobals;
	
	import timer.Define;
	import timer.IndexScene;

	/**
	 * メイン.
	 * @author saz
	 * 
	 */
	public class Main
	{
		
		public static var stage:Stage;
		public static var content:Sprite;
		public static var progression:Progression;
		
		public function Main()
		{
		}
		
		public static function main():void
		{
			initStage();
			initDisplay();
			initProgression();
			initLibs();
			
			if(Define.TEST_MODE) initDebug();
			
			// IndexSceneから開始
			progression.goto(progression.syncedSceneId);
		}
		
		
		public static function initDebug():void
		{
			// 開発用デバッグ出力
			Debugger.addTarget(progression);
		}
		
		
		public static function initStage():void
		{
			stage = FlexGlobals.topLevelApplication.systemManager.stage;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// デスクトップAIRでは、HIGHまたはBESTのみ
			stage.quality = StageQuality.HIGH;
		}
		
		
		public static function initDisplay():void
		{
//			content = new CastSprite();
			content = new Sprite();
			content.name = "content";
			FlexGlobals.topLevelApplication.systemManager.addChild(content);
//			stage.addChild(content);
		}
		
		public static function initProgression():void
		{
			Progression.initialize(new AIRConfig());
			progression = new Progression("index", content, IndexScene);
			progression.sync = false;
			progression.autoLock = false;
		}
		
		public static function initLibs():void
		{
//			StageReference.init(stage);
			ColorShortcuts.init();
			MinimalComps.setLanguage(MinimalComps.JAPANESE);
		}
		
		
		
	}
}