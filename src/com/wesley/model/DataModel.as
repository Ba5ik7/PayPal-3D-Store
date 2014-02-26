package com.wesley.model {
	import flash.display.Stage;
	import com.wesley.events.ModelEvent;
	import com.wesley.Object.ObjImg;
	import com.wesley.Object.ObjPro;
	import com.wesley.Object.ObjCat;
	import com.wesley.model.Model;

	import flash.events.IEventDispatcher;
	import flash.events.Event;

	/**
	 * @author wesley
	 */
	public class DataModel extends Model {

		private var _dataList : XMLList = new XMLList();
		
		private var _catObj : ObjCat = new ObjCat();
		
		private var _whatToLoad : int;
		private var _imgHaveLoad : int;
		
		
		public function DataModel(target : IEventDispatcher = null) {
			super(target);
		}
		
		override protected function xmlReady() : void {
			_dataList = data.store.category;
			
			var i : int;
			var j : int;
			var k : int;
			var tempNum : int;
			for (i = 0; i < _dataList.length(); ++i) {
				var objCat : ObjCat = new ObjCat();
				objCat.name = _dataList[i].@name;
				
				_dataList = _dataList[i].product;
				for (j = 0; j < _dataList.length(); ++j) {

					var objPro : ObjPro = new ObjPro(_dataList[j].@name,
														_dataList[j].@type,
														_dataList[j].@price,
														_dataList[j].description,
														_dataList[j].size);
														

					tempNum = _dataList[j].picture.length();
					_whatToLoad += tempNum;
					for (k = 0; k < tempNum; ++k) {
						var objImg : ObjImg = new ObjImg(_dataList[j].picture[k], _dataList[j].picture[k].@color);
						objImg.addEventListener(ModelEvent.IMAGE_READY, imgHasLoad);
						
						objPro.imgObjs.push( objImg );
					}
					
					objCat.productArray.push(objPro);
				}
				_dataList = data.store.category;
				
				allData.push(objCat);
			}
				
		}
		
		
		private function imgHasLoad ( event : ModelEvent ) : void {
			++_imgHaveLoad;
			if ( _imgHaveLoad >= _whatToLoad ) {
				this.dispatchEvent(new ModelEvent(ModelEvent.MODEL_COMPLETE));
			}
				
			
		}
		
		
		
	}
}
