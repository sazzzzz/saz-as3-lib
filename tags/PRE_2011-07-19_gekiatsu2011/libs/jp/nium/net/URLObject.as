﻿/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.net {
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	import jp.nium.net.Query;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.StringUtil;
	
	/**
	 * <span lang="ja">URLObject クラスは、URL を表すモデルクラスです。</span>
	 * <span lang="en">URLObject class is a model class which express the URL.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class URLObject {
		
		/**
		 * URL のフォーマットを判別する正規表現を取得します。
		 */
		private static const _VALIDATE_REGEXP:RegExp = function():RegExp {
			var lowalpha:String = "a-z";
			var upalpha:String = "A-Z";
			var digit:String = "0-9";
			
			var alpha:String = lowalpha + upalpha;
			var alphanum:String = alpha + digit;
			
			var mark:String = "-_.!~*'()";
			var reserved:String = ";/?:@&=+$,";
			var unreserved:String = alphanum + mark;
			var hex:String = "0-9A-Fa-f";
			var escaped:String = "%[" + hex + "][" + hex + "]";
			var uric:String = "([" + reserved + unreserved + "]|" + escaped + ")";
			var pchar:String = "([" + unreserved + ":@&=+$,]|" + escaped + ")";
			
			var userinfo:String = "([" + unreserved + ";:&=+$,]|" + escaped + ")";
			var domainlabel:String = "([" + alphanum + "]|[" + alphanum + "][" + alphanum + "-][" + alphanum + "])";
			var toplabel:String = "([" + alpha + "]|[" + alpha + "][" + alphanum + "-][" + alphanum + "])";
			var hostname:String = "(" + domainlabel + ".)*" + toplabel + "\\.?";
			var IPv4address:String = "[" + digit + "]+\\.[" + digit + "]+\\.[" + digit + "]+\\.[" + digit + "]+";
			var host:String = "(" + hostname + "|" + IPv4address + ")";
			var port:String = "[" + digit + "]*";
			var hostport:String = host + "(:" + port + ")?";
			var server:String = "((" + userinfo + "@)?" + hostport + ")?";
			
			var param:String = pchar + "*";
			var segment:String = pchar + "*(;" + param + ")*";
			var path_segments:String = segment + "(/" + segment + ")*";
			
			var abs_path:String = "/" + path_segments;
			
			var uric_no_slash:String = "([" + unreserved + ";?:@&=+$,]|" + escaped + ")";
			var opaque_part:String = uric_no_slash + uric + "*";
			
			var scheme:String = "[" + alpha + "][" + alpha + digit + "+-.]*";
			var authority:String = server;
			var path:String = "(" + abs_path + "|" + opaque_part + ")?";
			var query:String = uric + "*";
			var fragment:String = uric + "*";
			
			return new RegExp( "^" + scheme + ":///?" + authority + path + "(\\?" + query + ")?(#" + fragment + ")?" );
		}.apply();
		
		/**
		 * URL を判別する正規表現を取得します。
		 */
		private static const _URL_REGEXP:RegExp = new RegExp( "^(([^:/?#]+):)?(///?([^/?#]*))?([^?#]*)(\\?([^#]*))?(#(.*))?$" );
		
		/**
		 * 権限を判別する正規表現を取得します。
		 */
		private static const _AUTHORITY_REGEXP:RegExp = new RegExp( "^((([^@:.]+):([^@:.]+)@)|.*@)?([^:]+)(:(.+))?$" );
		
		/**
		 * セグメントを判別する正規表現を取得します。
		 */
		private static const _SEGMENTS_REGEXP:RegExp = new RegExp( "^((/[^/.]+)*)(/(([^/]+)\\.([^/.]+))?)?$" );
		
		/**
		 * スキームを判別する正規表現を取得します。
		 */
		private static const _SCHEME_REGEXP:RegExp = new RegExp( "^[a-z][a-z0-9+-.]*$", "i" );
		
		/**
		 * ユーザー情報を判別する正規表現を取得します。
		 */
		private static const _USER_REGEXP:RegExp = new RegExp( "^([a-z0-9-_.!~*'();&=+$,]|%[0-9a-f][0-9a-f])*$", "i" );
		
		/**
		 * パスワードを判別する正規表現を取得します。
		 */
		private static const _PASSWORD_REGEXP:RegExp = new RegExp( "^([a-z0-9-_.!~*'();&=+$,]|%[0-9a-f][0-9a-f])*$", "i" );
		
		/**
		 * ホスト名を判別する正規表現を取得します。
		 */
		private static const _HOST_REGEXP:RegExp = new RegExp( "^([a-z0-9-_.!~*'();&=+$,]|%[0-9a-f][0-9a-f])*$", "i" );
		
		/**
		 * ポート番号を判別する正規表現を取得します。
		 */
		private static const _PORT_REGEXP:RegExp = new RegExp( "^[0-9]+$" );
		
		/**
		 * パスを判別する正規表現を取得します。
		 */
		private static const _PATH_REGEXP:RegExp = new RegExp( "^([a-z0-9-_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(/([a-z0-9-_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*$", "i" );
		
		/**
		 * ファイル名を判別する正規表現を取得します。
		 */
		private static const _FILENAME_REGEXP:RegExp = new RegExp( "^([a-z0-9-_.!~'()@&=+$,]|%[0-9a-f][0-9a-f])*$", "i" );
		
		/**
		 * ファイル拡張子名を判別する正規表現を取得します。
		 */
		private static const _FILEEXTENSION_REGEXP:RegExp = new RegExp( "^[a-z0-9]*$", "i" );
		
		/**
		 * フラグメントを判別する正規表現を取得します。
		 */
		private static const _FRAGMENT_REGEXP:RegExp = new RegExp( "^([a-z0-9-_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*$", "i" );
		
		
		
		
		
		/**
		 * <span lang="ja">URL をストリング表現で取得または設定します。</span>
		 * <span lang="en">Get or set the URL by string expression.</span>
		 */
		public function get url():String {
			var url:String = scheme + "://";
			
			// ユーザー情報を追加する
			var userinfo:String = user + ":" + password + "@";
			if ( new RegExp( "^(.+):(.+)@$" ).test( userinfo ) ) {
				url += userinfo;
			}
			
			// ホストを追加する
			url += host;
			
			// ポートを追加する
			if ( port ) {
				url += ":" + port;
			}
			
			// パスを追加する
			url += path;
			
			// ファイルを追加する
			var file:String = fileName + "." + fileExtension;
			if ( new RegExp( "^(.+)\\.(.+)$" ).test( file ) ) {
				url += "/" + file;
			}
			
			// クエリーを追加する
			var queryString:String = ObjectUtil.toQueryString( query );
			if ( queryString ) {
				url += "?" + queryString;
			}
			
			// フラグメントを追加する
			if ( fragment ) {
				url += "#" + fragment;
			}
			
			return url;
		}
		public function set url( value:String ):void {
			value = encodeURI( value || "" );
			
			if ( !validate( value ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			var url:Array = _URL_REGEXP.exec( value ) || [];
			var authority:Array = _AUTHORITY_REGEXP.exec( url[4] ) || [];
			var segments:Array = _SEGMENTS_REGEXP.exec( url[5] ) || [];
			
			scheme = url[2];
			
			user = authority[3];
			password = authority[4];
			host = authority[5];
			port = authority[7];
			
			path = segments[1];
			fileName = segments[5];
			fileExtension = segments[6];
			
			_query.completelyRemoveEventListener( Event.CHANGE, _change );
			_query = new Query( false, StringUtil.queryToObject( url[7] ) );
			_query.addExclusivelyEventListener( Event.CHANGE, _change, false, int.MAX_VALUE, true );
			
			fragment = url[9];
		}
		
		/**
		 * <span lang="ja">スキーマをストリング表現で取得または設定します。</span>
		 * <span lang="en">Get or set the scheme by string expression.</span>
		 */
		public function get scheme():String { return _scheme || ""; }
		public function set scheme( value:String ):void {
			value = encodeURI( value || "" );
			
			if ( value && !_SCHEME_REGEXP.test( value ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			_scheme = value;
		}
		private var _scheme:String;
		
		/**
		 * <span lang="ja">ユーザーをストリング表現で取得または設定します。</span>
		 * <span lang="en">Get or set the user by string expression.</span>
		 */
		public function get user():String { return _user || ""; }
		public function set user( value:String ):void {
			value = encodeURI( value || "" );
			
			if ( value && !_USER_REGEXP.test( value ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			_user = value;
		}
		private var _user:String;
		
		/**
		 * <span lang="ja">パスワードをストリング表現で取得または設定します。</span>
		 * <span lang="en">Get or set the password by string expresson.</span>
		 */
		public function get password():String { return _password || ""; }
		public function set password( value:String ):void {
			value = encodeURI( value || "" );
			
			if ( value && !_PASSWORD_REGEXP.test( value ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			_password = value;
		}
		private var _password:String;
		
		/**
		 * <span lang="ja">ホストをストリング表現で取得または設定します。</span>
		 * <span lang="en">Get or set the host by string expresson.</span>
		 */
		public function get host():String { return _host || ""; }
		public function set host( value:String ):void {
			value = encodeURI( value || "" );
			
			if ( value && !_HOST_REGEXP.test( value ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			_host = value;
		}
		private var _host:String;
		
		/**
		 * <span lang="ja">ポートをストリング表現で取得または設定します。</span>
		 * <span lang="en">Get or set the port by string expresson.</span>
		 */
		public function get port():String { return _port || ""; }
		public function set port( value:String ):void {
			value = encodeURI( value || "" );
			
			if ( value && !_PORT_REGEXP.test( value ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			_port = value;
		}
		private var _port:String;
		
		/**
		 * <span lang="ja">パスをストリング表現で取得または設定します。</span>
		 * <span lang="en">Get or set the path by string expresson.</span>
		 */
		public function get path():String { return _path || ""; }
		public function set path( value:String ):void {
			value = encodeURI( value || "" );
			
			if ( value && !_PATH_REGEXP.test( value ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			_path = value;
		}
		private var _path:String;
		
		/**
		 * <span lang="ja">ファイル名をストリング表現で取得します。</span>
		 * <span lang="en">Get or set the filename by string expresson.</span>
		 */
		public function get fileName():String { return _fileName || ""; }
		public function set fileName( value:String ):void {
			value = encodeURI( value || "" );
			
			if ( value && !_FILENAME_REGEXP.test( value ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			_fileName = value;
		}
		private var _fileName:String;
		
		/**
		 * <span lang="ja">ファイル拡張子をストリング表現で取得します。</span>
		 * <span lang="en">Get or set the file extension by string expresson.</span>
		 */
		public function get fileExtension():String { return _fileExtension || ""; }
		public function set fileExtension( value:String ):void {
			value = encodeURI( value || "" );
			
			if ( value && !_FILEEXTENSION_REGEXP.test( value ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			_fileExtension = value;
		}
		private var _fileExtension:String;
		
		/**
		 * <span lang="ja">クエリを Object 表現で取得します。</span>
		 * <span lang="en">Get the query by object expresson.</span>
		 */
		public function get query():Query { return _query; }
		private var _query:Query = new Query();
		
		/**
		 * <span lang="ja">フラグメントをストリング表現で取得または設定します。</span>
		 * <span lang="en">Get or set the fragment by string expresson.</span>
		 */
		public function get fragment():String { return _fragment || ""; }
		public function set fragment( value:String ):void {
			value = encodeURI( value || "" );
			
			if ( value && !_FRAGMENT_REGEXP.test( value ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			_fragment = value;
		}
		private var _fragment:String;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい URLObject インスタンスを作成します。</span>
		 * <span lang="en">Creates a new URLObject object.</span>
		 * 
		 * @param url
		 * <span lang="ja">URL を表すストリングです。</span>
		 * <span lang="en">The string express the URL.</span>
		 */
		public function URLObject( url:String ) {
			// イベントリスナーを登録する
			_query.addExclusivelyEventListener( Event.CHANGE, _change, false, int.MAX_VALUE, true );
			
			// 引数を設定する
			this.url = url;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">URL の書式が正しいかどうかを返します。</span>
		 * <span lang="en">Returns if the format of the URL is correct.</span>
		 * 
		 * @param url
		 * <span lang="ja">書式を調べる URL です。</span>
		 * <span lang="en">The URL to check the format.</span>
		 * @return
		 * <span lang="ja">書式が正しければ true に、それ以外の場合は false になります。</span>
		 * <span lang="en">Return true if the format is correct, otherwise return false.</span>
		 */
		public static function validate( url:String ):Boolean {
			return _VALIDATE_REGEXP.test( url );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">Flash Player のコンテナを含むアプリケーション（通常はブラウザ）でウィンドウを開くか、置き換えます。</span>
		 * <span lang="en">Open or replace the window with the application which contain the Flash Player contener (usually it is browser).</span>
		 * 
		 * @param windowTarget
		 * <span lang="ja">ドキュメントを表示するブラウザウィンドウまたは HTML フレームです。</span>
		 * <span lang="en">The browser window or HTML frame to display the document.</span>
		 */
		public function navigateTo( windowTarget:String = null ):void {
			navigateToURL( new URLRequest( url ), windowTarget || "_self" );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトの URLRequest 表現を返します。</span>
		 * <span lang="en">Returns the URLRequest representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトの URLRequest 表現です。</span>
		 * <span lang="en">A URLRequest representation of the object.</span>
		 */
		public function toURLRequest():URLRequest {
			return new URLRequest( url );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public function toString():String {
			return url;
		}
		
		
		
		
		
		/**
		 * クエリの値が変更された瞬間に送出されます。
		 */
		private function _change( e:Event ):void {
			// 更新する
			scheme = scheme;
		}
	}
}
