package starling
{
	import org.br.behavior.actions.ActionGroup;
	
	import starling.commands.CommandAddIten;
	import starling.commands.CommandAddStarling;
	import starling.commands.CommandInitGallery;
	import starling.commands.CommandRemoveIten;
	
	import utils.AppConstants;
	
	CommandAddIten;
	CommandRemoveIten;
	CommandAddStarling;
	CommandInitGallery
	public class ViewControllerActions extends ActionGroup
	{
		
		public function ViewControllerActions(commands:Array=null, names:String=null)
		{
			if(!commands){
				commands = ['starling.commands.CommandAddIten',
					'starling.commands.CommandRemoveIten',
					'starling.commands.CommandInitGallery',
					'starling.commands.CommandAddStarling'];
			};
			
			if(!names){
				names = AppConstants.VIEW_ADD_ITEN + "," + 
					AppConstants.VIEW_REMOVE_ITEN + "," + 
					AppConstants.VIEW_INIT_GALLERY + "," + 
					AppConstants.VIEW_ADD_STARLING_PROGRAM;
			};
			
			super(commands, names);
		}
		
	}
}