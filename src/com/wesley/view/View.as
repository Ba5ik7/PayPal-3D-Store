package com.wesley.view {
	import away3d.containers.View3D;
	import com.wesley.model.CartModel;
	import com.wesley.events.BtnEvent;
	import flash.display.Stage;
	import com.wesley.events.ModelEvent;
	import com.wesley.model.Model;
	import flash.display.Sprite;

	/**
	 * @author wesley
	 */
	public class View extends Sprite {
		
		public var model : Model;
		
		public var cart : CartModel;
		
		private var _evt : BtnEvent;
		
		protected var _Stage : Stage;
		
		protected var _Stage3D : View3D;
		
		
		public function View( _stage : Stage , _stage3D : View3D) {
			_Stage = _stage;
			_Stage3D = _stage3D;
			
			_Stage.addEventListener(BtnEvent.BTNCATEGORYCLICK, updateProductView);
			_Stage.addEventListener(BtnEvent.BTNPRODUCTCLICK, updateDetailView);
			
			super();
		}
		
		public function set modelData( m : Model ) : void {
			model = m;
			model.addEventListener(ModelEvent.MODEL_COMPLETE, modelComplete);
			
		}
		
		public function set cartData ( c : CartModel ) : void {cart = c;}
		
		//3DAway
		public function loop() : void { }
		
		
		
		
		protected function modelComplete ( event : ModelEvent ) : void {
			_evt = new BtnEvent("btnCategoryClick");
			_evt.data = model.allData[0].productArray;
			_Stage.dispatchEvent(_evt);
			
		}
		
		protected function updateProductView ( event : BtnEvent ) : void {
			
		}
		
		protected function updateDetailView ( event : BtnEvent ): void {
			
			
		}
		
	}
}
