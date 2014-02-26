package com.wesley.compontents {
	import com.wesley.events.BtnEvent;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.display.Sprite;

	/**
	 * @author wesley
	 */
	public class BTN_Generic extends Sprite {
		
		public var txt : TextField;
		
		
		private var _text : String;
		private var _textSize : Number;
		private var _textColor : uint;
		private var _width : Number;
		private var _height : Number;
		private var _bgColor : uint;
		private var _lineThinkness : Number;
		private var _lineColor : uint;
		private var _tf : TextFormat;
		private var _evt : BtnEvent;
		
		
		public function BTN_Generic(textW : String, 
							   		textSizeW : Number, 
									textColorW : uint, 
									widthW : Number, 
									heightW : Number, 
									bgColorW : uint, 
									lineThinknessW : Number, 
									lineColorW : uint,
									useClickW : Boolean=true) {
		
			super();
			
			_text = textW;
			
			this.name = _text;
		
			_textSize = textSizeW;
			_textColor = textColorW;
			_width = widthW;
			_height = heightW;
			_bgColor = bgColorW;
			_lineThinkness = lineThinknessW;
			_lineColor = lineColorW;
		
			this.buildBackground();
			this.buildTextField();
			
			if(useClickW){this.addEventListener(MouseEvent.CLICK, click);}
			
			this.addEventListener(MouseEvent.MOUSE_OVER, over);
			this.addEventListener(MouseEvent.MOUSE_OUT, out);
			txt.mouseEnabled = false;
			
			addChild(txt);
		
		}
		
		
		
		
		private function buildTextField() : void {
			_tf = new TextFormat();
			_tf.color = _textColor;
			_tf.size = _textSize;
			_tf.kerning = true;
			_tf.bold = true;
			//_tf.font ="caviarDreamB";

			txt = new TextField();
			txt.embedFonts = false;
			txt.defaultTextFormat = _tf;
			txt.text = _text;
			txt.width = _width;
			txt.selectable = false;
			txt.autoSize = TextFieldAutoSize.CENTER;
			//Center Ver
			txt.y = (_height*.5) - (txt.height*.5);
		}

		private function buildBackground() : void {
			this.graphics.lineStyle(_lineThinkness, _lineColor);
			this.graphics.beginFill(_bgColor);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
			this.buttonMode = true;
		}
		
		
		private function click( event : MouseEvent ) : void {
			_evt = new BtnEvent("btnClick");
			_evt.name = name;
			dispatchEvent(_evt);
		}
		
		
		private function out( event : MouseEvent ) : void {
			
		}

		private function over( event : MouseEvent ) : void {
			
		}
	}
}
