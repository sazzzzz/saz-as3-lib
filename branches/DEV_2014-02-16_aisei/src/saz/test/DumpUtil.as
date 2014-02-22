package saz.test
{
	import aisei.ranking.Define;
	
	import flash.geom.*;

	public class DumpUtil
	{
		
		public static var enabled:Boolean = false;
		
		
		//--------------------------------------
		// method
		//--------------------------------------
		
		public static function perspective(target:PerspectiveProjection):void
		{
			/*if (!isEnable()) return;
			trace("DumpUtil.perspective(", target);
			if (target == null) return;*/
			if (!can("perspective", target)) return;
			
			member(target, "fieldOfView");
			member(target, "projectionCenter");
		}
		
		public static function matrix3D(target:Matrix3D):void
		{
			/*if (!isEnable()) return;
			trace("DumpUtil.matrix3D(", target);
			if (target == null) return;*/
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