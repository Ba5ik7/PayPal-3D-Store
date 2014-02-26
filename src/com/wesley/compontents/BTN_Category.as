package com.wesley.compontents {
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import com.wesley.events.BtnEvent;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.display.Sprite;

	/**
	 * @author wesley
	 */
	public class BTN_Category extends Sprite {
		
		
		
		public var txtFl : TextField;
		
		private var _txt : String;
		private var _width : int = 175;
		private var _height : int = 50;
		private var _tf : TextFormat;
		private var _productData : Array;
		private var _evt : BtnEvent;
		private var _stage : Stage;
		
		

		public function BTN_Category(stageW : Stage, text : String, productData : Array) {
			_stage  = stageW;
			_txt = text;
			_productData = productData;
			
			this.addEventListener(MouseEvent.CLICK, click);
			
			
			this.graphics.lineStyle(1, 0xff0000);	
			this.graphics.beginFill(0x0000ff);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
			
			_tf = new TextFormat();
			_tf.color = 0xffffff;
			_tf.size = 24;
			_tf.kerning = true;
			_tf.bold = true;
			//_tf.font ="caviarDreamB";

			txtFl = new TextField();
			txtFl.embedFonts = false;
			txtFl.defaultTextFormat = _tf;
			txtFl.text = _txt;
			txtFl.width = _width;
			txtFl.selectable = false;
			txtFl.autoSize = TextFieldAutoSize.CENTER;
			//Center Ver
			txtFl.y = (_height*.5) - (txtFl.height*.5);
			addChild(txtFl);
			
		}
		
		
		
		
		
		
		
		private function click( event : MouseEvent ) : void {
				trace("Category BTN_CATEGORY Clicked!");
			
			_evt = new BtnEvent("btnCategoryClick");
			_evt.data = _productData;
			_stage.dispatchEvent(_evt);
		}
			


	}
}
