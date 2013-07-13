package knect
{
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.constants.CameraResolution;
	import com.as3nui.nativeExtensions.air.kinect.data.Position;
	import com.as3nui.nativeExtensions.air.kinect.data.SkeletonJoint;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.CameraImageEvent;
	import com.as3nui.nativeExtensions.air.kinect.events.DeviceEvent;
	import com.as3nui.nativeExtensions.air.kinect.events.UserEvent;
	
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import org.br.behavior.core.Core;
	import org.br.behavior.core.Shell;
	import org.br.behavior.patterns.interfaces.IActionGroup;
	import org.br.behavior.patterns.interfaces.IModel;
	
	import starling.ViewController;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.AppConstants;
	
	//TODO adiconar user Mask boolean (aciona userMask no true);
	
	public class KinectController extends Shell
	{
		
		private var device:Kinect;
		private var root:Sprite;
		
		private var currentUser:User;
		
		
		private var lastUserPosition:Position;
		
		private var handLeft:SkeletonJoint;
		private var handLeftLastPosition:Point= new Point();;
		
		private var handRight:SkeletonJoint;
		private var handRightLastPosition:Point= new Point();;
		
		private var calculeHand:Boolean;
		
		private var currentHand:SkeletonJoint;
		private var currentHandVelocity:Number;
		private var currentHandLastPosition:Point= new Point();
		
		private var zoomArea:Number = 0;
		private var zoomVelocity:Number = 0;
		/*
		private static var INTERRACTION_STATE_USER_DETECTED:String = "userDetected";
		private static var INTERRACTION_STATE_USER_POSITIONED:String = "userPositioned";
		private static var INTERRACTION_STATE_USER_IN_PREPARATION:String = "userInPreparation";
		private static var INTERRACTION_STATE_IMAGES_MOVING:String = "imagesMoving";
		private static var INTERRACTION_STATE_IMAGES_CHANGING:String = "imagesChanging";
		*/
		public function KinectController(actions:IActionGroup = null, data:IModel=null, pView:Object=null, pAutoCreateView:Boolean=false)
		{
			if(!actions){
				actions = new KinectControllerActions();
			}
			
			super(actions, data);
		}
		
		public function initKinect(pScope:Sprite=null):void{
			
			if(!root)root = pScope;
			
			if(Kinect.isSupported()){
				
				device = Kinect.getDevice();
				
					
				var settings:KinectSettings = new KinectSettings();
				settings.rgbEnabled = true;
				settings.rgbResolution = CameraResolution.RESOLUTION_640_480;
				settings.depthEnabled = true;
				
				settings.nearModeEnabled = true;
				
				settings.depthResolution = CameraResolution.RESOLUTION_320_240;
				settings.depthShowUserColors = true;
				settings.skeletonEnabled = true;
				settings.userEnabled = true;
				settings.userMaskEnabled = true;
				
				device.start(settings);
				device.addEventListener(DeviceEvent.STARTED, device_startedHandle);
				
			}else{
				trace("não temos kinc");
				setTimeout(initKinect , 5000 );
			}
				
		}
		
		private function device_startedHandle(event:DeviceEvent):void
		{
			//TODO mostra icone de kinect na tela;
			device.removeEventListener(DeviceEvent.STARTED, device_startedHandle);
			//device.addEventListener(UserEvent.USERS_ADDED, device_usersAddedHandle )
			//device.addEventListener(UserEvent.USERS_REMOVED, device_usersRemoveHandle )
			root.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		
		//handShake
		//change
		//move
		//zoom
		
		protected function enterFrameHandler(event:Event):void
		{
			trace(currentUser , device.users.length);
			if(currentUser && device.users.length >0){
				trace(currentUser.userID)
				
				if(!validateUserToInteraction(currentUser)){
					//trace("removing currentUser  -  " , currentUser.userID);
					removeCurrentUser();
					return;
				}
				
				//trace("hasuser")
				
				viewController.updtadeUserMask(currentUser.userMaskData);
				
				//todo - limite área de interação dinamico
				if( currentUser.torso.position.world.x <  130 && currentUser.torso.position.world.x > -130){
					//trace("posição de interação");
					calculeHand = true;
				}else{
					calculeHand = false;
				}
				
				if(!calculeHand){
					handLeft = null;
					handRight = null;
					return;
				}
				
				//computa interaçao das mãos
				if(currentUser.leftHand.position.world.y > currentUser.leftHip.position.world.y + (currentUser.leftShoulder.position.world.y - currentUser.leftHip.position.world.y)*.12){
					handLeft = currentUser.leftHand
				}else{
					handLeft = null;
				}
				
				if(currentUser.rightHand.position.world.y > currentUser.rightHip.position.world.y + (currentUser.rightShoulder.position.world.y - currentUser.rightHip.position.world.y)*.12){
					handRight = currentUser.rightHand;
				}else{
					handRight = null;
				}
				
				//calcula velocidades
				// calcula interações
				
				if(handLeft && handRight){
					
					//trace("handRight" , handLeft.position.world.x , "  -  handLeft" , handRight.position.world.x )
					
					zoomArea = ((handRight.position.world.x-handLeft.position.world.x)*( (handRight.position.world.y > handLeft.position.world.y) ? (handRight.position.world.y - handLeft.position.world.y) : (handLeft.position.world.y - handRight.position.world.y)  ))*.01;
					zoomVelocity = zoomArea - (((handRightLastPosition.x-handLeftLastPosition.x)*( (handRightLastPosition.y > handLeftLastPosition.y) ? (handRightLastPosition.y - handLeftLastPosition.y) : (handLeftLastPosition.y - handRightLastPosition.y)  ))*.01)
					//trace("area : " , zoomArea ,  "    -     velocity : " , zoomVelocity);
					handLeftLastPosition = new Point(handLeft.position.world.x , handLeft.position.world.y);
					handRightLastPosition = new Point(handRight.position.world.x , handRight.position.world.y);
					
					
				}else if(handLeft || handRight){
					
					if(handLeft){
						currentHand = handLeft;
					}else if(handRight){
						currentHand = handRight;
					}else{
						//trace("erroKKKKKKKKKKKKKKKKKKK");
					}
					
					currentHandVelocity = ( ( currentHand.position.world.x - currentHandLastPosition.x ) + ( currentHand.position.world.y - currentHandLastPosition.y ) )*.2;
					
					if( currentHandVelocity < 25 && currentHandVelocity > -25 ){
						
						//trace("user moving" , currentHandVelocity , " - " , currentHand.name)
						
					}else {
						
						//trace(">>>>>>>>>>>>>>>>>>>>>> user sliding" , currentHandVelocity , " - " , currentHand.name);
						
					}
					
					currentHandLastPosition = new Point(currentHand.position.world.x , currentHand.position.world.y);
					currentHand = null;
				}
				
			}else{
				currentUser = null;
				currentHand = null;
				//trace("no currentUser  -  ",device.users.length)
				for each (var us:User in device.users) 
				{
					validateUsers();
				}
			}
			
		}
		/*
		protected function device_usersAddedHandle(event:UserEvent):void
		{
			if(currentUser){
				trace("existe user  -  " , currentUser.userID );
				return;
			}else{
				validateUsers();
			}
		}
		private function device_usersRemoveHandle(event:UserEvent):void
		{
			for each (var u:User in device.users)
			{
				if(u == currentUser){
					removeCurrentUser()
					validateUsers();
				}
				
			}
		}
		*/
		
		private function validateUsers():void{
			for each (var u:User in device.users) 
			{
				if( currentUser && currentUser.userID == u.userID && !validateUserToInteraction(u)){
					removeCurrentUser();
				}else if(currentUser == null && validateUserToInteraction(u)){
					currentUser = u;
				}
			}
		}
		
		private function validateUserToInteraction(user:User):Boolean{
			//trace(">>>",user.torso.position.world.z , uint(xmlConfig..kinect.interactionDistance) , "x:  " , user.torso.position.world.x ,uint(xmlConfig..kinect.interactionArea)*.5 , -1*(uint(xmlConfig..kinect.interactionArea)*.5))
			if( user.torso.position.world.x <  uint(xmlConfig..kinect.interactionArea)*.5 && user.torso.position.world.x >  -1*(uint(xmlConfig..kinect.interactionArea)*.5) && user.torso.position.world.z < uint(xmlConfig..kinect.interactionDistance)){
				return true
			}
			return false;
		}
		
		private function removeCurrentUser():void{
			trace("removing user")
			root.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			calculeHand = false;
			currentUser = null;
			
			setTimeout(function():void{
				root.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			} , 2000);
			
		}
		
		//---------------------------SHORTCUTS
		private function get viewController():ViewController{
			return Core.getInstance().getShell(AppConstants.SHELL_VIEW) as ViewController;
		}
		
		private function get xmlConfig():XML{
			return ( Core.getInstance().getShell(AppConstants.SHELL_CONFIG) as Object).xmlConfig;
		}
	}
}