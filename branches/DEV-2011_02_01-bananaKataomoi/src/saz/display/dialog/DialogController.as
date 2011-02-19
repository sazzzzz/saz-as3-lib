package saz.display.dialog {
	import jp.progression.casts.*;
	import jp.progression.commands.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	/**
	 * ダイアログコントローラ.
	 * @author saz
	 * 
	 * @example <listing version="3.0" >
	 * DialogController.getInstance().init(sprite);
	 * //背景用Sprite
	 * DialogController.getInstance().background = new SimpleDialogBackground({
	 * 	fillRect:new Rectangle(0,0,stage.stageWidth,stage.stageHeight)
	 * 	,time:1/4
	 * 	,maxAlpha:0.5
	 * });
	 * //アラートダイアログを登録
	 * var alert:CastSprite = new AlertDialog();
	 * alert.addEventListener(DialogEvent.CLOSE,function(e:DialogEvent):void{
	 * 	trace("dia1 CLOSE", e);
	 * });
	 * DialogController.getInstance().add(alert,"alert");
	 * DialogController.getInstance().show("alert");
	 * </listing>
	 */
	public class DialogController{
		
		public var container:CastSprite;
		public var background:CastSprite;
		
		public var isReady:Boolean = false;
		
		static private var $instance:DialogController = null;
		
		private var $dias:Object;
		private var $showCount:int = 0;
		private var $isBackgroundShown:Boolean = false;
		
		function DialogController(caller:Function = null) {
			if (DialogController.getInstance != caller) {
				throw new Error("DialogControllerクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != DialogController.$instance) {
				throw new Error("DialogControllerインスタンスはひとつしか生成できません。");
			}
			
			//ここからいろいろ書く
		}
		
		private function $getEntry(id:String):Object {
			return $dias[id];
		}
		
		private function $updateBackground():void {
			if (!background) return;
			if ($showCount > 0) {
				showBackground();
			}else {
				hideBackground();
			}
		}
		
		private function $dialog_close(e:DialogEvent):void {
			hide(e.target.id);
		}
		
		/**
		 * 初期化
		 * @param	cast	コンテナとなるCastSpriteインスタンス。
		 */
		public function init(cast:CastSprite):void {
			if (null == cast) return;
			isReady = true;
			container = cast;
			
			$dias = new Object();
			$showCount = 0;
		}
		
		/**
		 * ダイアログを登録。
		 * @param	dialog	ダイアログとして使用するCastSprite。
		 * @param	id	識別子。
		 * @param	index	（オプション）表示深度。
		 * @return
		 */
		public function add(dialog:CastSprite, id:String, index:int = -1):Boolean {
			if ($getEntry(id)) return false;
			
			dialog.id = id;
			//dialog.controller = this;
			dialog.addEventListener(DialogEvent.CLOSE, $dialog_close);
			$dias[id] = {id:id, cast:dialog, index:index, isShown:false};
			return true;
		}
		
		/**
		 * ダイアログを登録解除。
		 * @param	id	識別子。
		 * @return
		 */
		public function remove(id:String):Boolean {
			if (!$getEntry(id)) return false;
			
			getItem(id).removeEventListener(DialogEvent.CLOSE, $dialog_close);
			$dias[id] = null;
			return true;
		}
		
		/**
		 * ダイアログを表示。
		 * @param	id	識別子。
		 */
		public function show(id:String):void {
			var cast:CastSprite = getItem(id);
			if (container.contains(cast)) return;
			if ($getEntry(id).isShown) return;
			
			$getEntry(id).isShown = true;
			$showCount++;
			$updateBackground();
			var slist:SerialList = new SerialList(null
				,new Func(function():void {
					if ($getEntry(id).index > -1) {
						this.parent.insertCommand(new AddChildAt(container, cast, $getEntry(id).index));
					}else {
						this.parent.insertCommand(new AddChild(container, cast));
					}
				})
			);
			slist.execute();
		}
		
		/**
		 * ダイアログを消す。
		 * @param	id	識別子。
		 */
		public function hide(id:String):void {
			var cast:CastSprite = getItem(id);
			if (!container.contains(cast)) return;
			if (!$getEntry(id).isShown) return;
			
			$getEntry(id).isShown = false;
			$showCount--;
			$updateBackground();
			var slist:SerialList = new SerialList(null
				,new RemoveChild(container, cast)
			);
			slist.execute();
		}
		
		
		/**
		 * backgroundを表示。
		 */
		public function showBackground():void {
			if ($isBackgroundShown) return;
			if (container.contains(background)) return;
			$isBackgroundShown = true;
			new AddChildAt(container, background, 0).execute();
		}
		
		/**
		 * backgroundを消す。
		 */
		public function hideBackground():void {
			if (!$isBackgroundShown) return;
			if (!container.contains(background)) return;
			$isBackgroundShown = false;
			new RemoveChild(container, background).execute();
		}
		
		
		/**
		 * ダイアログを返す。
		 * @param	id	識別子。
		 * @return
		 */
		public function getItem(id:String):CastSprite {
			return $getEntry(id).cast;
		}
		
		/**
		 * インスタンスを生成する。
		 * @return
		 */
		public static function getInstance():DialogController {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new DialogController(arguments.callee);
			}
			return $instance;
		}
	}

}