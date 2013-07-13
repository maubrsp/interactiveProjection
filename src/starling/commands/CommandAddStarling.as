package starling.commands
{
	import org.br.behavior.commands.Command;
	
	import starling.ViewController;
	import starling.core.Starling;
	
	public class CommandAddStarling extends Command
	{
		
		public function CommandAddStarling()
		{
			super();
		}
		
		override public function execute(scope:Object):void
		{
			super.execute(scope);
			shell.view = data;
			sucess();
		}
		
		
		
	}
}