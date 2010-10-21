package saz.media {
	import flash.display.*;
	import flash.media.*;
	import saz.collections.*;
	import saz.util.*;
	/**
	 * Soundインスタンス保持クラス.
	 * @author saz
	 */
	public class SoundHolder extends WatchMap {
		
		static public var classSuffix:String = "Class";
		
		public function SoundHolder() {
			super();
		}
		
		//
		// 型指定したいけど、
		// 1023: オーバーライドに対応していません。
		//
		/**
		 * 要素を取得する。
		 * @param	key
		 * @return
		 */
		//override public function gets(key:String):Sound {
			//return super.gets(key);
		//}
		
		/**
		 * 指定した要素を書き換える。
		 * @param	key
		 * @param	value
		 */
		//override public function put(key:String, value:Sound):void {
			//super.put(key, value);
		//}
		
		/**
		 * 外部からSoundクラスを取り出し、Soundクラス、Soundインスタンスを追加する.
		 * Soundクラスは、className+"Class"で登録.
		 * @param	loaderInfo
		 * @param	className
		 */
		public function extractSound(loaderInfo:LoaderInfo, className:String):void {
			var SoundClass:Class = ClassUtil.extractClass(loaderInfo, className);
			super.put(className + classSuffix, SoundClass);
			super.put(className, new SoundClass());
		}
		
		/**
		 * 外部からSoundクラスをまとめて取り出し、Soundクラス、Soundインスタンスを追加する.
		 * Soundクラスは、className+"Class"で登録.
		 * @param	loaderInfo
		 * @param	classNames
		 */
		public function extractSounds(loaderInfo:LoaderInfo, classNames:Array):void {
			//var SoundClass:Class;
			//for each(var p in classNames) {
				//SoundClass = ClassUtil.extractClass(loaderInfo, className);
				//super.put(p, new SoundClass());
			//}
			var soundClasses:Array = ClassUtil.extractClasses(loaderInfo, classNames);
			for (var i:int = 0, len:int = soundClasses.length, SoundClass:Class; i < len; i++) {
				extractSound(loaderInfo, classNames[i]);
			}
		}
		
		
	}

}