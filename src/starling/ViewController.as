package starling
{
	import assets.AssetsManager;
	
	import com.br.mau.air.window.NativeWindowConfig;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import knect.KinectController;
	
	import org.br.behavior.controllers.Broadcaster;
	import org.br.behavior.core.Core;
	import org.br.behavior.core.Shell;
	import org.br.behavior.events.EventAction;
	import org.br.behavior.patterns.interfaces.IActionGroup;
	import org.br.behavior.patterns.interfaces.IModel;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	import utils.AppConstants;
	
	public class ViewController extends Shell
	{
		
		public var starlingInstance:Starling;
		public var root:flash.display.Sprite;
		private var defaultImagesArray:String
		
		
		public function ViewController( rootScope:DisplayObject , actions:IActionGroup = null, data:IModel = null)
		{
			if(!actions){
				actions = new ViewControllerActions();
			}
			
			super(actions, data);
			
			create(rootScope );
		}
		
		private function create(rootStage:DisplayObject):void{
			
			root = rootStage as flash.display.Sprite;
			
			rootStage.stage.scaleMode = StageScaleMode.NO_SCALE;
			rootStage.stage.align = StageAlign.TOP_LEFT;
			
			Starling.multitouchEnabled = false; // useful on mobile devices
			Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
			
			starlingInstance = new Starling(ViewStarling, rootStage.stage);
			starlingInstance.simulateMultitouch = false;
			starlingInstance.enableErrorChecking = false;
			starlingInstance.start();
			
			starlingInstance.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			
		}
		
		private function onContextCreated(event:Event):void
		{
			if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1){
				Starling.current.nativeStage.frameRate = 30;
			}
		}
		
		public function start():void{
			//direciona window para monitor definido e maximiza;
			NativeWindowConfig.maximazeInScreen(root , uint(xmlConfig..video.display) );
			starlingInstance.viewPort = new Rectangle(0,0,
				NativeWindowConfig.getInScreen(uint(xmlConfig..video.display) , NativeWindowConfig.WIDTH ),
				NativeWindowConfig.getInScreen(uint(xmlConfig..video.display) , NativeWindowConfig.HEIGHT ));
			
			Starling.current.stage.stageWidth = NativeWindowConfig.getInScreen(uint(xmlConfig..video.display) , NativeWindowConfig.WIDTH );
			Starling.current.stage.stageHeight = NativeWindowConfig.getInScreen(uint(xmlConfig..video.display) , NativeWindowConfig.HEIGHT );
			
			defaultImagesArray = "";
			
			
			for each (var o:Object in xmlConfig..promotions.assetDefault) 
			{
				defaultImagesArray += defaultImagesArray.length == 0 ? o : "," + o ;
			}
			
			assetsLoadImages( defaultImagesArray , onLogoLoaded );
			
		}
		
		private function onLogoLoaded(data:Object):void{
			for each (var o:Object in xmlConfig..promotions.assetDefault) 
			{
				starlingRootClass.addDefaultAsset( o.toString() , getAssetTextureManager(o.toString()) , 5 , 5 );
			}
			started();
		}
		
		private function started():void{
			
			( Core.getInstance().getShell(AppConstants.SHELL_KINECT) as KinectController ).initKinect(view as starling.display.Sprite)
			
		}
		
		public function updtadeUserMask(bitmapData:BitmapData):void{
			//trace(bitmapData);
			if(bitmapData)starlingRootClass.updateUserMask(Texture.fromBitmapData(bitmapData));
			
			
		}
		
		//---------------------------SHORTCUTS
		
		private function assetsLoadImages(imagesData:String , sucessFunction:Function):void{
			
			Broadcaster.getInstance().dispatchEvent(
				new EventAction(
					EventAction.EXECUTE_ACTION , 
					AppConstants.ASSET_LOAD_ASSET , 
					this ,
					null,
					null ,		
					imagesData ,
					sucessFunction )
			);
			
		}
		
		private function get xmlConfig():XML{
			return ( Core.getInstance().getShell(AppConstants.SHELL_CONFIG) as Object).xmlConfig;
		}
		
		private function getAssetTextureManager(textureName:String):Texture{
			return ( Core.getInstance().getShell(AppConstants.SHELL_ASSETS_MANAGER) as AssetsManager).getTexture(textureName);
		}
		
		private function get starlingRootClass():ViewStarling{
			return view as ViewStarling;
		}
	}
}