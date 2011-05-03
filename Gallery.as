package 
{
	import com.bigspaceship.utils.Out;
	import com.quickspikes.controller.GalleryController;
	import com.quickspikes.view.GalleryView;
	
	import fl.controls.*;
	import fl.transitions.*;
	
	import flash.display.MovieClip;
	
	import net.ored.util.ORedUtils;
	
	[SWF (backgroundColor="#ffffff", frameRate="24")]
	public class Gallery extends MovieClip
	{
		
		public function Gallery()
		{
			super();
			ORedUtils.turnOutOn();
			Out.info(this, "Welcome to the Quick Spikes Photo Gallery");
			
			var gc:GalleryController = new GalleryController(stage, new GalleryViewClip());
			addChild(gc.mc);
			
		}
	}
}