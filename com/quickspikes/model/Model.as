package com.quickspikes.model
{
	import com.bigspaceship.utils.Environment;
	import com.bigspaceship.utils.Out;
	
	import fl.data.DataProvider;
	
	import flash.display.LoaderInfo;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Timer;
	
	import net.ored.util.ORedUtils;
	
	public class Model extends EventDispatcher
	{
		//singleton!!
		private static var __instance		:Model;
		
		//flash vars
		public var configPath					:String = "";
		
		//for navigation
		private var _curImage					:Number = 0;	
		private var _nextSlide					:String = "";
		
		//timer pointer
		public var timer						:Timer;
		
		//constants 
		public static const DEFAULT_PATH		:String = "php/wp-content/themes/quickspikes/";
		public static const IMG_PATH			:String = "img/gallery/";
		public static const XML_PATH			:String = "xml/gallery/config.xml";
		public static const TIMER_INTERVAL		:Number = 4000;
		
		// USER CONFIG SETTINGS =====
		public static const AUTO_START			:Boolean = true;
		public static const TWEEN_DURATION		:Number = .3;
		public static const TRANSITION_TYPE		:String = "Random"; // Blinds, Fade, Fly, Iris, Photo, PixelDissolve, Rotate, Squeeze, Wipe, Zoom, Random
		public static const STATIC_XML			:String="<photos><image title='Test 1'>image1.jpg</image><image title='Test 2'>image2.jpg</image><image title='Test 3'>image3.jpg</image><image title='Test 4'>image4.jpg</image></photos>";
		public static const TRANSITION_ON		:Boolean = true; // true, false
		// END USER CONFIG SETTINGS
		
		private var _imageDP						:DataProvider;
		private var _imageList						:XML;
		// =================================================
		// ================ @Callable
		// ================================================= 
		public static function getInstance():Model { return __instance || (__instance = new Model()); };
		public function init($loaderInfo:LoaderInfo):void{
			Out.status(this, "init");
			
			// DECLARE VARIABLES AND OBJECTS =====
			_imageList 	= new XML();
			_imageDP 	= new DataProvider();
			// END DECLARATIONS

			ORedUtils.printFlashVars($loaderInfo.parameters);
			if (Environment.IS_IN_BROWSER){
				
				configPath	= $loaderInfo.parameters.configPath ? $loaderInfo.parameters.configPath : DEFAULT_PATH;
			}
				else	configPath	= DEFAULT_PATH;
			Out.debug(this, "theme path: "+ configPath);
		}//end function
		
	
		
		
		// =================================================
		// ================ @Workers
		// =================================================
		
		private function _parseImageXML(imageXML:XML):void
		{
			Out.status(this, "fl_parseImageXML");
			var imagesNodes:XMLList = imageXML.children();
			for(var i:* in imagesNodes)
			{
				var imgURL:String = imagesNodes[i];
				var imgTitle:String = imagesNodes[i].attribute("title");
				imageDP.addItem({source:configPath+IMG_PATH+imgURL, imgID:i});
			}//end for
			
		}//end function
		
		// =================================================
		// ================ @Handlers
		// =================================================
		
		// =================================================
		// ================ @Animation
		// =================================================
		
		// =================================================
		// ================ @Getters / Setters
		// =================================================
		public function get currentImageID():Number{ return _curImage;} 
		public function set currentImageID($i:Number):void{ _curImage = $i;} 
		public function get imageDP():DataProvider{ return _imageDP;} 
		public function set imageList($xml:XML):void{ _imageList = $xml; _parseImageXML($xml);} 
		// =================================================
		// ================ @Interfaced
		// =================================================
		
		// =================================================
		// ================ @Core Handler
		// =================================================
		
		// =================================================
		// ================ @Overrides
		// =================================================
		
		// =================================================
		// ================ @Constructor
		// =================================================
		
	}//end class
}//end package