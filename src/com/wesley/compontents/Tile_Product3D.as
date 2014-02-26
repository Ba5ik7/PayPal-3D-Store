package com.wesley.compontents {
	
	import flash.display.Stage;
	import away3d.events.MouseEvent3D;
	import away3d.utils.Cast;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import com.wesley.Object.ObjPro;
	import com.wesley.events.BtnEvent;

	
	
	/**
	 * @author wesley
	 */
	public class Tile_Product3D extends ObjectContainer3D {
		//public var txtFl : TextField;
		public var futureX : Number;
		public var futureY : Number;
		public var futureZ : Number;
		
		private var _stage : Stage;	
		

		private var _txt : String;
		private var _evt : BtnEvent;
		private var _itemData : ObjPro;
		
		
		private var _cube : Mesh;
		public var _cubeMaterial:TextureMaterial;
		

		public function Tile_Product3D(stage:Stage,itemData:ObjPro, txt : String) {
			_itemData = itemData;
			_txt = txt;
			_stage = stage;


			_cubeMaterial = new TextureMaterial(Cast.bitmapTexture(_itemData.imgObjs[0].img.bitmapData));
			_cubeMaterial.mipmap = false;
			_cube = new Mesh(new CubeGeometry(150, 150, 50, 1, 1, 1, false), _cubeMaterial);			
			this.addChild ( _cube);
			_cube.mouseEnabled = true;
			_cube.extra = {};
			_cube.addEventListener(MouseEvent3D.MOUSE_DOWN, click);

		}

		private function click( event : MouseEvent3D ) : void {
			_evt = new BtnEvent("btnProductClick");
			_evt.data = _itemData;
			_evt.posData = this.position;
			_evt.cube = _cube;
			_stage.dispatchEvent(_evt);
		}
		
		
	}
}

