package starling
{
	import core.commands.CommandInitializeSequence;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import org.br.behavior.controllers.Broadcaster;
	import org.br.behavior.core.Core;
	import org.br.behavior.events.EventAction;
	import org.br.behavior.patterns.interfaces.ICommand;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	import utils.AppConstants;
	
	public class ViewStarling extends Sprite
	{
		public function ViewStarling()
		{
			super();
			init();
		}
		
		private var dictionaryViews:Dictionary = new Dictionary(true);
		private var dictionaryContents:Dictionary = new Dictionary(true);
		private var dictionaryData:Dictionary = new Dictionary(true);
		private var viewCounter:uint=0;
		
		private var defaultItens:Sprite;
		
		private var userMask:Image;
		
		private var counterDefaultItens:uint = 0;
		
		private function init():void{
			Broadcaster.getInstance().dispatchEvent(
				new EventAction(
					EventAction.EXECUTE_ACTION , 
					AppConstants.VIEW_ADD_STARLING_PROGRAM ,  
					null ,
					null ,		
					null,
					this,
					viewStarling_AddedToController )
			);
			
		}
		
		private function viewStarling_AddedToController():void{
			
			var command:ICommand = new CommandInitializeSequence();
			command.execute(this);
			
		}
		
		public function addDefaultAsset(pName:String , logo:Texture , posX:uint , posY:uint):void{
			if(!defaultItens){
				defaultItens = new Sprite()
				addChild(defaultItens);
			}
			trace(logo , pName , "<<<<<");
			var img:Image = new Image(logo);
			img.name = pName;
			defaultItens.addChild(img);
			img.x = posX;
			img.y = posY;
			
			defaultItens.clipRect = new Rectangle(50,50,150,150)
			
			counterDefaultItens++;
		}
		
		public function updateUserMask(image:Texture):void{
			if(!image)return;
			if(!userMask){
				userMask = new Image(image);
				userMask.smoothing = TextureSmoothing.BILINEAR;
				userMask.scaleX = 1.5;
				userMask.scaleY = 1.5;
				userMask.readjustSize();
				addChild(userMask);
				userMask.x = 20;
				userMask.y = 20;
			}else{
				userMask.texture.dispose();
				userMask.texture = image;
				userMask.smoothing = TextureSmoothing.BILINEAR;
			}
			
		}
		
		public function showInteracions():void{
			//TODO mostra opções de interação
			
			
		}
		
		public function showInAction():void{
			//TODO minimiza user e libera interação
			
			
		}
		
		public function userAcept():void{
			//diminui usuário
			
		}

		public function userUpdate():void{
			//atualiza tela com posições e efeitos
			
			
		}
		
		public function removeUser():void{
			
			
		}
		
		
		private function clearView():void{
			
			
			
		}
		
		private function createGraphic(data:Object):Image{
			
			
			
			//var result:Image = new Image( Texture.fromAtfData(file.data) );
			
			return null;
		}
		
		private function createMedia():void{
			
		}
				
	}
}