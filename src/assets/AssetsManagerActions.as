package assets
{
	import assets.commands.CommandLoadAsset;
	
	import org.br.behavior.actions.ActionGroup;
	
	import utils.AppConstants;
	
	CommandLoadAsset
	public class AssetsManagerActions extends ActionGroup
	{
		public function AssetsManagerActions(commands:Array = null, names:String = null)
		{
			
			if(!commands){
				commands = ['assets.commands.CommandLoadAsset'];
			};
			
			if(!names){
				names = AppConstants.ASSET_LOAD_ASSET;
			};
			
			super(commands, names);
		}
	}
}