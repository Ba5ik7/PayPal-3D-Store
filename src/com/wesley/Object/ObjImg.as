package com.wesley.Object {
	import com.wesley.events.ModelEvent;
	import flash.display.PixelSnapping;
	import flash.events.Event;
	import flash.display.BitmapData;
	import com.wesley.model.Model;
	import flash.display.Bitmap;
	/**
	 * @author wesley
	 */
	public class ObjImg extends Model {

		public var color : String;
		public var img :  Bitmap = new Bitmap();
		
		
		private var _imageBMD : BitmapData;
		
		public function ObjImg (_url : String, _color : String) {
			color = _color;	
			
			
			super.loadImage(_url);
		}
		
		
		
		override protected function imageLoaded ( event : Event) : void {
			//Draw the bitmapdata
			_imageBMD = new BitmapData(256, 
										256, 
										true, 0x0000FF);
			_imageBMD.draw(event.target.content, null, null, null, null, false);
			img = new Bitmap(_imageBMD, PixelSnapping.AUTO, false);
			_imageBMD = null;
			
			//Clean up
			super.imageLoaded(event);
			this.dispatchEvent(new ModelEvent(ModelEvent.IMAGE_READY ));
		}
		
	}
}
