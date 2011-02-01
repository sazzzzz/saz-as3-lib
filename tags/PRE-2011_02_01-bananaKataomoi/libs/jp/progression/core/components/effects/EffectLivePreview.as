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
package jp.progression.core.components.effects {
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.components.CoreLivePreview;
	
	/**
	 * @private
	 */
	public class EffectLivePreview extends CoreLivePreview {
		
		/**
		 */
		private var _param:TextField;
		
		
		
		
		
		/**
		 * @private
		 */
		public function EffectLivePreview() {
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CoreLivePreview ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "EffectLivePreview" ) ); }
			
			// 参照を取得する
			_param = TextField( getChildByName( "param" ) );
			
			// イベントリスナーを登録する
			addEventListener( Event.CHANGE, _change );
		}
		
		
		
		
		
		/**
		 */
		private function _change( e:Event ):void {
			// 表示を更新する
			_param.text = parameters.direction + " / " + parameters.duration + " ms";
		}
	}
}
