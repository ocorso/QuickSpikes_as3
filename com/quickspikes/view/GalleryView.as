package com.quickspikes.view
{
	import fl.controls.TileList;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class GalleryView extends MovieClip
	{
		public var imageHolder:ImageHolder;
		public var imageTiles:TileList;
		
		public var playPauseToggle_mc:MovieClip;
		public var next_btn:ArrowButton;
		public var prev_btn:ArrowButton;
		public var title_txt:TextField;
		
		public function GalleryView()
		{
			super();
		}
	}
}