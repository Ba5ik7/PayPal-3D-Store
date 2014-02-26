package com.wesley.compontents {
	import com.wesley.events.BtnEvent;
	import away3d.containers.ObjectContainer3D;
	import com.greensock.TweenMax;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.display.Sprite;

	/**
	 * @author wesley
	 */
	public class Scroller_Product3D extends ObjectContainer3D {
		
		
		private var _arr : Array = new Array();
		private var _height : int = 500;
		private var _yOffset : Number;
		private var _yMin : Number = 0;
		private var _yMax : Number = 0;
		public var _con : ObjectContainer3D = new ObjectContainer3D();
		private var _thumb : Sprite;
		public var _track : Sprite;
		private var _stage : Stage;
		
		private var _tempHeight : Number = new Number;
		
		public function Scroller_Product3D( stageW : Stage, arrW : Array) {
			super();
			
			_stage = stageW;
			_arr = arrW;
			
			fillCon();	
			buildScrollBar();
	
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
			_stage.addEventListener(BtnEvent.BTNPRODUCTCLICK, hideScroller);
			_stage.addEventListener(BtnEvent.BTNBACKCLICK, showScroller);
			
			
			_con = new ObjectContainer3D();
			_con.x = -150;
			addChild(_con);			
			
			_yMax = _track.height - _thumb.height;

		}
		
		
		public function update ( arrW : Array , tempHeightW : Number) : void {
			while(_con.numChildren > 0) { _con.removeChildAt(0); }
			_tempHeight = tempHeightW;
			_thumb.y = 0;
			_con.y = 0;
			for each (var btn : Tile_Product3D in arrW) {
				btn.x = 250;
				btn.y = -2000;
				btn.z = 2000;
				_con.addChild(btn);
			}
			
		}
		
		
		private function fillCon () : void{
			for each (var btn : Tile_Product3D in _arr) {
				btn.x = 0;
				btn.y = 0;
				_con.addChild(btn);
			}
		}		
		
		
		private function buildScrollBar () : void {
			_track = new Sprite();
			_track.graphics.beginFill(0x333333, 1);
			_track.graphics.drawRoundRect(0, 0, 10, _height, 30);
			_track.graphics.endFill();
			_track.y = 25;
			_track.x = 825;
			_stage.addChild(_track);
			
			_thumb = new Sprite();
			_thumb.graphics.beginFill(0xFFFFFF, 1);
			_thumb.graphics.drawRoundRect(0, 0, 10, 100, 20);
			_thumb.graphics.endFill();
			_thumb.buttonMode = true;
			_track.addChild(_thumb);
		}
		
		private function hideScroller ( event : BtnEvent ) : void {
			_track.alpha = 0;
			_thumb.mouseEnabled = false;
		}
		
		private function showScroller ( event : BtnEvent ) : void {
			_track.alpha = 1;
			_thumb.mouseEnabled = true;
		}
		
		
		private function thumbDown( event : MouseEvent ) : void {
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			_yOffset = _stage.mouseY - _thumb.y;
		}
		
		private function thumbMove( event : MouseEvent ) : void {
			_thumb.y = _stage.mouseY - _yOffset;
			
			if(_thumb.y <= _yMin){
				_thumb.y = _yMin;
			}
			if(_thumb.y >= _yMax){
				_thumb.y = _yMax;
			}
			
			
			var sp:Number = _thumb.y / _yMax;
			TweenMax.to(_con, 1, {y:(-sp*(_tempHeight - 250))});
			event.updateAfterEvent();
		}
		
		private function thumbUp( event : MouseEvent ) : void {
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}
		
		
	}
}
