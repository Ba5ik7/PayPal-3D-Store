package com.wesley.view {
	import flash.geom.Vector3D;
	import com.wesley.compontents.Scroller_Category3D;
	import away3d.containers.View3D;
	import com.wesley.compontents.Scroller_Category;
	import flash.display.Stage;
	import com.wesley.events.ModelEvent;
	import com.wesley.view.View;

	/**
	 * @author wesley
	 */
	public class ViewStore extends View {
		

		
		public function ViewStore( _stage : Stage, _stage3D : View3D ) {
			super(_stage, _stage3D);
		}
		
		
		override protected function modelComplete ( event : ModelEvent ) : void {
			/*for each(var cat : ObjCat in model.allData ) {
				trace(""+cat.name);
				for each(var pro : ObjPro in cat.productArray ) {
					trace(pro.name);
					for each(var img : ObjImg in pro.imgObjs ) {
						trace(img.url);
					}
				}
			}*/
			
			//var catScroller : Scroller_Category = new Scroller_Category(_Stage, model.allData);
			//addChild(catScroller);
			
			var catScroller3D : Scroller_Category3D = new Scroller_Category3D(_Stage, model.allData);
			catScroller3D.position = new Vector3D(-275,-75,-50);
			catScroller3D.rotationY = -25;
			_Stage3D.scene.addChild(catScroller3D);
			
			
			super.modelComplete(event);
			
		}
		
		
		
		
	}
}
