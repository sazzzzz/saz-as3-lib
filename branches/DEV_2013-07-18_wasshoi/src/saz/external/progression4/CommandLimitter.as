package saz.external.progression4
{
	import jp.progression.commands.*;
	import jp.progression.commands.lists.SerialList;
	import jp.progression.executors.ExecutorObjectState;

	/**
	 * 同時に実行するコマンドを1つに制限する。
	 * 後から実行開始したものが優先され、古いものは停止される。
	 * @author saz
	 * 
	 */
	public class CommandLimitter
	{
		
		protected var lastCommand:Command;
		
		public function CommandLimitter()
		{
		}
		
		public function createCommand(params:Object=null, autoDispose:Boolean=true):CommandList
		{
			return new SerialList(params
				,new Func(function():void
				{
					haltLastCommand(autoDispose);
				})
			);
		}
		
		public function destroy():void
		{
			haltLastCommand(true);
		}
		
		
		/*final protected function doInterruptExecuting(autoDispose:Boolean):Command
		{
			return new Func(function():void
			{
				haltLastCommand(autoDispose);
			});
		}*/
		
		protected function haltLastCommand(dispose:Boolean):void
		{
			if (lastCommand && lastCommand.state == ExecutorObjectState.EXECUTING)
			{
				// 停止
				lastCommand.interrupt(true);
				// 保持データを解放
				if (dispose) lastCommand.dispose();
			}
		}
		
	}
}