package saz.display.btnclip {
	import flash.display.*;
	import flash.events.*;
	
	/**
	 * ボタン。as2から移植。
	 * @author saz
	 * @deprecated	as2から移植したけど不要かな…。
	 */
	public class BtnClip extends EventDispatcher {
		
		protected var $input:InteractiveObject;
		
		function BtnClip(inputObject:InteractiveObject) {
			super();
			
			this.$input = inputObject;
			
			this.$initObjAsButton(this.$input);
			this.$initEvents(this.$input);
		}
		
		public function destroy():void {
			this.$input = null;
		}
		
		private function $initObjAsButton(inputObject:InteractiveObject):void {
			//trace("BtnClip.$initObjAsButton(" + arguments);
			
			// マウスイベントを受け取るかどうかを判断するプロパティ。こいつをfalseにするとマウスイベントを受け取らなくなるので、一時的にリスナーを切りたいけどremoveEventListenerするのが面倒とか、あるタイミングだけマウスに反応させたくない時に使用する。
			// http://www.5ive.info/blog/archives/82
			inputObject.mouseEnabled = true;	//InteractiveObject			このオブジェクトがマウスメッセージを受け取るかどうかを指定します。
			
			if (inputObject is SimpleButton) {
				this.$initSimpleButton(SimpleButton(inputObject));		//強制型変換
			}else if (inputObject is MovieClip) {
				this.$initSprite(MovieClip(inputObject));					//強制型変換
			}else if (inputObject is Sprite) {
				this.$initSprite(Sprite(inputObject));					//強制型変換
			}
		}
		
		private function $initSimpleButton(inputObject:SimpleButton):void {
			//trace("BtnClip.$initSimpleButton(" + arguments);
			
			// デフォルトtrueなので不要
			//inputObject.useHandCursor = true;	//SimpleButton, Sprite		指差しハンドポインタ (ハンドカーソル) を表示するかどうか
		}
		
		private function $initSprite(inputObject:Sprite):void {
			//trace("BtnClip.$initSprite(" + arguments);
			
			// デフォルトtrueなので不要
			//inputObject.useHandCursor = true;	//SimpleButton, Sprite		指差しハンドポインタ (ハンドカーソル) を表示するかどうか
			
			// たぶん不要。
			// MovieClipシンボル内のすべてのインスタンスについて独立したマウスイベントを発生させないようにするには、mouseChildrenプロパティをfalseに設定する(スクリプト008)。
			// そうすると、mouseOverとrollOverで、マウスイベントが同じように扱われる。
			// http://www.fumiononaka.com/Sample/F-site/FF071110.html#04
			//inputObject.mouseChildren = false;	//DisplayObjectContainer	オブジェクトの子に対してマウスが有効かどうか
			
			inputObject.buttonMode = true;		//Sprite					このスプライトのボタンモードを指定します。true の場合、このスプライトはボタンとして動作します。
			
			//trace(inputObject.name);
			//trace("buttonMode="+inputObject.buttonMode);
		}
		
		private function $initEvents(inputObject:InteractiveObject):void {
			/*inputObject.addEventListener(MouseEvent.CLICK , this.$onClick);
			inputObject.addEventListener(MouseEvent.DOUBLE_CLICK, this.$onDoubleClick);
			inputObject.addEventListener(MouseEvent.ROLL_OVER, this.$onRollOver);
			inputObject.addEventListener(MouseEvent.ROLL_OUT, this.$onRollOut);
			inputObject.addEventListener(MouseEvent.MOUSE_DOWN, this.$onMouseDown);
			inputObject.addEventListener(MouseEvent.MOUSE_UP, this.$onMouseUp);
			inputObject.addEventListener(MouseEvent.MOUSE_OVER, this.$onMouseOver);
			inputObject.addEventListener(MouseEvent.MOUSE_OUT, this.$onMouseOut);
			inputObject.addEventListener(MouseEvent.MOUSE_MOVE, this.$onMouseMove);
			inputObject.addEventListener(MouseEvent.MOUSE_WHEEL, this.$onMouseWheel);*/
			inputObject.addEventListener(MouseEvent.CLICK , $onClick);
			inputObject.addEventListener(MouseEvent.DOUBLE_CLICK, $onDoubleClick);
			inputObject.addEventListener(MouseEvent.ROLL_OVER, $onRollOver);
			inputObject.addEventListener(MouseEvent.ROLL_OUT, $onRollOut);
			inputObject.addEventListener(MouseEvent.MOUSE_DOWN, $onMouseDown);
			inputObject.addEventListener(MouseEvent.MOUSE_UP, $onMouseUp);
			inputObject.addEventListener(MouseEvent.MOUSE_OVER, $onMouseOver);
			inputObject.addEventListener(MouseEvent.MOUSE_OUT, $onMouseOut);
			inputObject.addEventListener(MouseEvent.MOUSE_MOVE, $onMouseMove);
			inputObject.addEventListener(MouseEvent.MOUSE_WHEEL, $onMouseWheel);
			
			inputObject.addEventListener(MouseEvent.CLICK , this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.DOUBLE_CLICK, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.ROLL_OVER, this.$onMouseListener);		// ROLL_XXX - MC全体でイベント発生
			inputObject.addEventListener(MouseEvent.ROLL_OUT, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_DOWN, this.$onMouseListener);		// MOUSE_XXX - MC内部の個々のMCごとに、いちいちイベント発生
			inputObject.addEventListener(MouseEvent.MOUSE_UP, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_OVER, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_OUT, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_MOVE, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_WHEEL, this.$onMouseListener);
		}
		
		
		private function $onMouseListener(e:MouseEvent):void {
			//trace("BtnClip.$onMouseListener(" + arguments);
			//イベントを発生
			this.dispatchEvent(e);
		}
		
		public function get inputObject():InteractiveObject { return $input; }
		
		
		//--------------------------------------
		// OVER WRITE
		//--------------------------------------
		
		protected function $onClick(e:MouseEvent):void{
		}
		
		protected function $onDoubleClick(e:MouseEvent):void{
		}
		
		
		protected function $onRollOver(e:MouseEvent):void {
			//trace("BtnClip.$onRollOver(" );
		}
		
		protected function $onRollOut(e:MouseEvent):void {
			//trace("BtnClip.$onRollOut(" );
		}
		
		
		protected function $onMouseDown(e:MouseEvent):void{
		}
		
		protected function $onMouseUp(e:MouseEvent):void{
		}
		
		
		protected function $onMouseOver(e:MouseEvent):void{
		}
		
		protected function $onMouseOut(e:MouseEvent):void{
		}
		
		
		protected function $onMouseMove(e:MouseEvent):void{
		}
		
		protected function $onMouseWheel(e:MouseEvent):void{
		}
		
	}
	
}