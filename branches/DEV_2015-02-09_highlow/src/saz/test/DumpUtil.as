package saz.test
{
	import aisei.ranking.Define;
	
	import flash.geom.*;

	/**
	 * デバッグ用にインスタンスを出力するユーティリティクラス。
	 * @author saz
	 * 
	 */
	public class DumpUtil
	{
		
		public static var enabled:Boolean = false;
		
		
		//--------------------------------------
		// method
		//--------------------------------------
		
		/**
		 * PerspectiveProjectionをダンプ。
		 * @param target
		 * 
		 */
		public static function perspective(target:PerspectiveProjection):void
		{
			if (!can("perspective", target)) return;
			
			member(target, "fieldOfView");
			member(target, "projectionCenter");
		}
		
		/**
		 * Matrix3Dをダンプ。
		 * @param target
		 * 
		 */
		public static function matrix3D(target:Matrix3D):void
		{
			if (!can("matrix3D", target)) return;
			
			member(target, "determinant");
			member(target, "position");
			member(target, "rawData");
		}
		
		
		public static function member(target:Object, name:String):void
		{
			trace("\t", name, target[name]);
		}
		
		
		//--------------------------------------
		// private
		//--------------------------------------
		
		private static function can(name:String, target:*):Boolean
		{
			if (!isEnable()) return false;
			trace("DumpUtil." + name + "(", target);
			if (target == null) return false;
			
			return true;
		}
		
		private static function isEnable():Boolean
		{
			return enabled;
		}
		
	}
}