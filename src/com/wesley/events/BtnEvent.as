package com.wesley.events {
	import flash.events.Event;

	/**
	 * @author wesley
	 */
	public class BtnEvent extends Event {
		public static var BTNCATEGORYCLICK : String = "btnCategoryClick";
		public static var BTNPRODUCTCLICK : String = "btnProductClick";
		public static var BTNCOLORCLICK : String = "btnColorCLick";
		public static var BTNADDCART : String = "btnAddCart";
		public static var BTNBACKCLICK : String = "btnBackClick";
		
		public var name : String = "";
		public var data : *;
		public var posData : *;
		public var cube : *;
		
		
		
		public function BtnEvent(type : String, bubbles : Boolean = true, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
