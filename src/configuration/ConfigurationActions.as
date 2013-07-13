package configuration
{
	import configuration.commads.CommandLoadConfiguration;
	
	import org.br.behavior.actions.ActionGroup;
	
	import utils.AppConstants;
	
	CommandLoadConfiguration;
	
	public class ConfigurationActions extends ActionGroup
	{
		public function ConfigurationActions(commands:Array = null, names:String = null)
		{
			if(!commands){
				commands = ["configuration.commads.CommandLoadConfiguration"];
			};
			
			if(!names){
				names = AppConstants.GET_CONFIGURATION;
			};
			
			super(commands, names);
		}
	}
}