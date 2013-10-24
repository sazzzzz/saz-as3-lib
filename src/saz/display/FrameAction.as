package saz.display {
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import saz.IStartable;
	import saz.collections.enumerator.Enumerable;
	import saz.util.ArrayUtil;
	import saz.util.DisplayUtil;
	import saz.util.VarDefault;
	
	/**
	 * MovieClipのタイムラインに、フレームアクションを追加する.
	 * gotoAndPlay()で指定したフレームのアクションが実行されない！！！
	 * 
	 * 
	 * @author saz
	 * @see	http://blog.img8.com/archives/2009/01/004354.html
	 * @see	http://blog.888-3.com/?eid=900817
	 */
	public class FrameAction {
		
		
		/**
		 * 対象とするMovieClip.
		 */
		public function get target():MovieClip {
			return _target;
		}
		public function set target(value:MovieClip):void {
			_target = value;
		}
		private var _target:MovieClip;
		
		
		private var _entries:Object;
		
		/**
		 * labelToFrame用キャッシュ. 
		 */
		private var _labelCache:Object;
		
		/**
		 * コンストラクタ. 
		 * アンドキュメントなメソッドを使用しています（MovieClip.addFrameScript()）。
		 * 
		 * @param	target	対象とするMovieClip.
		 */
		public function FrameAction(target:MovieClip) {
			this.target = target;
			
			_init();
		}
		
		
		private function _init():void
		{
			_entries = {};
		}
		
		/**
		 * フレームラベルまたはフレーム数をフレーム数に変換. 
		 * @param	frame	フレーム番号を表す数値、またはフレームのラベルを表すストリング.
		 * @return
		 */
		private function _frameobjToFrame(frame:Object):int {
			return (frame is String) ? labelToFrame(String(frame)) : int(frame);
		}
		
		
		
		
		private function _createEntry(frame:Object, func:Function):Entry
		{
			return new Entry(frame, func);
		}
		
		private function _getEntry(frame:Object):Entry
		{
			return _entries[frame.toString()] as Entry;
		}
		
		private function _addEntry(frame:Object, func:Function):void
		{
			_entries[frame.toString()] = _createEntry(frame, func);
		}
		
		private function _removeEntry(frame:Object):Entry
		{
			var res:Entry = _getEntry(frame);
			if (res == null) return null;
			
			/*_entries[frame.toString()] = null;*/		// nullじゃだめだよ
			delete _entries[frame.toString()];			// deleteを使う
			return res;
		}
		
		
		
		
		/**
		 * ラベル名からフレーム番号を返す.
		 * @param	label	フレームラベル名. 
		 * @return	フレーム番号を返す. ラベルが見つからない場合は0を返す. 
		 */
		public function labelToFrame(label:String):int {
			// Objectにキャッシュ
			if (_labelCache == null) _labelCache = DisplayUtil.cacheLabelToFrame(_target);
			return _labelCache[label];
		}
		
		/**
		 * フレームアクションを追加する.
		 * 該当フレームにあらかじめ設定されていた「フレームアクション」は消去されるみたい。FlashIDEで設定したものも消去されるみたい。
		 * 
		 * @param	frame	フレーム番号を表す数値、またはフレームのラベルを表すストリング.
		 * @param	func	追加するアクション. function():void
		 */
		public function setAction(frame:Object, func:Function):void {
			removeAction(frame);
			
			_addEntry(frame, func);
			_target.addFrameScript(_frameobjToFrame(frame) - 1, func);
		}
		
		/**
		 * フレームアクションを削除する. 
		 * @param	frame	フレーム番号を表す数値、またはフレームのラベルを表すストリング.
		 */
		public function removeAction(frame:Object):void {
			_target.addFrameScript(_frameobjToFrame(frame) - 1, null);
			_removeEntry(frame);
		}
		
		/**
		 * すべてのフレームアクションを削除。
		 * 
		 */
		public function removeAll():void
		{
			var entry:Entry;
			for (var key:String in _entries)
			{
				entry = _getEntry(key);
				removeAction(entry.frame);
			}
		}
	}

}


import saz.util.ObjectUtil;

class Entry
{
	public var frame:Object;
	public var func:Function;
	
	public function Entry(frame:Object, func:Function)
	{
		this.frame = frame;
		this.func = func;
	}
	
	public function toString():String
	{
		return ObjectUtil.formatToString(this, "Entry", ["frame"]);
	}
}


