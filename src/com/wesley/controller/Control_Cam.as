package com.wesley.controller {
	import com.greensock.easing.Expo;
	import away3d.entities.Mesh;
	import com.greensock.easing.Sine;
	import com.greensock.TweenMax;
	import flash.geom.Vector3D;
	import away3d.containers.View3D;
	import com.wesley.events.BtnEvent;
	import flash.display.Stage;
	/**
	 * @author wesley
	 */
	public class Control_Cam {
		
		private var _Stage : Stage;
		private var _View : View3D;
		private var camDirection : Vector3D;
		
		private var oldPos : Vector3D;
		private var currentCube : Mesh;
		
		
		
		public function Control_Cam (_stage : Stage, view : View3D) {
			_Stage = _stage;
			_View = view;		
			
			_Stage.addEventListener(BtnEvent.BTNCATEGORYCLICK, moveToCamCat);
			_Stage.addEventListener(BtnEvent.BTNPRODUCTCLICK, moveToCamPro);
			_Stage.addEventListener(BtnEvent.BTNBACKCLICK, moveBackToCamCat);
			camDirection = new Vector3D(0, -250, 0);
		}

		private function moveBackToCamCat( event : BtnEvent ) : void {
			TweenMax.to(camDirection, 1, {x:0, y:-250, z:0, ease:Sine.easeOut});
			TweenMax.to(_View.camera, 1, {x:0, y:100, z:-600, ease:Sine.easeOut});
			TweenMax.to(currentCube, 1, {x:(oldPos.x*.5)-75, y:(oldPos.y*.5)+75, z:oldPos.z, rotationY:0, ease:Sine.easeOut});
		}

		private function moveToCamCat(event : BtnEvent ) : void {
			TweenMax.to(camDirection, 1, {x:0, y:-250, z:0, ease:Sine.easeOut});
		}

		private function moveToCamPro( event : BtnEvent ) : void {
				
			oldPos = new Vector3D(event.posData.x, event.posData.y, event.posData.z);

			currentCube = event.cube;
			
			var tempVec : Vector3D = new Vector3D(event.posData.x, event.posData.y, event.posData.z);
			tempVec.x += 500;
			tempVec.y += 300;
			
			TweenMax.to(currentCube, 1, {x:tempVec.x, y:tempVec.y, z:-900, rotationY:90, ease:Sine.easeOut});	
			TweenMax.to(camDirection, 1, {x:500, y:200, z:-1000,
															ease:Sine.easeOut});
															
			TweenMax.to(_View.camera, 1, {x:0, y:200, z:-1000,
															ease:Sine.easeOut});

															
		}
		
		
		public function loop () : void {
			_View.camera.lookAt(camDirection);
		}
		
		
		
		
		
		
	}
}
