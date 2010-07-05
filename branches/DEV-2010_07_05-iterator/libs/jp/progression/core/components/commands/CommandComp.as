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
package jp.progression.core.components.commands {
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.components.CoreComp;
	
	/**
	 * @private
	 */
	public class CommandComp extends CoreComp {
		
		/**
		 * @private
		 */
		public function CommandComp() {
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CoreComp ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "CommandComp" ) ); }
		}
	}
}
