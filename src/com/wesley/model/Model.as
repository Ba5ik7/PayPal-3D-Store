package com.wesley.model {
	
	import flash.display.Loader;
	import com.wesley.events.ModelEvent;
	
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @author wesley
	 */
	public class Model extends EventDispatcher {
		
		
		public var allData : Array = new Array();
		
		private var _urlLoader : URLLoader;
		private var _req : URLRequest;
		private var _imageLoader : Loader;
		
		
		
		protected var data : XML;
		
		public function Model(target : IEventDispatcher = null) {
				
				
			super(target);
		}
		
		public function loadXML( req : String ) : void {
			_req = new URLRequest(req);
				
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, URLLOADER_IOERROR);
			_urlLoader.load(_req);
				
		}
		
		private function URLLOADER_IOERROR( event : IOErrorEvent ) : void {
			_urlLoader.removeEventListener(Event.COMPLETE, xmlLoaded);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, URLLOADER_IOERROR);
			_urlLoader = null;
			
			throw(new Error(event.target.data));
		}

		private function xmlLoaded( event : Event ) : void {
			data = new XML(event.target.data);
			_urlLoader.removeEventListener(Event.COMPLETE, xmlLoaded);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, URLLOADER_IOERROR);
			_urlLoader = null;
			
			xmlReady();
		}
		
		protected function xmlReady():void {
			dispatchEvent(new ModelEvent(ModelEvent.XML_READY));
		}
		
		
		

		//Image Loader**************************************************************//
		public function loadImage(urlRequest : String) : void {
			_imageLoader = new Loader();
			_imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			_imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IMAGELOADER_IOERROR);
			_imageLoader.load(new URLRequest(urlRequest));

		}
		
		protected function imageLoaded(event : Event) : void {
			event.target.removeEventListener(Event.COMPLETE, imageLoaded);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, IMAGELOADER_IOERROR);
			
		}

		private function IMAGELOADER_IOERROR(event : IOErrorEvent) : void {
			_imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageLoaded);
			_imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, IMAGELOADER_IOERROR);
			//_imageLoader = null;
			throw(new Error(" :( sorry happen with loading the image " + event.target + " " + event.target.content));
		}
		
	}
}
