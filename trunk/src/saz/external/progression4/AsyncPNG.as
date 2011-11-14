package saz.outside.progression4 {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	import jp.progression.casts.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	import jp.progression.commands.managers.*;
	import jp.progression.commands.media.*;
	import jp.progression.commands.net.*;
	import jp.progression.commands.tweens.*;
	import jp.progression.commands.*;
	import jp.progression.data.*;
	import jp.progression.events.*;
	import jp.progression.scenes.*;
	import jp.ferv.fileformats.png.*;
	
	/**
	 * 非同期PNGエンコードコマンド. dsk/PNG使用. 
	 * Alchemy使ってるのでFlashPlayer10以降. 
	 * @author saz
	 * @see	http://www.libspark.org/wiki/dsk/PNG
	 */
	public class AsyncPNG extends SerialList {
		
		public var bitmapData:BitmapData;
		
		public var onProgress:Function;
		
		private var _png:PNG;
		public function get png():PNG { return _png; }
		
		/**
		 * 新しい AsyncPNG インスタンスを作成します。
		 */
		public function AsyncPNG( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
			
			
			// 実行したいコマンド群を登録します。
			addCommand(
				function():void {
					onProgress ||= function():void { };
					
					_png = new PNG();
					_png.addEventListener(ProgressEvent.PROGRESS, $png_progress);
					//_png.addEventListener(Event.OPEN, $png_open);
					//_png.addEventListener(Event.COMPLETE, $png_complete);
					
					this.listen(_png, Event.COMPLETE);
					_png.encodeAsync(bitmapData);
				},
				function():void {
					//vvv parent重要
					this.parent.latestData = _png.data;
					trace(Object(_png.data).constructor);
				}
			);
		}
		
		public function get data():ByteArray {
			return _png != null ? _png.data : null;
		}
		
		private function $png_progress(event:ProgressEvent):void {
			onProgress();
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		/*private function $png_open(e:Event):void {
		}
		
		private function $png_complete(event:Event):void {
		}*/
		
		/**
		 * インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。
		 */
		override public function clone():Command {
			return new AsyncPNG( this );
		}
		
	}
}
