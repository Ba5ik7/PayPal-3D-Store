package com.wesley.compontents {
	import flash.geom.Vector3D;
	import com.greensock.TweenMax;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.utils.Cast;
	import away3d.events.MouseEvent3D;
	import away3d.primitives.CubeGeometry;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.containers.ObjectContainer3D;
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
	public class BTN_Category3D extends ObjectContainer3D {
		
		
		
		public var txtFl : TextField;
		
		private var _txt : String;
		private var _width : int = 175;
		private var _height : int = 50;
		private var _tf : TextFormat;
		private var _productData : Array;
		private var _evt : BtnEvent;
		private var _stage : Stage;
		
		private var _cube : Mesh;
		public var mat:ColorMaterial = new ColorMaterial(0x333333, 1); //ed0b81

		

		public function BTN_Category3D(stageW : Stage, text : String, productData : Array) {
			_stage  = stageW;
			_txt = text;
			_productData = productData;
			
			//this.addEventListener(MouseEvent.CLICK, click);
			
			
			/*this.graphics.lineStyle(1, 0xff0000);	
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
			addChild(txtFl);*/
			
			_cube = new Mesh(new CubeGeometry(150, 50, 50, 1, 1, 1, false), mat);			
			this.addChild ( _cube);
			
			_cube.mouseEnabled = true;
			_cube.addEventListener(MouseEvent3D.MOUSE_DOWN, click);
			
		}
		
		
		
		
		
		
		
		private function click( event : MouseEvent3D ) : void {
			//var ram : Vector3D = new Vector3D(Math.floor(Math.random()*250+250), Math.floor(Math.random()*250+250), Math.floor(Math.random()*250+250));
			//TweenMax.to(_cube, 1, {x:250, y:Math.floor(Math.random()*250+100), z:250,  repeat:1, yoyo:true});
			
			_evt = new BtnEvent("btnCategoryClick");
			_evt.data = _productData;
			_stage.dispatchEvent(_evt);
		}
			


	}
}
