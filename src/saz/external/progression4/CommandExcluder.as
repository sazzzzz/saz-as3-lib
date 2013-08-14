package saz.external.progression4
{
	import jp.progression.commands.*;
	import jp.progression.commands.lists.SerialList;
	import jp.progression.executors.ExecutorObjectState;
	
	import saz.util.ObjectUtil;

	/**
	 * 同時に実行するコマンドを1つに制限する。
	 * 後から実行開始したものが優先され、古いものは停止される。
	 * @author saz
	 * 
	 */
	public class CommandExcluder
	{
		
		protected var lastExecutedCommand:CommandList;
		protected var lastDefinedCommand:CommandList;
		
		public function CommandExcluder()
		{
		}
		
		
		//--------------------------------------
		// public
		//--------------------------------------
		
		
		/**
		 * 新しいCommandListをつくる。
		 * @param params
		 * @param autoDispose	（実験的）コマンドを自動でdispose()する。
		 * @return 
		 * 
		 */
		public function createCommand(params:Object=null, autoDispose:Boolean=true):CommandList
		{
			var opt:Object = {};
			ObjectUtil.setProperties(opt, params);
			
			lastDefinedCommand = new SerialList(opt
				,new Func(function():void
				{
					interruptCommand(lastExecutedCommand);
					if (autoDispose) disposeCommand(lastExecutedCommand);
					
					lastExecutedCommand = CommandList(this.parent);
				})
			);
			return lastDefinedCommand;
		}
		
		/**
		 * 停止。
		 * 
		 */
		public function interrupt():void
		{
			interruptCommand(lastExecutedCommand);
		}
		
		
		/**
		 * デストラクタ。
		 * 
		 */
		public function destroy():void
		{
			interruptCommand(lastExecutedCommand);
			disposeCommand(lastExecutedCommand);
			lastExecutedCommand = null;
			
			interruptCommand(lastDefinedCommand);
			disposeCommand(lastDefinedCommand);
			lastDefinedCommand = null;
		}
		
		
		//--------------------------------------
		// protected
		//--------------------------------------
		
		
		protected function interruptCommand(command:CommandList):void
		{
			if (command && command.state == ExecutorObjectState.EXECUTING)
			{
				command.interrupt(false);
			}
		}
		
		protected function disposeCommand(command:CommandList):void
		{
			if (command) command.dispose();
		}
		
	}
}