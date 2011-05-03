package 
{
	import com.bigspaceship.display.StandardButtonInOut;
	import com.bigspaceship.utils.Out;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	import net.ored.util.ORedUtils;
	
	[SWF (width="425", height="98", backgroundColor="#ffffff", frameRate="24")]
	public class QuickSpikesMainLogo extends MovieClip
	{

		
		//standards
		private var _ml			:StandardButtonInOut;
		
		
		// =================================================
		// ================ @Callable
		// =================================================
		public function asWillOpen():void{
			Out.info(this, "asWillOpen");
			_ml.animateIn();
		}
		public function asWillGoIdle():void{
			_ml.mc.play();
		}
		public function asWillAnimateIn():void{
			_ml.animateIn();
		}
		// =================================================
		// ================ @Workers
		// =================================================
		private function _init():void{
			ORedUtils.turnOutOn();
			Out.info(this, "_init():: Welcome to the logo");
			
			if (ExternalInterface.available) {
				try {
					Out.debug(this, "Adding callback...\n");
					ExternalInterface.addCallback("jsSaysOpen", asWillOpen);
					ExternalInterface.addCallback("jsSaysGoIdle", asWillGoIdle);
					ExternalInterface.addCallback("jsSaysAnimateIn", asWillAnimateIn);
					if (checkJavaScriptReady()) {
						Out.debug(this,"JavaScript is ready.\n");
					} else {
						Out.debug(this, "JavaScript is not ready, creating timer.\n");
						var readyTimer:Timer = new Timer(100, 0);
						readyTimer.addEventListener(TimerEvent.TIMER, timerHandler);
						readyTimer.start();
					}
				} catch (error:SecurityError) {
					Out.error(this,"A SecurityError occurred: " + error.message + "\n");
				} catch (error:Error) {
					Out.error(this,"An Error occurred: " + error.message + "\n");
				}
			} else {
				Out.error(this, "External interface is not available for this container.");
			}
			_ml = new StandardButtonInOut(new QuickSpikesLogo());
			_ml.addEventListener(MouseEvent.ROLL_OVER, _overHandler);
			addChild(_ml.mc);
			_ml.animateIn();
			
		}//end function _init()
		
		// =================================================
		// ================ @Handlers
		// =================================================
		private function _overHandler($me:MouseEvent):void{
			Out.status(this, "over");
		}//end function
		
		private function checkJavaScriptReady():Boolean {
			var isReady:Boolean = ExternalInterface.call("isReady");
			return isReady;
		}
		private function timerHandler(event:TimerEvent):void {
			Out.debug(this, "Checking JavaScript status...\n");
			var isReady:Boolean = checkJavaScriptReady();
			if (isReady) {
				Out.debug(this,"JavaScript is ready.\n");
				Timer(event.target).stop();
			}
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

		public function QuickSpikesMainLogo()
		{
			super();
			_init();
			
		}//end constructor
	}//end class
}//end package