package com.wesley.compontents {
	
	
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import com.wesley.Object.ObjPro;
	import com.wesley.events.BtnEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextField;
	
	
	/**
	 * @author wesley
	 */
	public class Tile_Product extends Sprite {
		public var txtFl : TextField;
		public var futureX : Number;
		public var futureY : Number;
		
		
		
		private var _width : int = 143;
		private var _height : int = 143;		
		private var _txt : String;
		private var _tf : TextFormat;
		private var _evt : BtnEvent;
		private var _itemData : ObjPro;
		private var _thumb : Bitmap;

		public function Tile_Product(itemData:ObjPro, txt : String) {
			_itemData = itemData;
			_txt = txt;
						
			this.addEventListener(MouseEvent.CLICK, click);
			
			
			/*this.graphics.lineStyle(1, 0xff0000);	
			this.graphics.beginFill(0x0000ff);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();*/
			
			_tf = new TextFormat();
			_tf.color = 0xffffff;
			_tf.size = 24;
			_tf.kerning = true;
			_tf.bold = true;
			//_tf.font = "caviarDreamB";

			txtFl = new TextField();
			txtFl.embedFonts = false;
			txtFl.defaultTextFormat = _tf;
			txtFl.text = _txt;
			txtFl.width = _width;
			txtFl.selectable = false;
			txtFl.autoSize = TextFieldAutoSize.CENTER;
			//Center Ver
			txtFl.y = 135;
			addChild(txtFl);
			
			_thumb = new Bitmap( scaleBitmapData(_itemData.imgObjs[0].img.bitmapData, 0.55) );
			
			trace("width : " + _thumb.width + " height : " + _thumb.height);
			this.addChild ( _thumb);

		}
		
		private function scaleBitmapData(bitmapData:BitmapData, scale:Number):BitmapData {
            scale = Math.abs(scale);
            var width:int = (bitmapData.width * scale) || 1;
            var height:int = (bitmapData.height * scale) || 1;
            var transparent:Boolean = bitmapData.transparent;
            var result:BitmapData = new BitmapData(width, height, transparent, 0x00000000);
            var matrix:Matrix = new Matrix();
            matrix.scale(scale, scale);
            result.draw(bitmapData, matrix);
            return result;
        }
		
		
		private function click( event : MouseEvent ) : void {
				trace("Product BTN_PRODUCT Clicked!");
			
			_evt = new BtnEvent("btnProductClick");
			_evt.data = _itemData;
			dispatchEvent(_evt);
		}
		
		
	}
}

