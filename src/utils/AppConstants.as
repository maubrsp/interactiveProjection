package utils
{
	
	import flash.filesystem.File;

	public class AppConstants
	{
		//
		//----------------------------- APPLICTION SOURCES
		public static const APP_PATCH:String = "kinectMediaTv";
		public static const APP_ASSETS_PATCH:String = "assets";
		
		
		//----------------------------- CONFIG
		public static const SHELL_CONFIG:String = "shellConfig";
		public static const GET_CONFIGURATION:String = "getConfiguration";

		//----------------------------- ASSETS
		public static const SHELL_ASSETS_MANAGER:String = "shellAssetsManager";
		public static const ASSET_LOAD_ASSET:String = "assetLoadAsset";
		public static const ASSET_INIT:String = "assetInit";
		
		//Paths
		public static const CONTENT_STORAGE:File = File.documentsDirectory;
		public static const CONTENT_FOLDER:String = "mediaGalery";
		
		//Starling View Controller
		public static const SHELL_VIEW:String = "shellView";
		public static const VIEW_ADD_ITEN:String = "viewAddIten";
		public static const VIEW_REMOVE_ITEN:String = "viewRemoveIten";
		public static const VIEW_INIT_GALLERY:String = "viewInitGallery";
		public static const VIEW_ADD_STARLING_PROGRAM:String = "viewAddStarlingProgram";
		//Starling View Controller
		public static const SHELL_KINECT:String = "shellKinect";
		
		public static function get assetsFolder():String{
			return APP_PATCH + "/" + APP_ASSETS_PATCH + "/";
		}
		
	}
}