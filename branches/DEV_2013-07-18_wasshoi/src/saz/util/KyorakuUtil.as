package saz.util
{
	import flash.net.*;
	import flash.utils.escapeMultiByte;

	public class KyorakuUtil
	{
		/**
		 * たぬ吉登録用のベースURL。※必ずフルパスで記述
		 */
		public static const LINK_TANUKICHI_REGIST_BASE:String = "https://www.kyoraku.co.jp/control/index.php";
		
		/**
		 * たぬ吉クラブ：登録情報ページのベースURL。
		 */
		public static const LINK_TANUKICHI_MEMBER_BASE:String = "https://www.kyoraku.co.jp/tanukichi_club/member.php";
		
		/**
		 * たぬ吉ログイン用URL。※必ずフルパスで記述
		 */
		public static const LINK_TANUKICHI_LOGIN_BASE:String = "https://www.kyoraku.co.jp/control/login.php";
		
		/**
		 * たぬ吉ログアウト用URL。
		 */
		public static const LINK_TANUKICHI_LOGOUT:String = "https://www.kyoraku.co.jp/s_clear.php";

		
		/**
		 * たぬ吉登録用のURLを返す。
		 * @param r_cd	ログ解析用のIDを指定。基本コンテンツごとに変更する。エピオンが発行する。
		 * @return 
		 * 
		 */
		public static function getUrlForTanukichiRegist(r_cd:String):String
		{
			return LINK_TANUKICHI_REGIST_BASE + "?R_CD=" + r_cd;
		}
		
		/**
		 * たぬ吉クラブ：登録情報ページのURLを返す。
		 * ex. https://www.kyoraku.co.jp/tanukichi_club/member.php?ref=
		 * @param refPath	ログイン後のコールバックURLを指定。スラッシュ始まりで。"/～"
		 * @return 
		 */
		public static function getUrlForTanukichiMember(refPath:String):String
		{
			return LINK_TANUKICHI_MEMBER_BASE + "?ref=" + escapeMultiByte(refPath);
		}
		
		/**
		 * たぬ吉ログイン用のURLを返す。
		 * ex. http://www.kyoraku.co.jp/control/login.php?ref=%2Findex.php
		 * @param refPath	ログイン後のコールバックURLを指定。スラッシュ始まりで。"/～"
		 * @return 
		 */
		public static function getTanuLoginUrl(refPath:String):String
		{
			return LINK_TANUKICHI_LOGIN_BASE + "?ref=" + escapeMultiByte(refPath);
		}

		
		
		
		/**
		 * たぬ吉登録ページヘリンク。
		 * @param r_cd	ログ解析用のIDを指定。基本コンテンツごとに変更する。エピオンが発行する。
		 * @param windowTarget
		 */
		public static function linkToTanukichiRegist(r_cd:String, windowTarget:String = "_self"):void
		{
			navigateToURL(new URLRequest(getUrlForTanukichiRegist(r_cd)), windowTarget);
		}

		
		
		
	}
}