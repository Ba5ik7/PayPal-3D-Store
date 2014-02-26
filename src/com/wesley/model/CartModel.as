package com.wesley.model {
	import com.wesley.Object.ObjPro;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @author wesley
	 */
	public class CartModel extends EventDispatcher {
		
		public var	cart : Array = new Array();
		
		public function CartModel(target : IEventDispatcher = null) {
		
			super(target);
		
		}
		
		public function addToCart (objPro : ObjPro, objID : String) : Array {
			cart.push([objPro, objID]);
			return cart;	
		}
		
		
		
		
		
	
	
	
	}
}
