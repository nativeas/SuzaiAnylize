package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class Start extends Sprite
	{
		private var loader:Loader = null;
		public function Start()
		{
			this.stage.scaleMode =StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
	
			addChild(new testenc());
		}
	}
		
		
}