package configuration
{
	import org.br.behavior.core.Shell;
	import org.br.behavior.patterns.interfaces.IActionGroup;
	import org.br.behavior.patterns.interfaces.IModel;
	
	public class Config extends Shell
	{
		
		public var xmlConfig:XML;
		
		public function Config(actions:IActionGroup = null, data:IModel = null)
		{
			
			if(!actions){
				actions = new ConfigurationActions();
			}
						
			super(actions, data);
		}
		
	}
}