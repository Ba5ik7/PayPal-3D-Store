package com.wesley.Object {
	/**
	 * @author wesley
	 */
	public class ObjPro {
		
		public var name : String;
		public var type : String;
		public var price : String;
		public var description : String;
		public var sizes : Array;
		
		

		public var imgObjs : Array = new Array();
		
		
		public function ObjPro (_name : String, _type : String, _price : String, _description : String, _sizes : String) {
			name = _name;
			type = _type;
			price = _price;
			description = _description;
			
			sizes = getArrayFromString(_sizes);
			
		}
		
		private function getArrayFromString(str:String):Array {
        	return str.split(/\W | ' | /gi);
   		}
		
		
	}
}
