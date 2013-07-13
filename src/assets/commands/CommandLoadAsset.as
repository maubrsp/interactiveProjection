package assets.commands
{
	import assets.AssetsManager;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	import org.br.behavior.commands.Command;
	import org.br.behavior.core.Core;
	
	import utils.AppConstants;
	
	public class CommandLoadAsset extends Command
	{
		
		private var xmlData:XML;
		private var vectorAssets:Vector.<Object>;
		private var countLoadProcess:uint = 0;
		
		public function CommandLoadAsset()
		{
			super();
		}
		
		override public function execute(scope:Object):void
		{
			vectorAssets = new Vector.<Object>();
			for each (var o:Object in String(data).split(","))
			{
				vectorAssets.push(o);
				countLoadProcess++;
			}
			loadAsset();
		}
		
		private function loadAsset():void{
			if(countLoadProcess ==0){
				sucess();
				return;
			}
			var file:File = File.documentsDirectory.resolvePath( String(AppConstants.assetsFolder + vectorAssets[countLoadProcess-1]) );
			var lc:Loader = new Loader();
			lc.contentLoaderInfo.addEventListener(Event.COMPLETE, function():void{
				(shell as AssetsManager).dictionaryAssets[String(vectorAssets[countLoadProcess-1])] = lc.content;
				countLoadProcess--;
				loadAsset();
			});
			lc.load(new URLRequest(file.url));
		}
		
	}
}