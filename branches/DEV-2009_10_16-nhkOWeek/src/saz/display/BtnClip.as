package saz.display {
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author saz
	 */
	public class BtnClip extends EventDispatcher {
		
		private var $input:InteractiveObject;
		
		function BtnClip(inputObject:InteractiveObject) {
			this.$input = inputObject;
			
			this.$initObjAsButton(this.$input);
			this.$initEvents(this.$input);
		}
		
		function destroy():void {
			this.$input = null;
		}
		
		private function $initObjAsButton(inputObject:InteractiveObject):void {
			trace("BtnClip.$initObjAsButton(" + arguments);
			inputObject.mouseEnabled = true;	//InteractiveObject
			
			if (inputObject is SimpleButton) {
				this.$initSimpleButton(SimpleButton(inputObject));		//強制型変換
			}else if (inputObject is Sprite) {
				this.$initSprite(Sprite(inputObject));		//強制型変換
			}
		}
		
		private function $initSimpleButton(inputObject:SimpleButton):void {
			inputObject.useHandCursor = true;	//SimpleButton, Sprite
		}
		
		private function $initSprite(inputObject:Sprite):void {
			inputObject.useHandCursor = true;	//SimpleButton, Sprite
			inputObject.mouseChildren = false;	//DisplayObjectContainer
			inputObject.buttonMode = true;		//Sprite
		}
		
		private function $initEvents(inputObject:InteractiveObject):void {
			/*inputObject.addEventListener(MouseEvent.CLICK , this.$onClick);
			inputObject.addEventListener(MouseEvent.DOUBLE_CLICK, this.$onDoubleClick);
			inputObject.addEventListener(MouseEvent.MOUSE_DOWN, this.$onMouseDown);
			inputObject.addEventListener(MouseEvent.MOUSE_MOVE, this.$onMouseMove);
			inputObject.addEventListener(MouseEvent.MOUSE_OUT, this.$onMouseOut);
			inputObject.addEventListener(MouseEvent.MOUSE_OVER, this.$onMouseOver);
			inputObject.addEventListener(MouseEvent.MOUSE_UP, this.$onMouseUp);
			inputObject.addEventListener(MouseEvent.MOUSE_WHEEL, this.$onMouseWheel);
			inputObject.addEventListener(MouseEvent.ROLL_OUT, this.$onRollOut);
			inputObject.addEventListener(MouseEvent.ROLL_OVER, this.$onRollOver);*/
			
			inputObject.addEventListener(MouseEvent.CLICK , this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.DOUBLE_CLICK, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_DOWN, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_MOVE, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_OUT, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_OVER, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_UP, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.MOUSE_WHEEL, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.ROLL_OUT, this.$onMouseListener);
			inputObject.addEventListener(MouseEvent.ROLL_OVER, this.$onMouseListener);
		}
		
		
		private function $onMouseListener(e:MouseEvent):void {
			//trace("BtnClip.$onMouseListener(" + arguments);
			this.dispatchEvent(e);
		}
		
		/*private function $onClick(e:MouseEvent):void{
			this.dispatchEvent(e);
		}
		
		private function $onDoubleClick(e:MouseEvent):void{
			
		}
		
		private function $onMouseDown(e:MouseEvent):void{
			
		}
		
		private function $onMouseMove(e:MouseEvent):void{
			
		}
		
		private function $onMouseOut(e:MouseEvent):void{
			
		}
		
		private function $onMouseOver(e:MouseEvent):void{
			
		}
		
		private function $onMouseUp(e:MouseEvent):void{
			
		}
		
		private function $onMouseWheel(e:MouseEvent):void{
			
		}
		
		private function $onRollOut(e:MouseEvent):void{
			
		}
		
		private function $onRollOver(e:MouseEvent):void{
			
		}*/
		
	}
	
}