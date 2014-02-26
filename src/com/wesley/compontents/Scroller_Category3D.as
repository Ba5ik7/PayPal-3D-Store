package com.wesley.compontents {
	import away3d.lights.DirectionalLight;
	import flash.geom.Vector3D;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.lights.PointLight;
	import away3d.containers.ObjectContainer3D;
	import com.greensock.TweenMax;
	import com.wesley.Object.ObjCat;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.display.Sprite;
	/**
	 * @author wesley
	 */
	public class Scroller_Category3D extends ObjectContainer3D {
		
		private var _arr : Array;
		private var _width : int;
		private var _height : int;
		private var _yOffset : Number;
		private var _yMin : Number = 0;
		private var _yMax : Number = 0;
		private var _con : ObjectContainer3D;
		private var _thumb : Sprite;
		private var _track : Sprite;
		private var _stage : Stage;
		private var _tempHeight : Number = new Number;
		
		private var skyLight : PointLight;
		private var light1:DirectionalLight;
		private var light2:DirectionalLight;
		private var lightPicker:StaticLightPicker;
		
		public function Scroller_Category3D ( stageW : Stage, arrW : Array, widthW : int = 180, heightW : int = 500 ) {
			super();
			
			_stage = stageW;
			_arr = arrW;
			_width = widthW;
			_height = heightW;
			
			initLights();;
			buildCon();	
			buildScrollBar();
			
			_yMax = _track.height - _thumb.height;
			
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			//_con.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
			
		}

		private function initLights() : void {
			light1 = new DirectionalLight();
			light1.direction = new Vector3D(0, -250, 500);
			light1.color = 0x0000FF;
			light1.ambient = 0.7;
			light1.diffuse = 0.7;

			this.addChild(light1);
			
			light2 = new DirectionalLight();
			
			light2.direction = new Vector3D(0, 0, 500);
			light2.color = 0xed0b81;
			light2.ambient = 0.1;
			light2.diffuse = 0.1;
			
			this.addChild(light2);
			
			skyLight = new PointLight();
			skyLight.color = 0xFFFFFF;
			skyLight.y = 500;
			skyLight.z = -650;
			skyLight.diffuse = .2;
			skyLight.specular = 0.7;
			skyLight.radius = 2000;
			skyLight.fallOff = 2500;
			this.addChild(skyLight);
			
			lightPicker = new StaticLightPicker([skyLight, light1, light2]);
		}
		
		
		private function buildCon () : void {
			_con = new ObjectContainer3D();
			addChild(_con);
			//skyLight.position = new Vector3D(_con.x, _con.y -150, _con.z - 1000);
			var i : int = 0;
			for each (var btn : ObjCat in _arr) {
				var button : BTN_Category3D = new BTN_Category3D(_stage, btn.name, btn.productArray);
				button.mat.lightPicker = lightPicker;
				button.y = i;
				_con.addChild(button);
				i += 60;
				_tempHeight += i;
			}
			
		}		
		

		
		private function buildScrollBar () : void {
			_track = new Sprite();
			_track.graphics.beginFill(0x000000, 0);
			_track.graphics.drawRoundRect(0, 0, 10, _height, 30);
			_track.graphics.endFill();
			_track.mouseEnabled = false;
			_track.x = _width + 5;
			//_stage.addChild(_track);
			
			_thumb = new Sprite();
			_thumb.graphics.beginFill(0xFFFFFF, 1);
			//Try find a way to ajusted the height based on the how much text there is
			_thumb.graphics.drawRoundRect(0, 0, 10, 100, 20);
			_thumb.graphics.endFill();
			_thumb.buttonMode = true;
			_thumb.x = _width + 5;
			
			//_stage.addChild(_thumb);
			
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
			TweenMax.to(_con, 1, {y:(-sp*(_tempHeight - 500))});
			event.updateAfterEvent();
		}
		
		private function thumbUp( event : MouseEvent ) : void {
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}
		
		
	}
}
