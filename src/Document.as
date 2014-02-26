package {
	import away3d.debug.AwayStats;
	import com.wesley.controller.Control_Cam;
	import flash.display.StageQuality;
	import flash.geom.Vector3D;
	import away3d.containers.View3D;
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import com.wesley.model.CartModel;
	import com.wesley.view.ViewDetails;
	import com.wesley.view.ViewProduct;
	import com.wesley.view.ViewStore;
	import com.wesley.view.View;
	import com.wesley.model.DataModel;
	import com.wesley.model.Model;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.display.Sprite;

	

	/**
	 * @author wesley
	 */
	
	[SWF( backgroundColor="#000000", width="1024", height="700", frameRate="30")]
	public class Document extends Sprite {
		
		private var _camCon : Control_Cam;
		private var _model : Model;
		private var _viewNavi : View;
		public var _viewProduct : View;
		private var _viewDetails : View;
		private var _cart : CartModel = new CartModel();
		
		//3D always
		//engine variables
    	private var scene:Scene3D;
		private var camera:Camera3D;
		private var view:View3D;
		
		public function Document() {
			addEventListener(Event.ADDED_TO_STAGE, initz);
		
		}

		private function initz( event : Event ) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initz);
			
			initEngine();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			
			_camCon = new Control_Cam(this.stage, view);
			
			_model = new DataModel();
			_model.loadXML("xml/main.xml");
			
			_viewNavi = new ViewStore(this.stage, view);
			_viewNavi.modelData = _model;
			this.addChild(_viewNavi);
			
			_viewProduct = new ViewProduct(this.stage, view);
			this.addChild(_viewProduct);
			
			
			_viewDetails = new ViewDetails(this.stage, view);
			_viewDetails.cart = _cart;
			this.addChild(_viewDetails);
			
			addChild(new AwayStats(view, true, true));
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		private function initEngine() : void {

			scene = new Scene3D();

			camera = new Camera3D();
			camera.y = 100;
			camera.z = -600;
			camera.lookAt(new Vector3D(0.1, -250, 0));

			view = new View3D();
			view.width = 900;
			view.height = 700;
			view.antiAlias = 4;
			view.scene = scene;
			view.camera = camera;
			
			addChild(view);
			
		}
		
		private function onEnterFrame( event : Event ) : void {
			_camCon.loop();
			_viewProduct.loop();
			view.render();
		}
		
		
	}
}
