package saz.display {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.*;
	import saz.events.LoopEvent;
	
	
	/**
	 * ループする時。
	 * @eventType	saz.events.LoopEvent.LOOP
	 */
	[LoopEvent(name = "loop", type = "saz.events.LoopEvent")];
	
	/**
	 * isLoop=falseの場合、アニメーション完了時に。
	 * 
	 * @eventType	flash.events.Event.COMPLETE
	 */
	[Event(name = "complete", type = "flash.events.Event")];
	
	
	/**
	 * 昔のゲーム風のタイルアニメ
	 * @author saz
	 * 
	 * @example <listing version="3.0" >
	 * // 元となると出力先のBitmapDataを用意。
	 * var src:BitmapData = new TileBmp(0,0);
	 * // addChild(new Bitmap(src));
	 * var dst:BitmapData = new BitmapData(500,200,false,0);
	 * addChild(new Bitmap(dst));
	 * 
	 * // BitmapTileAnimatorインスタンスを生成。
	 * var anm:BitmapTileAnimator = new BitmapTileAnimator(src,dst,100,100);
	 * 
	 * // トリガーとなるイベントを設定。（通常ENTER_FRAMEです）
	 * anm.setTrigger(this.stage, Event.ENTER_FRAME);
	 * 
	 * // アニメーションのコマ数を設定。
	 * anm.setFrames(10);
	 * 
	 * // ループするかどうか。
	 * anm.isLoop = true;
	 * 
	 * // アニメーション開始。
	 * anm.start();
	 * </listing>
	 */
	public class BitmapTileAnimator extends EventDispatcher {
		
		private var $isLoop:Boolean;
		
		private var $src:BitmapData;
		private var $dst:BitmapData;
		private var $tileWidth:uint;
		private var $tileHeight:uint;
		private var $triggerObj:IEventDispatcher;
		private var $eventType:String;
		private var $frames:uint;
		
		private var $dstPoint:Point;
		
		//内部メンバ
		private var $frameCount:int;
		private var $srcRect:Rectangle;
		private var $colSize:uint;
		private var $rowSize:uint;
		
		/**
		 * コンストラクタ。
		 * 
		 * @example
		 * <pre>
		 * var src:BitmapData = new TileBmp(0,0);
		 * addChild(new Bitmap(src));
		 * var dst:BitmapData = new BitmapData(500,200,false,0);
		 * addChild(new Bitmap(dst));
		 * 
		 * var anm:BitmapTileAnimator = new BitmapTileAnimator(src,dst,100,100);
		 * anm.setTrigger(this.stage, Event.ENTER_FRAME);
		 * anm.setFrames(10);
		 * anm.isLoop = true;
		 * 
		 * anm.start();
		 * </pre>
		 * 
		 * @param	srcBmp
		 * @param	dstBmp
		 * @param	width
		 * @param	height
		 */
		function BitmapTileAnimator(srcBmp:BitmapData, dstBmp:BitmapData, width:uint, height:uint) {
			setSrcBitmap(srcBmp);
			setDstBitmap(dstBmp);
			setTileSize(width, height);
			
			$isLoop = false;
			$frameCount = -1;
			if (null == $dstPoint)$dstPoint = new Point(0, 0);
			if (null == $srcRect)$srcRect = new Rectangle(0, 0, $tileWidth, $tileHeight);
		}
		
		public function start():void {
			$frameCount = -1;
			resume();
		}
		
		public function resume():void {
			if (null == $src || null == $dst || isNaN($tileWidth) || isNaN($tileHeight) || null == $triggerObj || null == $eventType || isNaN($frames)) {
				throw new Error("必要なデータがセットされてません");
			}
			
			$readySrcPosition();
			$startLoop();
			$loop(new Event(""));
		}
		
		public function stop():void {
			$stopLoop();
		}
		
		/**
		 * トリガーとなるイベントを登録。ふつうはonEnterFrameだろうね。
		 * @param	obj	イベント配信者。
		 * @param	type	イベントタイプ。ふつうはonEnterFrameだろうね。
		 */
		public function setTrigger(obj:IEventDispatcher, type:String):void {
			$triggerObj = obj;
			$eventType = type;
		}
		
		/**
		 * ソースビットマップ
		 * @param	bmp
		 */
		public function setSrcBitmap(bmp:BitmapData):void {
			$src = bmp;
		}
		
		/**
		 * 出力先ビットマップ
		 * @param	bmp
		 */
		public function setDstBitmap(bmp:BitmapData):void {
			$dst = bmp;
		}
		
		/**
		 * コマのサイズを決定
		 * @param	width
		 * @param	height
		 */
		public function setTileSize(width:uint, height:uint):void {
			$tileWidth = width;
			$tileHeight = height;
		}
		
		/**
		 * 出力先の位置を決定
		 * @param	x
		 * @param	y
		 */
		public function setDstPoint(x:uint = 0, y:uint = 0):void {
			if (null == $dstPoint) {
				$dstPoint = new Point(0,0);
			}
			$dstPoint.x = x;
			$dstPoint.y = y;
		}
		
		public function setFrames(value:uint):void {
			$frames = value;
		}
		
		
		public function get isLoop():Boolean { return $isLoop; }
		
		public function set isLoop(value:Boolean):void {
			$isLoop = value;
		}
		
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		private function $startLoop():void {
			$triggerObj.addEventListener($eventType, $loop);
		}
		
		private function $stopLoop():void {
			$triggerObj.removeEventListener($eventType, $loop);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function $loop(e:Event):void {
			$frameCount++;
			$detectSrcPosition();
			
			//draw
			$dst.copyPixels($src, $srcRect, $dstPoint);
			if ($frames <= $frameCount + 1) {
				//終了処理
				if ($isLoop) {
					//ループする
					dispatchEvent(new LoopEvent(LoopEvent.LOOP));
				}else {
					$stopLoop();
				}
				$frameCount = -1;
			}
		}
		
		private function $readySrcPosition():void {
			$colSize = Math.floor($src.width / $tileWidth);
			$rowSize = Math.floor($src.height / $tileHeight);
		}
		
		private function $detectSrcPosition():void {
			$srcRect.x = $tileWidth * ($frameCount % $colSize);
			$srcRect.y = $tileHeight * (Math.floor($frameCount / $colSize));
		}
		
	}
	
}