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
package jp.progression.scenes {
	import flash.errors.IllegalOperationError;
	import flash.utils.getDefinitionByName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	import jp.nium.events.EventIntegrator;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.XMLUtil;
	import jp.progression.core.collections.SceneCollection;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.commands.ICommandExecutable;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.parser.PRMLParser;
	import jp.progression.core.scenes.SceneInfo;
	import jp.progression.events.ProcessEvent;
	import jp.progression.events.SceneEvent;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">シーン移動時に目的地がシーンオブジェクト自身もしくは子階層だった場合に、階層が変更された瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.LOAD
	 */
	[Event( name="load", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーン移動時に目的地がシーンオブジェクト自身もしくは親階層だった場合に、階層が変更された瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.UNLOAD
	 */
	[Event( name="unload", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーンオブジェクトが目的地だった場合に、到達した瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.INIT
	 */
	[Event( name="init", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーンオブジェクトが出発地だった場合に、移動を開始した瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.GOTO
	 */
	[Event( name="goto", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーン移動時に目的地がシーンオブジェクトの子階層であり、かつ出発地ではない場合に、移動を中継した瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.DESCEND
	 */
	[Event( name="descend", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーン移動時に目的地がシーンオブジェクトの親階層であり、かつ出発地ではない場合に、移動を中継した瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.ASCEND
	 */
	[Event( name="ascend", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーンオブジェクトがシーンリストに追加された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_ADDED
	 */
	[Event( name="sceneAdded", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの追加により、ルートシーン上のシーンリストに追加されたときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_ADDED_TO_ROOT
	 */
	[Event( name="sceneAddedToRoot", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーンオブジェクトがシーンリストから削除された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_REMOVED
	 */
	[Event( name="sceneRemoved", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの削除により、ルートシーン上のシーンリストから削除されようとしているときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_REMOVED_FROM_ROOT
	 */
	[Event( name="sceneRemovedFromRoot", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーンオブジェクトのタイトルが変更された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_TITLE
	 */
	[Event( name="sceneTitle", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">シーンオブジェクトの状態が変更された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_STATE_CHANGE
	 */
	[Event( name="sceneStateChange", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <span lang="ja">SceneObject クラスは、シーンコンテナとして機能する全てのオブジェクトの基本クラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class SceneObject extends EventIntegrator implements ICommandExecutable {
		
		/**
		 * シーン名を判別する正規表現を取得します。
		 */
		private static const _NAME_REGEXP:RegExp = new RegExp( "^scene_[0-9]+$" );
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal static function get __owner():Progression { return _owner; }
		progression_internal static function set __owner( value:Progression ):void { _owner = value; }
		private static var _owner:Progression;
		
		
		
		
		
		/**
		 * <span lang="ja">インスタンスのクラス名を取得します。</span>
		 * <span lang="en">Indicates the instance className of the SceneObject.</span>
		 */
		public function get className():String { return _className; }
		private var _className:String;
		
		/**
		 * <span lang="ja">インスタンスの名前を取得または設定します。</span>
		 * <span lang="en">Indicates the instance name of the SceneObject.</span>
		 */
		public function get name():String { return _name; }
		public function set name( value:String ):void {
			value ||= _uniqueName;
			
			switch ( true ) {
				case _root == this						: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9003" ) ); }
				case value == _uniqueName				: { break; }
				case !SceneId.validate( "/" + value )	:
				case _NAME_REGEXP.test( value )			: { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_9034" ) ); }
			}
			
			_name = value;
		}
		private var _name:String;
		private var _uniqueName:String;
		
		/**
		 * <span lang="ja">インスタンスの識別子を取得または設定します。</span>
		 * <span lang="en">Indicates the instance id of the SceneObject.</span>
		 */
		public function get id():String { return _id; }
		public function set id( value:String ):void { _id = SceneCollection.progression_internal::__addInstanceAtId( this, value ); }
		private var _id:String;
		
		/**
		 * <span lang="ja">インスタンスのグループ名を取得または設定します。</span>
		 * <span lang="en">Indicates the instance group of the SceneObject.</span>
		 */
		public function get group():String { return _group; }
		public function set group( value:String ):void { _group = SceneCollection.progression_internal::__addInstanceAtGroup( this, value ); }
		private var _group:String;
		
		/**
		 * <span lang="ja">シーン識別子を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get sceneId():SceneId {
			// 親が存在しなければ null を返す
			if ( !_root ) { return null; }
			
			// ルートが自分であれば
			if ( _root == this ) { return new SceneId( "/" + name ); }
			
			return new SceneId( _parent.sceneId.path + "/" + name );
		}
		
		/**
		 * <span lang="ja">関連付けられている Progression インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get progression():Progression { return _progression; }
		private function get _progression():Progression { return __progression; }
		private function set _progression( value:Progression ):void {
			// 設定が存在していれば
			if ( __progression ) {
				// イベントリスナーを解除する
				__progression.completelyRemoveEventListener( ProcessEvent.PROCESS_SCENE, _processScene );
			}
			
			__progression = value;
			
			// 設定が存在していれば
			if ( __progression ) {
				// イベントリスナーを登録する
				__progression.addExclusivelyEventListener( ProcessEvent.PROCESS_SCENE, _processScene, false, int.MAX_VALUE, true );
			}
			
			// 子の関連性を再設定する
			var l:int = _scenes.length;
			for ( var i:int = 0; i < l; i++ ) {
				SceneObject( _scenes[i] )._progression = value;
			}
		}
		private var __progression:Progression;
		
		/**
		 * <span lang="ja">シーンオブジェクトのツリー構造部分の一番上にある SceneObject インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get root():SceneObject { return __root; }
		private function get _root():SceneObject { return __root; }
		private function set _root( value:SceneObject ):void {
			__root = value;
			
			// 子の関連性を再設定する
			var l:int = _scenes.length;
			for ( var i:int = 0; i < l; i++ ) {
				SceneObject( _scenes[i] )._root = value;
			}
		}
		private var __root:SceneObject;
		
		/**
		 * <span lang="ja">このシーンオブジェクトを子に含んでいる親シーンオブジェクトを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get parent():SceneObject { return _parent; }
		private var _parent:SceneObject;
		
		/**
		 * <span lang="ja">このシーンオブジェクトの次に位置するシーンオブジェクトを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get next():SceneObject { return _next; }
		private var _next:SceneObject;
		
		/**
		 * <span lang="ja">このシーンオブジェクトの前に位置するシーンオブジェクトを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get previous():SceneObject { return _previous; }
		private var _previous:SceneObject;
		
		/**
		 * <span lang="ja">子シーンオブジェクトが保存されている配列です。
		 * この配列を操作することで元の配列を変更することはできません。</span>
		 * <span lang="en"></span>
		 */
		public function get scenes():Array { return _scenes.slice(); }
		private var _scenes:Array = [];
		
		/**
		 * <span lang="ja">子シーンオブジェクトの数を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get numScenes():int { return scenes.length; }
		
		/**
		 * <span lang="ja">カレントシーンであるかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get isCurrent():Boolean { return _isCurrent; }
		private var _isCurrent:Boolean = false;
		
		/**
		 * <span lang="ja">カレントシーンの親シーンであるかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get isParent():Boolean { return _isParent; }
		private var _isParent:Boolean = false;
		
		/**
		 * <span lang="ja">カレントシーンの子シーンであるかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get isChild():Boolean { return _isChild; }
		private var _isChild:Boolean = false;
		
		/**
		 * <span lang="ja">既読であるかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get isVisited():Boolean { return _isVisited; }
		private var _isVisited:Boolean = false;
		
		/**
		 * <span lang="ja">自身がカレントシーンの場合に、ブラウザのタイトルとして使用される文字列を取得または設定します。
		 * ただし、設定を有効化するためには、ブラウザ同期機能が有効化されている必要があります。</span>
		 * <span lang="en"></span>
		 */
		public function get title():String { return _title || ( parent ? parent.title + " | " : "" ) + _name; }
		public function set title( value:String ):void {
			_title = value;
			
			// イベントを送出する
			dispatchEvent( new SceneEvent( SceneEvent.SCENE_TITLE, false, false, this ) );
		}
		private var _title:String;
		
		/**
		 * <span lang="ja">CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get parallelMode():Boolean { return _executor.progression_internal::__parallelMode; }
		public function set parallelMode( value:Boolean ):void { _executor.progression_internal::__parallelMode = value; }
		
		/**
		 * <span lang="ja">コマンドを実行する CommandExecutor インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get executor():CommandExecutor { return _executor; }
		private var _executor:CommandExecutor;
		
		/**
		 * <span lang="ja">このオブジェクトが属するシーン情報を含む SceneInfo オブジェクトを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get sceneInfo():SceneInfo { return _sceneInfo; }
		private var _sceneInfo:SceneInfo;
		
		/**
		 * <span lang="ja">オブジェクトのイベントハンドラメソッドを有効化するかどうかを指定します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventHandlerEnabled():Boolean { return _eventHandlerEnabled; }
		public function set eventHandlerEnabled( value:Boolean ):void {
			if ( _eventHandlerEnabled = value ) {
				// イベントリスナーを登録する
				addExclusivelyEventListener( SceneEvent.LOAD, _load, false, 0, true );
				addExclusivelyEventListener( SceneEvent.UNLOAD, _unload, false, 0, true );
				addExclusivelyEventListener( SceneEvent.GOTO, _goto, false, 0, true );
				addExclusivelyEventListener( SceneEvent.DESCEND, _descend, false, 0, true );
				addExclusivelyEventListener( SceneEvent.ASCEND, _ascend, false, 0, true );
				addExclusivelyEventListener( SceneEvent.SCENE_ADDED, _sceneAdded, false, 0, true );
				addExclusivelyEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, _sceneAddedToRoot, false, 0, true );
				addExclusivelyEventListener( SceneEvent.SCENE_REMOVED, _sceneRemoved, false, 0, true );
				addExclusivelyEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, _sceneRemovedFromRoot, false, 0, true );
				addExclusivelyEventListener( SceneEvent.SCENE_TITLE, _sceneTitle, false, 0, true );
				addExclusivelyEventListener( SceneEvent.SCENE_STATE_CHANGE, _sceneStateChange, false, 0, true );
			}
			else {
				// イベントリスナーを解除する
				completelyRemoveEventListener( SceneEvent.LOAD, _load );
				completelyRemoveEventListener( SceneEvent.UNLOAD, _unload );
				completelyRemoveEventListener( SceneEvent.GOTO, _goto );
				completelyRemoveEventListener( SceneEvent.DESCEND, _descend );
				completelyRemoveEventListener( SceneEvent.ASCEND, _ascend );
				completelyRemoveEventListener( SceneEvent.SCENE_ADDED, _sceneAdded );
				completelyRemoveEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, _sceneAddedToRoot );
				completelyRemoveEventListener( SceneEvent.SCENE_REMOVED, _sceneRemoved );
				completelyRemoveEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, _sceneRemovedFromRoot );
				completelyRemoveEventListener( SceneEvent.SCENE_TITLE, _sceneTitle );
				completelyRemoveEventListener( SceneEvent.SCENE_STATE_CHANGE, _sceneStateChange );
			}
		}
		private var _eventHandlerEnabled:Boolean = true;
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.LOAD イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onLoad():Function { return __onLoad || _onLoad; }
		public function set onLoad( value:Function ):void { __onLoad = value; }
		private var __onLoad:Function;
		
		/**
		 * <span lang="ja">サブクラスで onLoad イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onLoad プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onLoad():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.UNLOAD イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onUnload():Function { return __onUnload || _onUnload; }
		public function set onUnload( value:Function ):void { __onUnload = value; }
		private var __onUnload:Function;
		
		/**
		 * <span lang="ja">サブクラスで onUnload イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onUnload プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onUnload():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.INIT イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onInit():Function { return __onInit || _onInit; }
		public function set onInit( value:Function ):void { __onInit = value; }
		private var __onInit:Function;
		
		/**
		 * <span lang="ja">サブクラスで onInit イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onInit プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onInit():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.GOTO イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onGoto():Function { return __onGoto || _onGoto; }
		public function set onGoto( value:Function ):void { __onGoto = value; }
		private var __onGoto:Function;
		
		/**
		 * <span lang="ja">サブクラスで onGoto イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onGoto プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onGoto():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.DESCEND イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onDescend():Function { return __onDescend || _onDescend; }
		public function set onDescend( value:Function ):void { __onDescend = value; }
		private var __onDescend:Function;
		
		/**
		 * <span lang="ja">サブクラスで onDescend イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onDescend プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onDescend():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.ASCEND イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onAscend():Function { return __onAscend || _onAscend; }
		public function set onAscend( value:Function ):void { __onAscend = value; }
		private var __onAscend:Function;
		
		/**
		 * <span lang="ja">サブクラスで onAscend イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onAscend プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onAscend():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.SCENE_ADDED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get onSceneAdded():Function { return __onSceneAdded || _onSceneAdded; }
		public function set onSceneAdded( value:Function ):void { __onSceneAdded = value; }
		private var __onSceneAdded:Function;
		
		/**
		 * <span lang="ja">サブクラスで onSceneAdded イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onSceneAdded プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onSceneAdded():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.SCENE_ADDED_TO_ROOT イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get onSceneAddedToRoot():Function { return __onSceneAddedToRoot || _onSceneAddedToRoot; }
		public function set onSceneAddedToRoot( value:Function ):void { __onSceneAddedToRoot = value; }
		private var __onSceneAddedToRoot:Function;
		
		/**
		 * <span lang="ja">サブクラスで onSceneAddedToRoot イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onSceneAddedToRoot プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onSceneAddedToRoot():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.SCENE_REMOVED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get onSceneRemoved():Function { return __onSceneRemoved || _onSceneRemoved; }
		public function set onSceneRemoved( value:Function ):void { __onSceneRemoved = value; }
		private var __onSceneRemoved:Function;
		
		/**
		 * <span lang="ja">サブクラスで onSceneRemoved イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onSceneRemoved プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onSceneRemoved():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.SCENE_REMOVED_FROM_ROOT イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get onSceneRemovedFromRoot():Function { return __onSceneRemovedFromRoot || _onSceneRemovedFromRoot; }
		public function set onSceneRemovedFromRoot( value:Function ):void { __onSceneRemovedFromRoot = value; }
		private var __onSceneRemovedFromRoot:Function;
		
		/**
		 * <span lang="ja">サブクラスで onSceneRemovedFromRoot イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onSceneRemovedFromRoot プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onSceneRemovedFromRoot():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.SCENE_TITLE イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get onSceneTitle():Function { return __onSceneTitle || _onSceneTitle; }
		public function set onSceneTitle( value:Function ):void { __onSceneTitle = value; }
		private var __onSceneTitle:Function;
		
		/**
		 * <span lang="ja">サブクラスで onSceneTitle イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onSceneTitle プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onSceneTitle():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが SceneEvent.SCENE_STATUS_CHANGE イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get onSceneStateChange():Function { return __onSceneStateChange || _onSceneStateChange; }
		public function set onSceneStateChange( value:Function ):void { __onSceneStateChange = value; }
		private var __onSceneStateChange:Function;
		
		/**
		 * <span lang="ja">サブクラスで onSceneStateChange イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onSceneStateChange プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onSceneStateChange():void {}
		
		
		
		
		
		/**
		 * <span lang="ja">新しい SceneObject インスタンスを作成します。</span>
		 * <span lang="en">Creates a new SceneObject object.</span>
		 * 
		 * @param name
		 * <span lang="ja">シーンの名前です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function SceneObject( name:String = null, initObject:Object = null ) {
			// クラス名を取得する
			_className = ClassUtil.getClassName( this );
			
			// SceneCollection に登録する
			SceneCollection.progression_internal::__addInstance( this );
			
			// ユニーク名を設定する
			_uniqueName = "scene_" + SceneCollection.progression_internal::__getNumByInstance( this );
			
			// 引数を設定する
			this.name = name;
			
			// 初期化する
			eventHandlerEnabled = true;
			
			// SceneInfo を作成する
			_sceneInfo = SceneInfo.progression_internal::__createInstance( this );
			
			// CommandExecutor を作成する
			_executor = CommandExecutor.progression_internal::__createInstance( this );
			
			// 初期化する
			setProperties( initObject );
			
			// リスナーを登録する
			addExclusivelyEventListener( SceneEvent.INIT, _init, false, 0, true );
			
			// _owner が存在すれば
			if ( _owner ) {
				this.name = _owner.id;
				_progression = _owner;
				_root = this;
				_owner = null;
			}
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定された id と同じ値が設定されている SceneObject インスタンスを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param id
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function getSceneById( id:String ):SceneObject {
			return SceneCollection.progression_internal::__getInstanceById( id );
		}
		
		/**
		 * <span lang="ja">指定された sceneId と同じ値が設定されている SceneObject インスタンスを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param sceneId
		 * <span lang="ja">条件となる SceneId インスタンスです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function getSceneBySceneId( sceneId:SceneId ):SceneObject {
			return SceneCollection.progression_internal::__getInstanceBySceneId( sceneId );
		}
		
		/**
		 * <span lang="ja">指定された group と同じ値を持つ SceneObject インスタンスを含む配列を返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param group
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en"></span>
		 * @param sort
		 * <span lang="ja">配列をソートするかどうかを指定します。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function getScenesByGroup( group:String, sort:Boolean = false ):Array {
			return SceneCollection.progression_internal::__getInstancesByGroup( group, sort );
		}
		
		/**
		 * <span lang="ja">指定された fieldName が条件と一致する SceneObject インスタンスを含む配列を返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param fieldName
		 * <span lang="ja">調査するフィールド名です。</span>
		 * <span lang="en"></span>
		 * @param pattern
		 * <span lang="ja">条件となる正規表現です。</span>
		 * <span lang="en"></span>
		 * @param sort
		 * <span lang="ja">配列をソートするかどうかを指定します。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function getScenesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
			return SceneCollection.progression_internal::__getInstancesByRegExp( fieldName, pattern, sort );
		}
		
		/**
		 * <span lang="ja">特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">追加したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 */
		public function addCommand( ... commands:Array ):void {
			_executor.progression_internal::__addCommand.apply( null, commands );
		}
		
		/**
		 * <span lang="ja">特定のイベントが送出された際に、自動実行させたい Command インスタンスをすでにリストに登録され、実行中の Command インスタンスの次の位置に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">追加したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 */
		public function insertCommand( ... commands:Array ):void {
			_executor.progression_internal::__insertCommand.apply( null, commands );
		}
		
		/**
		 * <span lang="ja">登録されている Command インスタンスを消去します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param completely
		 * <span lang="ja">登録されている全てのコマンドを消去する場合には true を、現在処理しているコマンド以降を消去する場合には false となります。</span>
		 * <span lang="en"></span>
		 */
		public function clearCommand( completely:Boolean = false ):void {
			_executor.progression_internal::__clearCommand( completely );
		}
		
		/**
		 * <span lang="ja">インスタンスに対して、複数のプロパティを一括設定します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param props
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">設定対象の SceneObject インスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function setProperties( props:Object ):SceneObject {
			ObjectUtil.setProperties( this, props );
			return this;
		}
		
		/**
		 * シーンオブジェクトを登録します。
		 */
		private function _registerScene( scene:SceneObject, index:int ):SceneObject {
			// ルートであればエラーを送出する
			if ( scene.root == scene ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9033" ) ); }
			
			// すでに親が存在していれば解除する
			if ( scene.parent ) {
				scene.parent._unregisterScene( scene );
			}
			
			// 登録する
			_scenes.splice( index, 0, scene );
			
			// 現在のルートシーンを取得する
			var previousRoot:SceneObject = scene._root;
			
			// 前後を取得する
			var next:SceneObject = _scenes[index + 1];
			var previous:SceneObject = _scenes[index - 1];
			
			// 親子関係を設定する
			scene._progression = progression;
			scene._root = root;
			scene._parent = this;
			scene._next = next;
			scene._previous = previous;
			
			// 前後関係を設定する
			( next && ( next._previous = scene ) );
			( previous && ( previous._next = scene ) );
			
			// イベントリスナーを登録する
			scene.addExclusivelyEventListener( SceneEvent.SCENE_ADDED, dispatchEvent, false, int.MAX_VALUE, true );
			scene.addExclusivelyEventListener( SceneEvent.SCENE_REMOVED, dispatchEvent, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, scene.dispatchEvent, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, scene.dispatchEvent, false, int.MAX_VALUE, true );
			
			// イベントを送出する
			scene.dispatchEvent( new SceneEvent( SceneEvent.SCENE_ADDED, false, false, scene ) );
			
			// ルートシーンが存在し、変更されていれば
			if ( root && previousRoot != root ) {
				// イベントを送出する
				scene.dispatchEvent( new SceneEvent( SceneEvent.SCENE_ADDED_TO_ROOT, false, false, scene ) );
			}
			
			return scene;
		}
		
		/**
		 * シーンオブジェクトの登録を削除します。
		 */
		private function _unregisterScene( scene:SceneObject ):SceneObject {
			var l:int = _scenes.length;
			for ( var i:int = 0; i < l; i++ ) {
				var child:SceneObject = SceneObject( _scenes[i] );
				
				// 違っていれば次へ
				if ( child != scene ) { continue; }
				
				// 前後を取得する
				var next:SceneObject = _scenes[i + 1];
				var previous:SceneObject = _scenes[i - 1];
				
				// 現在のルートシーンを取得する
				var previousRoot:SceneObject = scene._root;
				
				// 親子関係を設定する
				scene._progression = null;
				scene._root = null;
				scene._parent = null;
				scene._next = null;
				scene._previous = null;
				scene._isChild = false;
				scene._isCurrent = false;
				scene._isParent = false;
				scene._isVisited = false;
				
				// 前後関係を設定する
				if ( next ) {
					next._previous = previous;
				}
				if ( previous ) {
					previous._next = next;
				}
				
				// 登録を解除する
				_scenes.splice( i, 1 );
				
				// イベントを送出する
				scene.dispatchEvent( new SceneEvent( SceneEvent.SCENE_REMOVED, false, false, scene ) );
				
				// ルートシーンが存在せず、変更されていれば
				if ( !scene._root && previousRoot != scene._root ) {
					// イベントを送出する
					scene.dispatchEvent( new SceneEvent( SceneEvent.SCENE_REMOVED_FROM_ROOT, false, false, scene ) );
				}
				
				// イベントリスナーを解除する
				scene.completelyRemoveEventListener( SceneEvent.SCENE_ADDED, dispatchEvent );
				scene.completelyRemoveEventListener( SceneEvent.SCENE_REMOVED, dispatchEvent );
				completelyRemoveEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, scene.dispatchEvent );
				completelyRemoveEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, scene.dispatchEvent );
				return scene;
			}
			
			return scene;
		}
		
		/**
		 * <span lang="ja">この SceneObject インスタンスに子 SceneObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a scene SceneObject instance to this SceneObject instance.</span>
		 * 
		 * @param scene
		 * <span lang="ja">対象の SceneObject インスタンスの子として追加する SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance to add as a scene of this SceneObject instance.</span>
		 * @return
		 * <span lang="ja">scene パラメータで渡す SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance that you pass in the scene parameter.</span>
		 */
		public function addScene( scene:SceneObject ):SceneObject {
			return _registerScene( scene, _scenes.length );
		}
		
		/**
		 * <span lang="ja">この SceneObject インスタンスの指定されたインデックス位置に子 SceneObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a scene SceneObject instance to this SceneObject instance.</span>
		 * 
		 * @param scene
		 * <span lang="ja">対象の SceneObject インスタンスの子として追加する SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance to add as a scene of this SceneObject instance.</span>
		 * @param index
		 * <span lang="ja">子を追加するインデックス位置です。</span>
		 * <span lang="en">The index position to which the scene is added. If you specify a currently occupied index position, the scene object that exists at that position and all higher positions are moved up one position in the scene list.</span>
		 * @return
		 * <span lang="ja">child パラメータで渡す SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance that you pass in the scene parameter.</span>
		 */
		public function addSceneAt( scene:SceneObject, index:int ):SceneObject {
			if ( index < 0 || _scenes.length < index ) { throw new RangeError( ErrorMessageConstants.getMessage( "ERROR_2006" ) ); }
			return _registerScene( scene, index );
		}
		
		/**
		 * <span lang="ja">この SceneObject インスタンスの指定されたインデックス位置に子 SceneObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a scene SceneObject instance to this SceneObject instance.</span>
		 * 
		 * @param scene
		 * <span lang="ja">対象の SceneObject インスタンスの子として追加する SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance to add as a scene of this SceneObject instance.</span>
		 * @param index
		 * <span lang="ja">子を追加するインデックス位置です。</span>
		 * <span lang="en">The index position to which the scene is added. If you specify a currently occupied index position, the scene object that exists at that position and all higher positions are moved up one position in the scene list.</span>
		 * @return
		 * <span lang="ja">child パラメータで渡す SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance that you pass in the scene parameter.</span>
		 */
		public function addSceneAtAbove( scene:SceneObject, index:int ):SceneObject {
			if ( index < 0 || _scenes.length < index ) { throw new RangeError( ErrorMessageConstants.getMessage( "ERROR_2006" ) ); }
			return _registerScene( scene, index + 1 );
		}
		
		/**
		 * <span lang="ja">この SceneObject インスタンスの子を PRML 形式の XML データから追加します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param xml
		 * <span lang="ja">PRML 形式の XML データです。</span>
		 * <span lang="en"></span>
		 */
		public function addSceneFromXML( xml:XML ):void {
			// PRMLParserを作成する
			var parser:PRMLParser = new PRMLParser( xml );
			
			// シーンを走査する
			for each ( var scene:XML in parser.scenes ) {
				// クラスの参照を作成する
				var classRef:Class = getDefinitionByName( scene.attribute( "cls" ) ) as Class;
				
				// 存在しなければ次へ
				if ( !classRef ) { continue; }
				
				// SceneObject を作成する
				var child:SceneObject = new classRef() as SceneObject;
				
				// 存在しなければ次へ
				if ( !child ) { continue; }
				
				// シーンリストに追加する
				child.setProperties( XMLUtil.xmlToObject( scene.attributes() ) );
				child.addSceneFromXML( parser.toPRMLString( scene.children() ) );
				child.sceneInfo.progression_internal::__data = scene.children().( name() != "scene" ) as XMLList;
				addScene( child );
			}
		}
		
		/**
		 * <span lang="ja">SceneObject インスタンスの子リストから指定の SceneObject インスタンスを削除します。</span>
		 * <span lang="en">Removes the specified scene SceneObject instance from the scene list of the SceneObject instance.</span>
		 * 
		 * @param scene
		 * <span lang="ja">対象の SceneObject インスタンスの子から削除する SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance to remove.</span>
		 * @return
		 * <span lang="ja">scene パラメータで渡す SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance that you pass in the scene parameter.</span>
		 */
		public function removeScene( scene:SceneObject ):SceneObject {
			return _unregisterScene( scene );
		}
		
		/**
		 * <span lang="ja">SceneObject の子リストの指定されたインデックス位置から子 SceneObject インスタンスを削除します。</span>
		 * <span lang="en">Removes a child SceneObject from the specified index position in the child list of the SceneObject.</span>
		 * 
		 * @param index
		 * <span lang="ja">削除する SceneObject の子インデックスです。</span>
		 * <span lang="en">The child index of the SceneObject to remove.</span>
		 * @return
		 * <span lang="ja">削除された SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance that was removed.</span>
		 */
		public function removeSceneAt( index:int ):SceneObject {
			return _unregisterScene( getSceneAt( index ) );
		}
		
		/**
		 * <span lang="ja">SceneObject に追加されている全ての子 SceneObject インスタンスを削除します。</span>
		 * <span lang="en"></span>
		 */
		public function removeAllScenes():void {
			while ( _scenes.length > 0 ) {
				removeScene( _scenes[0] );
			}
		}
		
		/**
		 * <span lang="ja">指定されたシーンオブジェクトが SceneObject インスタンスの子であるか、オブジェクト自体であるかを指定します。</span>
		 * <span lang="en">Determines whether the specified SceneObject is a scene of the SceneObject instance or the instance itself.</span>
		 * 
		 * @param scene
		 * <span lang="ja">テストする子 SceneObject インスタンスです。</span>
		 * <span lang="en">The scene object to test.</span>
		 * @return
		 * <span lang="ja">child インスタンスが SceneObject の子であるか、コンテナ自体である場合は true となります。そうでない場合は false となります。</span>
		 * <span lang="en">true if the scene object is a scene of the SceneObject or the container itself; otherwise false.</span>
		 */
		public function contains( scene:SceneObject ):Boolean {
			// 自身であれば true を返す
			if ( scene == this ) { return true; }
			
			// 子または孫に存在すれば true を返す
			var l:int = _scenes.length;
			for ( var i:int = 0; i < l; i++ ) {
				var target:SceneObject = SceneObject( _scenes[i] );
				
				if ( target == scene ) { return true; }
				if ( target.contains( scene ) ) { return true; }
			}
			
			return false;
		}
		
		/**
		 * <span lang="ja">指定のインデックス位置にある子シーンオブジェクトオブジェクトを返します。</span>
		 * <span lang="en">Returns the scene SceneObject instance that exists at the specified index.</span>
		 * 
		 * @param index
		 * <span lang="ja">子 SceneObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the scene object.</span>
		 * @return
		 * <span lang="ja">指定されたインデックス位置にある子 SceneObject インスタンスです。</span>
		 * <span lang="en">The scene SceneObject at the specified index position.</span>
		 */
		public function getSceneAt( index:int ):SceneObject {
			return _scenes[index] as SceneObject;
		}
		
		/**
		 * <span lang="ja">指定された名前に一致する子シーンオブジェクトを返します。</span>
		 * <span lang="en">Returns the scene SceneObject that exists with the specified name.</span>
		 * 
		 * @param name
		 * <span lang="ja">返される子 SceneObject インスタンスの名前です。</span>
		 * <span lang="en">The name of the scene to return.</span>
		 * @return
		 * <span lang="ja">指定された名前を持つ子 SceneObject インスタンスです。</span>
		 * <span lang="en">The scene SceneObject with the specified name.</span>
		 */
		public function getSceneByName( name:String ):SceneObject {
			if ( !_scenes ) { return null; }
			
			for ( var i:int = _scenes.length; 0 < i; i-- ) {
				var scene:SceneObject = SceneObject( _scenes[i - 1] );
				if ( scene.name == name ) { return scene; }
			}
			
			return null;
		}
		
		/**
		 * <span lang="ja">子 SceneObject インスタンスのインデックス位置を返します。</span>
		 * <span lang="en">Returns the index position of a scene SceneObject instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">特定する子 SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance to identify.</span>
		 * @return
		 * <span lang="ja">特定する子 SceneObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the scene SceneObject to identify.</span>
		 */
		public function getSceneIndex( scene:SceneObject ):int {
			var l:int = _scenes.length;
			for ( var i:int = 0; i < l; i++ ) {
				if ( _scenes[i] == scene ) { return i; }
			}
			
			return -1;
		}
		
		/**
		 * <span lang="ja">シーンオブジェクトコンテナの既存の子の位置を変更します。</span>
		 * <span lang="en">Changes the position of an existing scene in the SceneObject container.</span>
		 * 
		 * @param scene
		 * <span lang="ja">インデックス番号を変更する子 SceneObject インスタンスです。</span>
		 * <span lang="en">The scene SceneObject instance for which you want to change the index number.</span>
		 * @param index
		 * <span lang="ja">child インスタンスの結果のインデックス番号です。</span>
		 * <span lang="en">The resulting index number for the scene SceneObject.</span>
		 */
		public function setSceneIndex( scene:SceneObject, index:int ):void {
			addSceneAt( removeScene( scene ), index );
		}
		
		/**
		 * <span lang="ja">シーンオブジェクトコンテナの既存の子の位置を変更します。</span>
		 * <span lang="en">Changes the position of an existing scene in the SceneObject container.</span>
		 * 
		 * @param scene
		 * <span lang="ja">インデックス番号を変更する子 SceneObject インスタンスです。</span>
		 * <span lang="en">The scene SceneObject instance for which you want to change the index number.</span>
		 * @param index
		 * <span lang="ja">child インスタンスの結果のインデックス番号です。</span>
		 * <span lang="en">The resulting index number for the scene SceneObject.</span>
		 */
		public function setSceneIndexAbove( scene:SceneObject, index:int ):void {
			addSceneAtAbove( removeScene( scene ), index );
		}
		
		/**
		 * <span lang="ja">指定された 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</span>
		 * <span lang="en">Swaps the z-order (front-to-back order) of the two specified scene objects.</span>
		 * 
		 * @param scene1
		 * <span lang="ja">先頭の子 SceneObject インスタンスです。</span>
		 * <span lang="en">The first scene object.</span>
		 * @param scene2
		 * <span lang="ja">2 番目の子 SceneObject インスタンスです。</span>
		 * <span lang="en">The second scene object.</span>
		 */
		public function swapScenes( scene1:SceneObject, scene2:SceneObject ):void {
			// インデックス位置を取得する
			var index1:int = getSceneIndex( scene1 );
			var index2:int = getSceneIndex( scene2 );
			
			// インデックスの数値によって入れ替える
			if ( index1 < index2 ) {
				var tmpScene:SceneObject = scene1;
				var tmpIndex:int = index1;
				scene1 = scene2;
				scene2 = tmpScene;
				index1 = index2;
				index2 = tmpIndex;
			}
			
			// シーンリストから削除する
			removeScene( scene1 );
			removeScene( scene2 );
			
			// シーンリストに追加する
			addSceneAt( scene1, index2 );
			addSceneAt( scene2, index1 );
		}
		
		/**
		 * <span lang="ja">子リスト内の指定されたインデックス位置に該当する 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</span>
		 * <span lang="en">Swaps the z-order (front-to-back order) of the scene objects at the two specified index positions in the scene list.</span>
		 * 
		 * @param index1
		 * <span lang="ja">最初の子 SceneObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the first scene object.</span>
		 * @param index2
		 * <span lang="ja">2 番目の子 SceneObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the second scene object.</span>
		 */
		public function swapScenesAt( index1:int, index2:int ):void {
			// シーンオブジェクトを取得する
			var scene1:SceneObject = getSceneAt( index1 );
			var scene2:SceneObject = getSceneAt( index2 );
			
			// インデックスの数値によって入れ替える
			if ( index1 < index2 ) {
				var tmpScene:SceneObject = scene1;
				var tmpIndex:int = index1;
				scene1 = scene2;
				scene2 = tmpScene;
				index1 = index2;
				index2 = tmpIndex;
			}
			
			// シーンリストから削除する
			removeScene( scene1 );
			removeScene( scene2 );
			
			// シーンリストに追加する
			addSceneAt( scene1, index2 );
			addSceneAt( scene2, index1 );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトの XML ストリング表現を返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトの XML ストリング表現です。</span>
		 * <span lang="en"></span>
		 */
		public function toXMLString():String {
			// クラスパスを取得する
			var cls:String = ClassUtil.getClassPath( this );
			cls;
			
			// シーンノードを作成する
			var xml:XML = <scene name={ name } cls={ cls } title={ title }>{ sceneInfo.data }</scene>;
			
			// 子シーンオブジェクトの配列を取得する
			var children:Array = scenes;
			
			// 子シーンノードを作成する
			var l:int = numScenes;
			for ( var i:int = 0; i < l; i++ ) {
				var scene:SceneObject = SceneObject( children[i] );
				xml.appendChild( new XML( scene.toXMLString() ) );
			}
			
			return xml.toXMLString();
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public override function toString():String {
			return '[' + _className + ' sceneId="' + sceneId + '" id="' + _id + '" name="' + _name + '" group="' + _group + '"]';
		}
		
		
		
		
		
		/**
		 * シーン移動時に目的地がシーンオブジェクト自身もしくは子階層だった場合に、階層が変更された瞬間に送出されます。
		 */
		private function _load( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onLoad();
		}
		
		/**
		 * シーン移動時に目的地がシーンオブジェクト自身もしくは親階層だった場合に、階層が変更された瞬間に送出されます。
		 */
		private function _unload( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onUnload();
		}
		
		/**
		 * シーンオブジェクトが目的地だった場合に、到達した瞬間に送出されます。
		 */
		private function _init( e:SceneEvent ):void {
			// 未読であれば
			if ( !_isVisited ) {
				// 既読にする
				_isVisited = true;
				
				// イベントを送出する
				dispatchEvent( new SceneEvent( SceneEvent.SCENE_STATE_CHANGE, false, false, this ) );
			}
			
			if ( _eventHandlerEnabled ) {
				// イベントハンドラメソッドを実行する
				onInit();
			}
		}
		
		/**
		 * シーンオブジェクトが出発地だった場合に、移動を開始した瞬間に送出されます。
		 */
		private function _goto( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onGoto();
		}
		
		/**
		 * シーン移動時に目的地がシーンオブジェクトの子階層であり、かつ出発地ではない場合に、移動を中継した瞬間に送出されます。
		 */
		private function _descend( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onDescend();
		}
		
		/**
		 * シーン移動時に目的地がシーンオブジェクトの親階層であり、かつ出発地ではない場合に、移動を中継した瞬間に送出されます。
		 */
		private function _ascend( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onAscend();
		}
		
		/**
		 * シーンオブジェクトがシーンリストに追加された場合に送出されます。
		 */
		private function _sceneAdded( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onSceneAdded();
		}
		
		/**
		 * シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの追加により、ルートシーン上のシーンリストに追加されたときに送出されます。
		 */
		private function _sceneAddedToRoot( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onSceneAddedToRoot();
		}
		
		/**
		 * シーンオブジェクトがシーンリストから削除された場合に送出されます。
		 */
		private function _sceneRemoved( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onSceneRemoved();
		}
		
		/**
		 * シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの削除により、ルートシーン上のシーンリストから削除されようとしているときに送出されます。
		 */
		private function _sceneRemovedFromRoot( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onSceneRemovedFromRoot();
		}
		
		/**
		 * シーンオブジェクトのタイトルが変更された場合に送出されます。
		 */
		private function _sceneTitle( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onSceneTitle();
		}
		
		/**
		 * シーンオブジェクトの状態が変更された場合に送出されます。
		 */
		private function _sceneStateChange( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			onSceneStateChange();
		}
		
		/**
		 * シーンオブジェクトの状態が変更された場合に送出されます。
		 */
		private function _processScene( e:ProcessEvent ):void {
			// 現在の設定を保存する
			var isCurrent:Boolean = _isCurrent;
			var isParent:Boolean = _isParent;
			var isChild:Boolean = _isChild;
			
			// カレントシーンに該当するかどうか
			_isCurrent = ( this == e.scene );
			
			// 親シーンに該当するかどうか
			_isParent = !( _isCurrent || e.scene.sceneId.contains( sceneId ) );
			
			// 子シーンに該当するかどうか
			_isChild = ( !_isCurrent && e.scene.sceneId.contains( sceneId ) );
			
			// 変化していなければ終了する
			if ( isCurrent == _isCurrent && isParent == _isParent && isChild == _isChild ) { return; }
			
			// イベントを送出する
			dispatchEvent( new SceneEvent( SceneEvent.SCENE_STATE_CHANGE, false, false, this, e.eventType ) );
		}
	}
}
