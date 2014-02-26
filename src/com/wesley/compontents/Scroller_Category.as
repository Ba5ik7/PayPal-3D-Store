package com.wesley.compontents {
	import com.wesley.events.ModelEvent;
	import com.greensock.TweenMax;
	import com.wesley.Object.ObjCat;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * @author wesley
	 */
	public class Scroller_Category extends Sprite {
		
		private var _arr : Array;
		private var _width : int;
		private var _height : int;
		private var _yOffset : Number;
		private var _yMin : Number = 0;
		private var _yMax : Number = 0;
		private var _masker : Shape;
		private var _con : Sprite;
		private var _thumb : Sprite;
		private var _track : Sprite;
		private var _stage : Stage;
		
		public function Scroller_Category ( stageW : Stage, arrW : Array, widthW : int = 180, heightW : int = 500 ) {
			super();
			
			_stage = stageW;
			_arr = arrW;
			_width = widthW;
			_height = heightW;
			
			
			buildCon();	
			buildScrollBar();
			buildMasker();
			_yMax = _track.height - _thumb.height;
			
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			//_con.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
			
		}
		
		
		private function buildCon () : void{
			_con = new Sprite();
			addChild(_con);
			var i : int = 0;
			for each (var btn : ObjCat in _arr) {
				var button : BTN_Category = new BTN_Category(_stage, btn.name, btn.productArray);
				button.y = i;
				button.mouseChildren = false;
				button.buttonMode = true;
				_con.addChild(button);
				i += button.height + 10;
			}
		}		
		
		private function buildMasker () : void {
			_masker = new Shape;
			_masker.graphics.beginFill(0x000000, 1);
			_masker.graphics.drawRect(0,0, _width, _height);
			_masker.graphics.endFill();
			_con.mask = _masker;
			addChild(_masker);
		}
		
		private function buildScrollBar () : void {
			_track = new Sprite();
			_track.graphics.beginFill(0x000000, 0);
			_track.graphics.drawRoundRect(0, 0, 10, _height, 30);
			_track.graphics.endFill();
			_track.mouseEnabled = false;
			_track.x = _width + 5;
			addChild(_track);
			
			_thumb = new Sprite();
			_thumb.graphics.beginFill(0xFFFFFF, 1);
			//Try find a way to ajusted the height based on the how much text there is
			_thumb.graphics.drawRoundRect(0, 0, 10, 100, 20);
			_thumb.graphics.endFill();
			_thumb.buttonMode = true;
			_thumb.x = _width + 5;
			addChild(_thumb);
			
		}
		
		
		private function thumbDown( event : MouseEvent ) : void {
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			_yOffset = mouseY - _thumb.y;
		}
		
		private function thumbMove( event : MouseEvent ) : void {
			_thumb.y = mouseY - _yOffset;
			
			if(_thumb.y <= _yMin){
				_thumb.y = _yMin;
			}
			if(_thumb.y >= _yMax){
				_thumb.y = _yMax;
			}
			
			
			var sp:Number = _thumb.y / _yMax;
			TweenMax.to(_con, 1, {y:(-sp*(_con.height-_masker.height))});
			event.updateAfterEvent();
		}
		
		private function thumbUp( event : MouseEvent ) : void {
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}
		
		
	}
}
