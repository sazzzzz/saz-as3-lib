package sample.display {
	import fl.transitions.easing.*;
	import fl.transitions.Tween;
	import flash.display.*;
	import flash.events.*;
	import saz.display.BtnClip;
	
	/**
	 * ...
	 * @author saz
	 */
	public class SampleBtnClip extends BtnClip {
		
		private var $display:Sprite;
		private var $wholeTw:Tween;
		private var $maruTw:Tween;
		
		
		function SampleBtnClip(inputObject:InteractiveObject, displayObject:Sprite) {
			super(inputObject);
			
			this.$display = displayObject;
			//this.$display.mouseEnabled = false;
		}
		
		public override function destroy():void {
			this.$display = null;
			this.$wholeTw.stop();
			this.$wholeTw = null;
			this.$maruTw.stop();
			this.$maruTw = null;
			
			super.destroy();
		}
		
		//--------------------------------------
		// override
		//--------------------------------------
		
		protected override function $onClick(e:MouseEvent):void{
		}
		
		protected override function $onDoubleClick(e:MouseEvent):void{
		}
		
		
		protected override function $onRollOver(e:MouseEvent):void {
			//trace("SampleBtnClip.$onRollOver(" + arguments);
			if (this.$wholeTw) this.$wholeTw.stop();
			this.$wholeTw = new Tween(this.$display, "alpha", None.easeNone, this.$display.alpha, 0.5, 1, true);
			
			if (this.$maruTw) this.$maruTw.stop();
			var maru:MovieClip = this.$display["maru"];
			this.$maruTw = new Tween(maru, "x", Elastic.easeInOut, maru.x, 200, 1, true);
		}
		
		protected override function $onRollOut(e:MouseEvent):void{
			//trace("SampleBtnClip.$onRollOver(" + arguments);
			if (this.$wholeTw) this.$wholeTw.stop();
			this.$wholeTw = new Tween(this.$display, "alpha", None.easeNone, this.$display.alpha, 1, 1, true);
			
			if (this.$maruTw) this.$maruTw.stop();
			var maru:MovieClip = this.$display["maru"];
			this.$maruTw = new Tween(maru, "x", Elastic.easeInOut, maru.x, 100, 1, true);
		}
		
		
		protected override function $onMouseDown(e:MouseEvent):void {
			this.$display.alpha = 1;
		}
		
		protected override function $onMouseUp(e:MouseEvent):void {
			this.$display.alpha = 0.5;
		}
		
		
		protected override function $onMouseOver(e:MouseEvent):void {
			this.$display.scaleX = 2;
		}
		
		protected override function $onMouseOut(e:MouseEvent):void{
			this.$display.scaleX = 1;
		}
		
		
		protected override function $onMouseMove(e:MouseEvent):void{
		}
		
		protected override function $onMouseWheel(e:MouseEvent):void{
		}
		
	}
	
}