package com.quickspikes.controller
{
	import com.bigspaceship.display.StandardButton;
	import com.bigspaceship.display.StandardInOut;
	import com.bigspaceship.utils.Out;
	import com.quickspikes.model.Model;
	import com.quickspikes.view.GalleryView;
	
	import fl.controls.*;
	import fl.data.DataProvider;
	import fl.events.ListEvent;
	import fl.transitions.*;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class GalleryController extends StandardInOut
	{
		private var _s		:Stage;
		private var _m		:Model;
		private var _view	:GalleryViewClip;
		
		public var imageHolder:ImageHolder;
		public var imageTiles:TileList;
		
		private var _playPauseToggleBtn:MovieClip;
		public var next_btn:ArrowButton;
		public var prev_btn:ArrowButton;
		
		private var _timer:Timer;
		private var _ldr:URLLoader;
		
		// =================================================
		// ================ @Callable
		// =================================================
		
		// =================================================
		// ================ @Workers
		// =================================================
		private function _init():void{
			
			Out.status(this, "init");
			_m					= Model.getInstance();
			_m.init(_s.loaderInfo);
			_loadConfigXML();
		
		}//end function
		private function _loadConfigXML():void{
			
			// CODE FOR HARDCODED XML =====
			//_m.imageList = XML(Model.STATIC_XML);
			_ldr = new URLLoader();
			var url:String		= _m.configPath + Model.XML_PATH;
			var req:URLRequest 	= new URLRequest(url);
			_ldr.addEventListener(Event.COMPLETE, _xmlLoaded, false, 0, true);
			_ldr.addEventListener(IOErrorEvent.IO_ERROR, _xmlFailed, false, 0, true);
			_ldr.load(req);
			
		}//end function 
		
		private function _loadUpVars():void{
			
			_playPauseToggleBtn = _view.playPauseToggle_mc;
			next_btn			= _view.next_btn;
			prev_btn			= _view.prev_btn;
			imageTiles			= _view.imageTiles;
			imageTiles.dataProvider	= _m.imageDP;
			imageHolder			= _view.imageHolder;
			imageHolder.imageLoader.source = _m.imageDP.getItemAt(_m.currentImageID).source;
			//_view.title_txt.text = _m.imageDP.getItemAt(_m.currentImageID).label;
			_view.title_txt.visible = false;
		}//end function 
		
		private function _createTimer():void{
			_timer = new Timer(Model.TIMER_INTERVAL);
			
		}//end function 
		
		private function _addHandlers():void{
			
			imageTiles.addEventListener(ListEvent.ITEM_CLICK, fl_tileClickHandler);
			_playPauseToggleBtn.addEventListener(MouseEvent.CLICK, fl_togglePlayPause);
			next_btn.addEventListener(MouseEvent.CLICK, fl_nextButtonClick);
			prev_btn.addEventListener(MouseEvent.CLICK, fl_prevButtonClick);
			_timer.addEventListener(TimerEvent.TIMER, fl_slideShowNext);
			
		}//end function
	
		private function fl_startSlideShow():void
		{
			_timer.start();
		}
		
		private function fl_pauseSlideShow():void
		{
			_timer.stop();
		}
		
		private function fl_nextSlide():void
		{
			_m.currentImageID++;
			if(_m.currentImageID >= _m.imageDP.length)
			{
				_m.currentImageID = 0;
			}
			if(Model.TRANSITION_ON == true)
			{
				fl_doTransition();
			}
			imageHolder.imageLoader.source = _m.imageDP.getItemAt(_m.currentImageID).source;
			//_view.title_txt.text = _m.imageDP.getItemAt(_m.currentImageID).label;
		}
		
		private function fl_prevSlide():void
		{
			_m.currentImageID--;
			if(_m.currentImageID < 0)
			{
				_m.currentImageID = _m.imageDP.length-1;
			}
			if(Model.TRANSITION_ON == true)
			{
				fl_doTransition();
			}
			imageHolder.imageLoader.source = _m.imageDP.getItemAt(_m.currentImageID).source;
			//_view.title_txt.text = _m.imageDP.getItemAt(_m.currentImageID).label;
		}
		
		private function fl_doTransition():void
		{
			if(Model.TRANSITION_TYPE == "Blinds")
			{
				TransitionManager.start(imageHolder, {type:Blinds, direction:Transition.IN, duration:Model.TWEEN_DURATION});
			} else if (Model.TRANSITION_TYPE == "Fade")
			{
				TransitionManager.start(imageHolder, {type:Fade, direction:Transition.IN, duration:Model.TWEEN_DURATION});
			} else if (Model.TRANSITION_TYPE == "Fly")
			{
				TransitionManager.start(imageHolder, {type:Fly, direction:Transition.IN, duration:Model.TWEEN_DURATION});
			} else if (Model.TRANSITION_TYPE == "Iris")
			{
				TransitionManager.start(imageHolder, {type:Iris, direction:Transition.IN, duration:Model.TWEEN_DURATION});
			} else if (Model.TRANSITION_TYPE == "Photo")
			{
				TransitionManager.start(imageHolder, {type:Photo, direction:Transition.IN, duration:Model.TWEEN_DURATION});
			} else if (Model.TRANSITION_TYPE == "PixelDissolve")
			{
				TransitionManager.start(imageHolder, {type:PixelDissolve, direction:Transition.IN, duration:Model.TWEEN_DURATION});
			} else if (Model.TRANSITION_TYPE == "Rotate")
			{
				TransitionManager.start(imageHolder, {type:Rotate, direction:Transition.IN, duration:Model.TWEEN_DURATION});
			} else if (Model.TRANSITION_TYPE == "Squeeze")
			{
				TransitionManager.start(imageHolder, {type:Squeeze, direction:Transition.IN, duration:Model.TWEEN_DURATION});
			} else if (Model.TRANSITION_TYPE == "Wipe")
			{
				TransitionManager.start(imageHolder, {type:Wipe, direction:Transition.IN, duration:Model.TWEEN_DURATION});
			} else if (Model.TRANSITION_TYPE == "Zoom")
			{
				TransitionManager.start(imageHolder, {type:Zoom, direction:Transition.IN, duration:Model.TWEEN_DURATION});
			} else if (Model.TRANSITION_TYPE == "Random")
			{
				var randomNumber:Number = Math.round(Math.random()*9) + 1;
				switch (randomNumber) {
					case 1:
						TransitionManager.start(imageHolder, {type:Blinds, direction:Transition.IN, duration:Model.TWEEN_DURATION});
						break;
					case 2:
						TransitionManager.start(imageHolder, {type:Fade, direction:Transition.IN, duration:Model.TWEEN_DURATION});
						break;
					case 3:
						TransitionManager.start(imageHolder, {type:Fly, direction:Transition.IN, duration:Model.TWEEN_DURATION});
						break;
					case 4:
						TransitionManager.start(imageHolder, {type:Iris, direction:Transition.IN, duration:Model.TWEEN_DURATION});
						break;
					case 5:
						TransitionManager.start(imageHolder, {type:Photo, direction:Transition.IN, duration:Model.TWEEN_DURATION});
						break;
					case 6:
						TransitionManager.start(imageHolder, {type:PixelDissolve, direction:Transition.IN, duration:Model.TWEEN_DURATION});
						break;
					case 7:
						TransitionManager.start(imageHolder, {type:Rotate, direction:Transition.IN, duration:Model.TWEEN_DURATION});
						break;
					case 8:
						TransitionManager.start(imageHolder, {type:Squeeze, direction:Transition.IN, duration:Model.TWEEN_DURATION});
						break;
					case 9:
						TransitionManager.start(imageHolder, {type:Wipe, direction:Transition.IN, duration:Model.TWEEN_DURATION});
						break;
					case 10:
						TransitionManager.start(imageHolder, {type:Zoom, direction:Transition.IN, duration:Model.TWEEN_DURATION});
						break;
				}
			} else
			{
				trace("error - Model.TRANSITION_TYPE not recognized");
			}
		}
		// =================================================
		// ================ @Handlers
		// =================================================
		private function _xmlFailed($ioe:IOErrorEvent):void{ Out.error(this, "io error: "+ $ioe.text);	}
		private function _xmlLoaded($e:Event):void{
			Out.status(this, "xml loaded");
			
			_m.imageList = XML(_ldr.data);
			_ldr.removeEventListener(Event.COMPLETE, _xmlLoaded);
			_ldr = null;
			
			//commence with the good stuff
			_loadUpVars(); 
			_createTimer();
			_addHandlers();
			if(Model.AUTO_START == true)
			{
				fl_startSlideShow();
				_playPauseToggleBtn.gotoAndStop("pause");
			}
			
		}//end function
	
		private function fl_togglePlayPause(evt:MouseEvent):void
			{
				if(_playPauseToggleBtn.currentLabel == "play")
				{
					fl_startSlideShow();
					_playPauseToggleBtn.gotoAndStop("pause");
				}
				else if(_playPauseToggleBtn.currentLabel == "pause")
				{
					fl_pauseSlideShow();
					_playPauseToggleBtn.gotoAndStop("play");
				}
			}
		
			private function fl_tileClickHandler(evt:ListEvent):void
			{
				imageHolder.imageLoader.source = evt.item.source;
				_m.currentImageID = evt.item.imgID;
			}
			private function fl_nextButtonClick(evt:MouseEvent):void
			{
				fl_nextSlide();
			}
			private function fl_prevButtonClick(evt:MouseEvent):void
			{
				fl_prevSlide();
			}
			private function fl_slideShowNext(evt:TimerEvent):void
			{
				fl_nextSlide();
			}
		
		// =================================================
		// ================ @Animation
		// =================================================
		
		// =================================================
		// ================ @Getters / Setters
		// =================================================
		
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

		public function GalleryController($stage:Stage, $mc:GalleryViewClip)
		{
			super($mc);
			_s = $stage;
			_view = $mc;
			_init();

		}//end constructor
	}//end class
}//end package