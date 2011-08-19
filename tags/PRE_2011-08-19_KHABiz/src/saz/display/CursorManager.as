package saz.display {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	//import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	/**
	 * カーソルマネージャ.
	 * サブクラスを作って、シングルトンにして、カーソル名はconstにするといいんじゃね？
	 * @author saz
	 * @example <listing version="3.0" >
	 * var sp = new Sprite();	//専用コンテナを用意.
	 * addChild(sp);
	 * 
	 * var cm = new CursorManager();
	 * cm.stage = stage;
	 * cm.container = sp;
	 * cm.add(rect,"rect");
	 * cm.add(new Circle(),"circle");
	 * 
	 * cm.change("rect");
	 * </listing>
	 */
	public class CursorManager {
		
		/**
		 * MOUSE_MOVEイベントの発信元. 通常stage.
		 */
		public var stage:InteractiveObject;
		
		protected var $container:DisplayObjectContainer;
		protected var $cursors:Object;
		protected var $cursor:DisplayObject;
		
		function CursorManager(stageObj:InteractiveObject = null, cntainer:DisplayObjectContainer = null) {
			if(stageObj) this.stage = stageObj;
			if(cntainer) container = cntainer;
		}
		
		
		public function change(key:String):void {
			Mouse.hide();
			
			// 表示中の
			if ($cursor && $container.contains($cursor)) $container.removeChild($cursor);
			
			// 新しいの
			$cursor = $cursors[key];
			$cursor.x = stage.mouseX;
			$cursor.y = stage.mouseY;
			$container.addChild($cursor);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, $stage_mouseMove);
		}
		
		public function restore():void {
			Mouse.show();
			
			if ($cursor && $container.contains($cursor)) {
				$container.removeChild($cursor);
				$cursor = null;
			}
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, $stage_mouseMove);
		}
		
		
		public function add(dsp:DisplayObject, key:String):void {
			if (!$cursors) $cursors = new Object();
			
			trace(dsp is InteractiveObject);
			trace(dsp is Sprite);
			//if (dsp is InteractiveObject) InteractiveObject(dsp).mouseEnabled = false;
			//if (dsp is DisplayObjectContainer) DisplayObjectContainer(dsp).mouseChildren = false;
			$cursors[key] = dsp;
		}
		
		
		public function remove(key:String):void {
			if (!$cursors) return;
		}
		
		
		
		
		protected function $stage_mouseMove(e:MouseEvent):void{
			$cursor.x = stage.mouseX;
			$cursor.y = stage.mouseY;
			e.updateAfterEvent();
		}
		
		/**
		 * カーソルを表示するためのDisplayObjectContainer. mouseEnabled、mouseChildrenを変更するので専用のほうが良い.
		 */
		public function get container():DisplayObjectContainer { return $container; }
		
		public function set container(value:DisplayObjectContainer):void {
			$container = value;
			value.mouseEnabled = false;
			value.mouseChildren = false;
		}
		
		
		
	}

}