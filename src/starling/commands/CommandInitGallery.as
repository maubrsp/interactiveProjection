package starling.commands
{
	import org.br.behavior.commands.Command;
	import org.br.behavior.controllers.Broadcaster;
	import org.br.behavior.core.Core;
	import org.br.behavior.events.EventAction;
	
	import utils.AppConstants;
	
	public class CommandInitGallery extends Command
	{
		public function CommandInitGallery()
		{
			super();
		}
		
		override public function execute(scope:Object):void
		{
			(shell as Object).start();
			sucess();
		}
		
	}
}