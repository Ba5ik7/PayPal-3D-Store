package com.wesley.view {
	import flash.display.DisplayObject;
	import com.greensock.TweenMax;
	import away3d.containers.View3D;
	import flash.events.MouseEvent;
	import com.wesley.compontents.BTN_Generic;
	import flash.display.Bitmap;
	import com.wesley.Object.ObjPro;
	import com.wesley.compontents.ComboBox.ComboBox;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.display.Sprite;
	import com.wesley.events.BtnEvent;
	import com.wesley.view.View;
	import flash.display.Stage;

	/**
	 * @author wesley
	 */
	public class ViewDetails extends View {

		private var _con : Sprite;
		private var _tf : TextFormat;
		private var _name : TextField;
		private var _price : TextField;
		private var _description : TextField;
		private var _comboSize : ComboBox;
		private var _comboColor : ComboBox;
		private var _addBtn : BTN_Generic = new BTN_Generic("Add To Cart", 22, 0xff00, 150, 50, 0x000000, 1, 0xFF0000);
		private var _backBtn : BTN_Generic = new BTN_Generic("Back", 22, 0xff00, 125, 50, 0x000000, 1, 0xFF0000);
		private var _objPro : ObjPro;
		private var _tempBit : Bitmap;
		private var _evt : BtnEvent;

		
		
		public var i : int;
		public function ViewDetails (_stage : Stage, _stage3D : View3D) {
			super(_stage, _stage3D);
			_con = new Sprite();
			_con.alpha = 0;
			
			_Stage.addEventListener(BtnEvent.BTNCOLORCLICK, updateImageColor);
			
			createTextFields();
			
			_backBtn.x = 20;
			_backBtn.y = 50;
			_backBtn.addEventListener(MouseEvent.CLICK, hide);
			_con.addChild(_backBtn);
			
			_addBtn.x=20;
			_addBtn.y=450;
			_addBtn.addEventListener(MouseEvent.CLICK, addToCart);
			_con.addChild(_addBtn);
		}

		private function addToCart(event : MouseEvent) : void {
			cart.addToCart(_objPro, "test");
			trace("Just added to the Cart!" + cart.cart);
		}
		
		
		

		private function createTextFields() : void {
			_tf = new TextFormat(null, 42, 0xff0000);
			_price = new TextField();
			_price.embedFonts = false;
			_price.defaultTextFormat = _tf;
			_price.antiAliasType = AntiAliasType.ADVANCED;
			_price.text = "$24";
			_price.selectable = false;
			_price.x = 752;
			_price.y = 300;
			
			_tf = new TextFormat(null, 24, 0xffffff);
			_name = new TextField();
			_name.embedFonts = false;
			_name.defaultTextFormat = _tf;
			_name.antiAliasType = AntiAliasType.ADVANCED;
			_name.text = "Name Test";
			_name.width = 250;
			_name.selectable = false;
			_name.x = 550;
			_name.y = 345;
			
			_tf = new TextFormat(null, 14, 0xffffff);
			_description = new TextField();
			_description.embedFonts = false;
			_description.defaultTextFormat = _tf;
			_description.antiAliasType = AntiAliasType.ADVANCED;
			_description.text = "Description Test";
			_description.width = 250;
			_description.height = 200;
			_description.multiline = true;
			_description.wordWrap = true;
			_description.selectable = false;
			_description.x = 550;
			_description.y = 370;
			
			_con.addChild(_price);
			_con.addChild(_name);
			_con.addChild(_description);
		}
		
		override protected function updateDetailView ( event : BtnEvent ) : void {
			if (_tempBit) { _con.removeChild(_tempBit); _tempBit = null;}	
			
			_objPro = event.data;
			_price.text = "$" + _objPro.price;
			_name.text = _objPro.name;
			_description.text = _objPro.description;
			
			
			_tempBit = new Bitmap(_objPro.imgObjs[0].img.bitmapData);
			_tempBit.x = 550;
			_con.addChild(_tempBit);
			

			if (_comboColor) {_con.removeChild(_comboColor);}
			
			_comboColor = new ComboBox(_Stage, "Colors", _objPro.imgObjs);
			_comboColor.x = 575;
			_comboColor.y = 275;
			_con.addChild(_comboColor);
			
			
			if (_comboSize) {_con.removeChild(_comboSize);}
			_comboSize = new ComboBox(_Stage, "Size", _objPro.sizes);
			_comboSize.x = 575;
			_comboSize.y = 250;
			_con.addChild(_comboSize);
			
			
			this.addChild(_con);
			TweenMax.to(_con, 1, {alpha:1});
		}
		
		
		private function hide ( event : MouseEvent) : void {
			TweenMax.to(_con, 1, {alpha:0, onComplete:removeFromDisplayList});
			_evt = new BtnEvent("btnBackClick");
			stage.dispatchEvent(_evt);
		}

 		private function removeFromDisplayList():void {
  			removeChild(_con);
 		}

		private function updateImageColor( event : BtnEvent ) : void {
			if (_tempBit) {  TweenMax.to(_tempBit, .3, {alpha:0,  onComplete:cleanImage, onCompleteParams:[event]}); }
		}
		
		private function cleanImage ( event : BtnEvent ) : void {
			_con.removeChild(_tempBit);
			_tempBit = new Bitmap(event.data.objImg.img.bitmapData);
			_tempBit.alpha =0;
			_tempBit.x = 550;
			_con.addChild(_tempBit);
			TweenMax.to(_tempBit, .3, {alpha:1});
		}
		
		
	}
}
