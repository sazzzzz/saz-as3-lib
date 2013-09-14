package saz.observ
{
	/**
	 * オブジェクトをウォッチするインターフェース。
	 * @author saz
	 * 
	 */
	public interface IObjectWatcher
	{
		function ready():void;
		function check():Boolean;
	}
}