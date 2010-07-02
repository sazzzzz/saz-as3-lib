﻿/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.92
 * @see http://progression.jp/
 * 
 * Progression Libraries is dual licensed under the "Progression Library License" and "GPL".
 * http://progression.jp/license
 */
package jp.progression.casts.buttons {
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.buttons.ButtonBase;
	import jp.progression.events.CastEvent;
	import jp.progression.events.ProcessEvent;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <span lang="ja">NextButton クラスは、ポインティングデバイスの状態に応じたタイムラインアニメーションを再生させるボタンコンポーネントクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class NextButton extends ButtonBase {
		
		/**
		 * <span lang="ja">関連付けたい Progression インスタンスの id プロパティを示すストリングを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get progressionId():String { return _progressionId; }
		public function set progressionId( value:String ):void {
			_progressionId = value;
			
			// 値を設定する
			super.sceneId = value ? new SceneId( "/" + value ) : null;
		}
		private var _progressionId:String;
		
		/**
		 * <span lang="ja">次のシーンが存在しない場合に、一番先頭のシーンに移動するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get useTurnBack():Boolean { return _useTurnBack; }
		public function set useTurnBack( value:Boolean ):void { _useTurnBack = value; }
		private var _useTurnBack:Boolean = false;
		
		/**
		 * <span lang="ja">キーボードの右矢印キーを押した際にボタンを有効化するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get useRightKey():Boolean { return _useRightKey; }
		public function set useRightKey( value:Boolean ):void { _useRightKey = value; }
		private var _useRightKey:Boolean = true;
		
		/**
		 * @private
		 */
		public override function get sceneId():SceneId { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "sceneId" ) ); }
		public override function set sceneId( value:SceneId ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "sceneId" ) ); }
		
		/**
		 * @private
		 */
		public override function get href():String { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "href" ) ); }
		public override function set href( value:String ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "href" ) ); }
		
		/**
		 * Progression インスタンスを取得します。
		 */
		private var _progression:Progression;
		
		/**
		 * Stage インスタンスを取得します。 
		 */
		private var _stage:Stage;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい NextButton インスタンスを作成します。</span>
		 * <span lang="en">Creates a new NextButton object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function NextButton( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( initObject );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( CastEvent.UPDATE, _update, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _addedToStage( e:Event ):void {
			// stage の参照を保存する
			_stage = stage;
			
			// イベントリスナーを登録する
			_stage.addEventListener( KeyboardEvent.KEY_UP, _keyUp, false, int.MAX_VALUE, true );
		}
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _removedFromStage( e:Event ):void {
			// イベントリスナーを解除する
			_stage.removeEventListener( KeyboardEvent.KEY_UP, _keyUp );
			
			// stage の参照を破棄する
			_stage = null;
		}
		
		/**
		 * CastButton インスタンスと Progression インスタンスとの関連付けが更新されたときに送出されます。
		 */
		private function _update( e:CastEvent ):void {
			// 存在していれば、イベントリスナーを解除する
			if ( _progression ) {
				_progression.completelyRemoveEventListener( ProcessEvent.PROCESS_SCENE, _processScene );
			}
			
			// progression を設定する
			_progression = progression;
			
			// 存在していれば、イベントリスナーを登録する
			if ( _progression ) {
				_progression.addExclusivelyEventListener( ProcessEvent.PROCESS_SCENE, _processScene, false, int.MAX_VALUE, true );
				_processScene( new ProcessEvent( ProcessEvent.PROCESS_SCENE, false, false, _progression.current, _progression.eventType ) );
			}
		}
		
		/**
		 * シーン移動処理中に対象シーンが変更された場合に送出されます。
		 */
		private function _processScene( e:ProcessEvent ):void {
			var current:SceneObject = e.scene;
			
			// 存在しなければ
			if ( !current ) {
				buttonEnabled = false;
				return;
			}
			
			var next:SceneObject = current.next;
			var parent:SceneObject = current.parent;
			next ||= ( parent && _useTurnBack ) ? parent.getSceneAt( 0 ) : current;
			
			// 移動先を指定する
			super.sceneId = next.sceneId.clone();
			
			// 次のシーンが現在のシーンと同じであれば無効化する
			buttonEnabled = !( next == current );
		}
		
		/**
		 * ユーザーがキーを離したときに送出されます。
		 */
		private function _keyUp( e:KeyboardEvent ):void {
			switch ( true ) {
				case !_useRightKey		:
				case e.shiftKey			:
				case e.ctrlKey			:
				case e.keyCode != 39	: { return; }
				default					: {
					// 移動する
					navigateTo();
				}
			}
		}
	}
}
