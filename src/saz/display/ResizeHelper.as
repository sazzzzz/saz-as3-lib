package saz.display
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import hsa.main.Define;
	
	import saz.collections.ArrayCompositeHelper;

	public class ResizeHelper
	{
		
		
		public static const LEFT_TOP:String = "LT";
		public static const CENTER_TOP:String = "CT";
		public static const RIGHT_TOP:String = "RT";
		public static const LEFT_MIDDLE:String = "LM";
		public static const CENTER_MIDDLE:String = "CM";
		public static const RIGHT_MIDDLE:String = "RM";
		public static const LEFT_BOTTOM:String = "LB";
		public static const CENTER_BOTTOM:String = "CB";
		public static const RIGHT_BOTTOM:String = "RB";
		
		public static const BASE_STAGE:String = "stage";
		public static const BASE_CONTENT:String = "content";
		
		private var _stage:Stage;
		
		private var _stageRect:Rectangle;
		private var _contentRect:Rectangle;
		private var _baseRects:Object = {};
		
		private var _positions:ArrayCompositeHelper;
		private var _circumscribed:ArrayCompositeHelper;
		
		public function ResizeHelper(stageRef:Stage)
		{
			_stage = stageRef;
			_init();
		}
		
		
		private function _init():void
		{
			_stageRect = new Rectangle();
			_updateStageRect();
			
			_contentRect = new Rectangle(0, 0, Define.WIDTH, Define.HEIGHT);
			_baseRects[BASE_STAGE] = _stageRect;
			_baseRects[BASE_CONTENT] = _contentRect;
			
			_positions = new ArrayCompositeHelper();
			_circumscribed = new ArrayCompositeHelper();
		}
		
		protected function _stage_resize(event:Event):void
		{
			_updateStageRect();
			_updateContentRect();
			layout();
		}
		
		private function _updateStageRect():void
		{
			_stageRect.x = 0;
			_stageRect.y = 0;
			_stageRect.width = _stage.stageWidth;
			_stageRect.height = _stage.stageHeight;
		}
		
		private function _updateContentRect():void
		{
			centerRect(_contentRect, _stageRect);
		}
		
		
		
		
		public function addPosition(disp:DisplayObject, base:String, align:String, diffx:Number=0, diffy:Number=0):void
		{
			_positions.add(disp, "", {base:base, align:align, diffx:diffx, diffy:diffy});
		}
		
		public function removePosition(disp:DisplayObject):void
		{
			_positions.remove(disp);
		}
		
		
		public function addCircumscribed(disp:DisplayObject, base:String, w:Number=-1, h:Number=-1):void
		{
			_circumscribed.add(disp, "", {base:base, width:w == -1 ? disp.width : w, height:h == -1 ? disp.height : h});
		}
		
		public function removeCircumscribed(disp:DisplayObject):void
		{
			_circumscribed.remove(disp);
		}
		
		
		public function getStageRect():Rectangle
		{
			return _stageRect;
		}
		
		public function getContentRect():Rectangle
		{
			return _contentRect;
		}
		
		
		public function layout():void
		{
			var d:Object;
			_positions.enumerable.forEach(function(entry:Object, index:int, arr:Array):void
			{
				d = entry.data;
				_layoutPosition(entry.item, d.base, d.align, d.diffx, d.diffy);
			});
			
			_circumscribed.enumerable.forEach(function(entry:Object, index:int, arr:Array):void
			{
				d = entry.data;
				_layoutCircumscribed(entry.item, d.base, d.width, d.height);
			});
		}
		
		
		public function start():void
		{
			_stage.addEventListener(Event.RESIZE, _stage_resize);
		}
		
		public function stop():void
		{
			_stage.removeEventListener(Event.RESIZE, _stage_resize);
		}
		
		
		
		private function _layoutPosition(disp:DisplayObject, base:String, align:String, diffx:Number, diffy:Number):void
		{
			var p:Point = _getRefPosition(_getBaseRect(base), align);
			disp.x = p.x + diffx;
			disp.y = p.y + diffy;
		}
		
		private function _layoutCircumscribed(disp:DisplayObject, base:String, w:Number, h:Number):void
		{
			_circum(disp, _getBaseRect(base), w, h);
		}
		
		
		private function _getBaseRect(base:String):Rectangle
		{
			/*switch(base)
			{
				case BASE_STAGE:
					return _stageRect;
				case BASE_CONTENT:
					return _contentRect;
				default:
			}*/
			return _baseRects[base];
		}
		
		private function _getRefPosition(rect:Rectangle, align:String):Point
		{
			var res:Point = new Point();
			var holi:String = align.substr(0, 1);
			var ver:String = align.substr(1, 1);
			
			switch(holi)
			{
				case "L":
					res.x = Math.floor(rect.left);
					break;
				case "C":
					res.x = Math.round(rect.x + rect.width / 2);
					break;
				case "R":
					res.x = Math.ceil(rect.right);
					break;
			}
			
			switch(ver)
			{
				case "T":
					res.y = Math.floor(rect.top);
					break;
				case "M":
					res.y = Math.round(rect.y + rect.height / 2);
					break;
				case "B":
					res.y = Math.ceil(rect.bottom);
					break;
			}
			
			return res;
		}
		
		/**
		 * 外接
		 * @param target	対象。
		 * @param frame		枠。
		 */
		private function _circum(target:DisplayObject, frame:Rectangle, targetW:Number, targetH:Number):void
		{
			target.scaleX = target.scaleY = 1.0;
			var scale:Number = (targetW / targetH > frame.width / frame.height) ? frame.height / targetH : frame.width / targetW;
			target.x = frame.x - Math.round((targetW * scale - frame.width) / 2);
			target.y = frame.y - Math.round((targetH * scale - frame.height) / 2);
			target.scaleX = target.scaleY = scale;
		}
		
		public function centerRect(rect:Rectangle, base:Rectangle):void
		{
			rect.x = Math.round((base.width - rect.width) / 2);
			rect.y = Math.round((base.height - rect.height) / 2);
		}
		
		
	}
}