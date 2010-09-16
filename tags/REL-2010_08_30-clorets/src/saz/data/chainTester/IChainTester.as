package saz.data.chainTester {
	
	/**
	 * ChainTesterインターフェース。
	 * @author saz
	 * @see	http://www.techscore.com/tech/DesignPattern/ChainOfResponsibility.html
	 * @see	http://ja.wikipedia.org/wiki/Chain_of_Responsibility_%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3
	 */
	public interface IChainTester {
		
		function setNext(tester:IChainTester):IChainTester;
		function test(msg:String):void;
		function canResponse(msg:String):Boolean;
		
		//function response(msg:String):void;
		function get response():Function;
		function set response(value:Function):void;
		
	}
	
}