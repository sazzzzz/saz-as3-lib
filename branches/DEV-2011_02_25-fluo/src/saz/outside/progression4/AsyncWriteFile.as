package saz.outside.progression4 {
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.OutputProgressEvent;
	import flash.filesystem.*;
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
	
	/**
	 * 非同期でFileを書き込む.
	 * エラーテストをしてません…
	 * @author saz
	 */
	public class AsyncWriteFile extends SerialList {
		
		public var file:File;
		public var fileMode:String = FileMode.APPEND;
		public var data:*;
		
		public var onProgress:Function;
		public var onClose:Function;
		
		private var _fileStream:FileStream;
		public function get fileStream():FileStream { return _fileStream; }
		
		/**
		 * 最後のイベントインスタンス.
		 */
		private var _latestEvent:Event;
		public function get latestEvent():Event { return _latestEvent; }
		
		//public var writeMethod:Function = writeUTFBytes;
		
		/**
		 * 新しい AsyncWriteFile インスタンスを作成します。
		 */
		public function AsyncWriteFile( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
			
			// 実行したいコマンド群を登録します。
			addCommand(
				function():void {
					onProgress ||= function():void { };
					onClose ||= function():void { };
					
					_fileStream ||= new FileStream();
					_fileStream.addEventListener(IOErrorEvent.IO_ERROR, $stream_IOError);
					_fileStream.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, $stream_outputProgress);
					//_fileStream.addEventListener(Event.COMPLETE, $stream_complete);	//書き出し処理ではEvent.COMPLETEイベントは配信されません。
					_fileStream.addEventListener(Event.CLOSE, $stream_close);
					
					this.listen(_fileStream, Event.CLOSE);
					_fileStream.openAsync(file, fileMode);
					
					try {
						//_fileStream.writeUTFBytes(data);		//FIXME	writeメソッドの選択をどうする？サブクラス？
						_fileStream.writeBytes(data);
					}catch (error:IOError) {		// エラー
						trace(error.message);
					}finally {
						_fileStream.close();
					}
				},
				function():void {
					trace("comp");
				}
			);
		}
		
		/*public static function writeUTFBytes(value:*):void {
			_fileStream.writeUTFBytes(value);
		}
		
		public static function writeBytes(value:*):void {
			_fileStream.writeBytes(value);
		}*/
		
		
		private function $stream_IOError(event:IOErrorEvent):void {
			_latestEvent = event;
			onError();
		}
		
		private function $stream_outputProgress(event:OutputProgressEvent):void {
			_latestEvent = event;
			onProgress();
		}
		
		private function $stream_close(event:Event):void {
			_latestEvent = event;
			onClose();
		}
		
		
		/**
		 * インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。
		 */
		override public function clone():Command {
			return new AsyncWriteFile( this );
		}
		
	}
}
