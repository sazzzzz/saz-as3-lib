package saz.video
{
	import fl.video.*;
	
	// TODO	イベントも管理対象にしたい
	public class FLVPVideoPlayerManager
	{
		
		private var _flvp:FLVPlayback;
		public function get flvp():FLVPlayback
		{
			return _flvp;
		}
		public function set flvp(value:FLVPlayback):void
		{
			if(_flvp == value)return;
			_flvp = value;
			_init();
		}
		
		/*private var _max:int = 8;
		public function get max():int
		{
			return _max;
		}
		public function set max(value:int):void
		{
			_max = value;
		}*/
		
		/*private var _enumerable:Enumerable;
		public function get enumerable():Enumerable
		{
			if(!_enumerable) _enumerable = new Enumerable(_usings);
			return _enumerable;
		}*/

		
		private var _usings:Array = [];

		
		public function FLVPVideoPlayerManager(flvPlayback:FLVPlayback = null)
		{
			if(flvPlayback) flvp = flvPlayback;
		}
		
		
		private function _init():void
		{
			_usings.length = 0;
		}
		
		/**
		 * 探す。
		 * @param value
		 * @return 
		 */
		private function _search(value:Boolean = false):int
		{
			return _usings.indexOf(value);
		}
		
		/**
		 * 1個追加＋初期値指定。
		 * @param value
		 * @return 
		 */
		private function _add(value:Boolean):int
		{
			return _usings.push(value) - 1;
		}
		
		
		/**
		 * 使用中かどうかを調べる。
		 * @param index
		 * @return 
		 */
		private function _getUsing(index:int):Boolean
		{
			return _usings[index];
		}
		
		/**
		 * 使用フラグをセットする。
		 * @param index	インデックス。
		 * @param value	使用中はtrue、使用してないはfalse。
		 */
		private function _setUsing(index:int, value:Boolean):void
		{
			_usings[index] = value;
		}
		
		
		
		
		
		/**
		 * 使用してないVideoPlayerを確保しインデックスを返す。
		 * @return 
		 */
		public function acquire():int
		{
			var idx:int = _search();
			if(idx == -1){
				idx = _add(true);
			}else{
				_setUsing(idx, true);
			}
			return idx;
		}
		
		/**
		 * VideoPlayerを解放する。
		 * @param index
		 */
		public function release(index:int):void
		{
			_setUsing(index, false);
		}
		
		
		public function releaseAll():void
		{
			for(var i:int = 0, n:int = _usings.length; i < n; i++)
			{
				_setUsing(i, false);
			}
		}
		
		
		
		public function toString():String
		{
			//return ObjectUtil.formatToString(this, "FLVPVideoPlayerManager");
			return ["[FLVPVideoPlayerManager", _usings.join(","), "]"].join(" ");
		}
		
	}
}