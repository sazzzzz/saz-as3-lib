package saz.outside.progression4 {
	import flash.events.*;
	import flash.net.*;
	import flash.trace.Trace;
	import jp.progression.commands.lists.*;
	import jp.progression.commands.net.*;
	import jp.progression.data.*;
	import jp.progression.executors.*;
	import saz.util.ArrayUtil;
	/**
	 * Progression4リソースマネージャ。リソースの一元管理を目的とする。
	 * ccjc.commonから持ってきた。
	 * @author saz
	 */
	public class ResourceManager extends EventDispatcher{
		
		private static var $instance:ResourceManager = null;
		
		private var $sList:SerialList;
		private var $urlList:Array;
		
		/**
		 * コンストラクタ。
		 * @param	caller
		 * @example <listing version="3.0" >
		 * rm = ResourceManager.getInstance();
		 * rm.addEventListener(ResourceEvent.COMPLETE, onComp);
		 * rm.addEventListener("testImg/czn-r-2.gif", onCznComp);
		 * rm.load("testImg/czn-r-2.gif");
		 * rm.load("testImg/indiacity-2.gif");
		 * rm.load("testImg/czn-r-2.gif");
		 * public function onIndiacityComp (e:ResourceEvent) {
		 * 	trace("ResManDoc.onIndiacityComp(", arguments);
		 * }
		 * public function onComp (e:ResourceEvent) {
		 * 	trace("ResManDoc.onComp(", arguments);
		 * }
		 * </listing>
		 */
		function ResourceManager(caller:Function = null) {
			if (ResourceManager.getInstance != caller) {
				throw new Error("ResourceManagerクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != ResourceManager.$instance) {
				throw new Error("ResourceManagerインスタンスはひとつしか生成できません。");
			}
			
			//ここからいろいろ書く
			$sList = new SerialList();
			$urlList = new Array();
		}
		
		public function load(url:String):void {
			if (null != getResourceById(url)) {
				// すでに読み込み済み
				dispatchEvent(new ResourceEvent(url,url));
				dispatchEvent(new ResourceEvent(ResourceEvent.COMPLETE,url));
			}else {
				// まだ
				if ($sList.state != ExecutorObjectState.EXECUTING) {
					//実行中じゃない
					$sList = new SerialList();
					ArrayUtil.removeAll($urlList);	//URLリストクリア。
					$addLoad(url);
					$sList.execute();
				}else {
					// 実行中
					$addLoad(url);
				}
			}
		}
		
		private function $addLoad(url:String):void {
			if ( -1 < ArrayUtil.find($urlList, url)) return;	// ロード中なら何もしない。
			
			$urlList.push(url);
			var req:URLRequest = new URLRequest(url);
			// TODO	タグ写真
			//if (!Define.TAGPHOTO_LOCAL) req.data = Define.getClearCacheVars();
			
			var scope:ResourceManager = this;
			$sList.addCommand(
				function():void {
				}
				//,new Trace("load start:"+ url)
				,new LoadBitmapData(req, {
					catchError:function(target:Object, error:Error):void {
						trace("ResourceManager LoadBitmapData エラー:");
						trace("target", target);
						trace("error", error);
						// FIXME	外側でエラー処理が書けるような実装が必要だ。
						//throw(error);
						this.executeComplete();	//次のコマンドに繋げるため終了通知。
					}
				})
				//,new Trace("load complete:"+ url)
				,function():void {
					scope.dispatchEvent(new ResourceEvent(url, url));
					scope.dispatchEvent(new ResourceEvent(ResourceEvent.COMPLETE, url));
				}
			);
		}
		
		
		/**
		 * シングルトン。
		 * @return
		 */
		public static function getInstance():ResourceManager {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new ResourceManager(arguments.callee);
			}
			return $instance;
		}
		
	}

}