package com.wesley.view {


	import away3d.materials.lightpickers.StaticLightPicker;
	import flash.utils.getTimer;
	import com.greensock.easing.Expo;
	import away3d.lights.PointLight;
	import flash.geom.Vector3D;
	import away3d.lights.DirectionalLight;
	import away3d.containers.ObjectContainer3D;
	import com.wesley.compontents.Scroller_Product3D;
	import away3d.containers.View3D;
	import com.wesley.compontents.Tile_Product3D;
	import com.greensock.easing.Sine;
	import com.greensock.TweenMax;
	import com.wesley.Object.ObjPro;
	import com.wesley.events.BtnEvent;
	import com.wesley.view.View;
	import flash.display.Stage;

	/**
	 * @author wesley
	 */
	public class ViewProduct extends View {

		private var _arrBtn : Array = new Array();
		private var _scroller3D : Scroller_Product3D;
		private var _setup : Boolean = false;
		private var _completeTicker : int;
		
		private var whatToCheck : int;
		private var _tempHeight : Number = new Number;

		private var light1:DirectionalLight;
		private var light2:DirectionalLight;
		private var skyLight : PointLight;
		private var lightPicker:StaticLightPicker;
		
		

		
		
		public function ViewProduct(_stage : Stage, _stage3D : View3D) {
			super(_stage, _stage3D);
			light1 = new DirectionalLight();
			light1.direction = new Vector3D(0, -250, 0);
			light1.color = 0xed0b81;
			light1.ambient = 1;
			light1.diffuse = 1;
			light1.specular = .5;

			_Stage3D.scene.addChild(light1);
			
			light2 = new DirectionalLight();
			light2.direction = new Vector3D(0, -100, 500);
			light2.color = 0xed0b81;
			light2.ambient = 1;
			light2.diffuse = 1;
			light2.specular = .5;

			_Stage3D.scene.addChild(light2);

			skyLight = new PointLight();
			skyLight.color = 0xFFFFFF;
			skyLight.y = -250;
			skyLight.z = -600;
			skyLight.diffuse = 1;
			skyLight.specular = 0.5;
			skyLight.radius = 2000;
			skyLight.fallOff = 2500;
			_Stage3D.scene.addChild(skyLight);

			lightPicker = new StaticLightPicker([light1, light2, skyLight]);
			
			_scroller3D  = new Scroller_Product3D(_stage, _arrBtn);
			_scroller3D.x = 50;
			_Stage3D.scene.addChild(_scroller3D);
		}
		
		override public function loop() : void { 
			light1.direction = new Vector3D(Math.sin(getTimer()/1500)*150000, 1000, Math.cos(getTimer()/1500)*150000);
			light2.direction = new Vector3D(Math.sin(getTimer()/1500)*-150000, 1000, Math.cos(getTimer()/1500)*-150000);
			skyLight.position = new Vector3D(Math.sin(getTimer()/1500)*-150000, 1000, Math.cos(getTimer()/1500)*-150000);


		}


			
		override protected function updateProductView( event : BtnEvent ) : void {
			_arrBtn = [];
			var col : int = 0;
			var row : Number = 0;
			var i : Number = 0;
			for each ( var objPro : ObjPro in event.data){

				var btn : Tile_Product3D = new Tile_Product3D(_Stage, objPro, objPro.name);
				_arrBtn.push(btn);				
				if (col == 3){
					col = 0;
					row -= 160;
					i = 0;
				}

				btn.futureX = i;
				btn.futureY = row;
				btn._cubeMaterial.lightPicker = lightPicker;

				i += 160;
				++col;
				
				
			}
			
			_tempHeight = row + 160;
			_setup ? null : _scroller3D.update(_arrBtn, _tempHeight);
			_setup ? outro() : intro();
			_setup = true;
			
		}
		
		public function intro () : void {
			var i : Number = 0;
			_completeTicker = _arrBtn.length;
			for each (var btn : Tile_Product3D in _arrBtn) {
				TweenMax.to(btn, .5, {x:btn.futureX, 
											y:btn.futureY,
											z:0,
											delay:i, 
											ease:Sine.easeIn});
				i += .1;
			}
			TweenMax.to(_Stage3D.camera, 1, {x:0, y:-250, z:-800, ease:Sine.easeOut, onComplete:yoyoCam});
			_arrBtn = [];

		}
		
		private function yoyoCam () : void {
			TweenMax.to(_Stage3D.camera, 3, {y:100, z:-600, ease:Expo.easeOut});
			
		}
		
		
		
		public function outro () : void {	
			var tempArr : Array = getChildrenOf(_scroller3D._con);
			whatToCheck = tempArr.length;
			var i : Number = 0;
			var k : int;
			for(k = 0; k <= tempArr.length - 1; ++k){
				TweenMax.to(tempArr[k], .5, {		y:200, z:-750, x:0,
											delay:i, 
											ease:Sine.easeIn,
											onComplete:checkIt});
				i += .1;
			}
			TweenMax.to(_Stage3D.camera, 1, {x:-600, z:-100, ease:Sine.easeOut});
		}
		
		
		public function getChildrenOf(target:ObjectContainer3D):Array {
		   var children:Array = [];
		   for (var i:uint = 0; i < target.numChildren; i++)
		      children.push(target.getChildAt(i));	
		   return children;
		}
		
		

		
		private function checkIt() : void {
			--whatToCheck;
			if (whatToCheck === 0) {
				_scroller3D.update(_arrBtn, _tempHeight);
				intro();
			}
			
		}
		
		
		
	}
}
