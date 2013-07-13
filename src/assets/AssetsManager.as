package assets
{
	import flash.display.Bitmap;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import org.br.behavior.core.Shell;
	import org.br.behavior.patterns.interfaces.IActionGroup;
	import org.br.behavior.patterns.interfaces.IModel;
	
	import starling.textures.Texture;
	
	import utils.AppConstants;
	
	/**
	 * 
	 * @author maurício césar
	 */
	public class AssetsManager extends Shell
	{
		
		/**
		 *  
		 */
		public var dictionaryAssets:Dictionary = new Dictionary(true);
		
		/**
		 * Class Constructor
		 */
		public function AssetsManager(actions:IActionGroup = null, data:IModel = null)
		{
			if(!actions){
				actions = new AssetsManagerActions();
			}
			
			super(actions, data);
			createAssetsBaseFolder();
		}
		
		/**
		 * @private 
		 */
		private function createAssetsBaseFolder():void
		{
			var directory:File = new File(File.documentsDirectory.resolvePath(AppConstants.assetsFolder).url);
			if(!directory.exists){
				directory.createDirectory();
			}
		}
		
		/**
		 * 
		 * @param assetName
		 * @return 
		 */
		public function getTexture(assetName:String):Texture{
			if( dictionaryAssets[assetName] == undefined ){
				throw new Error("Asset não carregado, verifique a sua existência no xml de configuraçao - source=" + assetName);
			}
			var result:Texture;
			
			if (dictionaryAssets[assetName] is Bitmap)
				result = Texture.fromBitmap(dictionaryAssets[assetName] as Bitmap);
			else if (dictionaryAssets[assetName] is ByteArray)
				result = Texture.fromAtfData(dictionaryAssets[assetName] as ByteArray );
			
			return result
		}
		
		public function getVideo():void{
			
			
			
		}
		
		public function getText():void{
			
			
			
		}
		
	}
}