package
{
	import com.eyu.scene.resCenter.ItemData;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.utils.StringUtil;
	
	public class testenc extends Sprite
	{
		
		private var callList:Object;
		private var loader:URLLoader;
		private var point :Point;
		public function testenc()
		{
			
			this.callList = new Object();
			this.point = new Point();
			doload(fuckurl);		}
		
		private const HERO_ACTIONS:Array = ["ATTACK1", "ATTACK2", "FSTAND", "RUN"];
		private const MAJOR_ACTIONS:Array = ["ATTACK1", "ATTACK2", "ATTACK4", "ATTACK5", "FSTAND", "RUN", "REPLACE"];
		private const MONKEY_ACTIONS:Array = ["ATTACK1", "ATTACK2", "ATTACK3", "ATTACK4", "ATTACK5", "FSTAND", "RUN"];
		
		private var urlPat:String =  'http://wscdn.ah.9yuonline.com/ver110/resource/dynamicRes/role/hero/400111/{0}.9yur?8012';
		private var fuckurl:String = 
			'http://wscdn.ah.9yuonline.com/ver110/resource/dynamicRes/role/monster/600001/run.9yur?7663';
		
		private function doLoadList():void
		{
			for (var i:int = 0; i < MONKEY_ACTIONS.length; i++) 
			{
				var tmpURL:String = StringUtil.substitute(urlPat,		MONKEY_ACTIONS[i]);
				doload(tmpURL.toLocaleLowerCase());
			}
			
			

		}
		private function doload($url):void
		{
			// TODO Auto Generated method stub
			loader = new URLLoader();
			loader.load(new URLRequest($url));
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE,onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onIO);
		}
		
		protected function onIO(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace(event.text);
		}
		
		private function show($bmd:BitmapData):void
		{
//			import flash.filesystem.*;
//			
//			
//			var file:File = File.documentsDirectory;
//			file = file.resolvePath("Apollo Test/111.air");
//			var fileStream:FileStream = new FileStream();
//			fileStream.open(file, FileMode.WRITE);
//			fileStream.writeBytes(output);
//			trace('fuck');
//			fileStream.close();
			
			var bmp:Bitmap = new Bitmap($bmd.clone());
			addChild(bmp);
		}
		
		protected function onComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			trace(event);
			var data:ByteArray = loader.data;

			try
			{
				data.uncompress();
			}
			catch (error:Error)
			{
			}
			var res:* = data.readObject();
			trace(res);
			
			decodeRes(res,fuckurl);
//			var obj = SwfEnDeUtil.getDecryptDataByByteArray(data,SwfEnDeUtil.keyCode);
//			for each (var key:String in obj) 
//			{
//				trace(key);
//			}
			
			trace(res);
		}
		
		
		private function save(dir:String,name:String,ba:ByteArray):void
		{
			
			var file:File = File.documentsDirectory;
			file = file.resolvePath("暗黑西游记/"+dir+'/'+name);
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(ba);
			trace('save'+file.url);
			fileStream.close();
		}
		private function decodeRes($resObject:Object, $url:String) : void
		{
			var alpha:BitmapData;
			var pixels:BitmapData;
			var decodeAlpha:Function;
			var decodePixels:Function;
			var res:* = $resObject;
			var url:* = $url;
			decodeAlpha = function (param1:BitmapData) : void
			{
				
				if (param1.width > 1 && param1.height > 1)
				{
					alpha = param1;
					decodeByteData(res.pixels, decodePixels);
				}
				return;
			}// end function
				;
			decodePixels = function (param1:BitmapData) : void
			{
				if (param1.width > 1 && param1.height > 1)
				{
					pixels = param1;
					getPackData(alpha, pixels, res.xml, url);
				}
				return;
			}// end function
				;
			if (res)
			{
				this.decodeByteData(res.alpha, decodeAlpha);
			}
			return;
		}// end function
		
		
		private function dogetPackData($alphaBMD:BitmapData, $pixelsBMD:BitmapData, $desc:XML, $url:String) : void
		{
			var newData:BitmapData = null;
			newData = new BitmapData($alphaBMD.width, $alphaBMD.height, true, 0);
			newData.copyPixels($pixelsBMD, new Rectangle(0,0,$pixelsBMD.width,$pixelsBMD.height), new Point(0,0), null, null, true);
			newData.copyChannel($alphaBMD,  new Rectangle(0,0,$pixelsBMD.width,$pixelsBMD.height), new Point(0,0), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
			
			show(newData);
			var png:ByteArray = PngEncoder.encode(newData);
			var dataA:Array  = $url.split('/');
			var hid:String = dataA[dataA.length-2];
			var type:String = String(dataA[dataA.length-1]).split('.')[0];
			trace(hid,type);
			
			save(hid,type+'.png',png);
			var desc:ByteArray = new ByteArray();
			desc.writeUTFBytes($desc.toXMLString());
			save(hid,type+'.xml',desc);
			
		}
		
		private function decodeByteData(param1:ByteArray, param2:Function) : void
		{
			var decoder:Loader;
			var onDecodeComplete:Function;
			var data:* = param1;
			var callFun:* = param2;
			onDecodeComplete = function (event:Event) : void
			{
				var _loc_2:* = (decoder.content as Bitmap).bitmapData;
				decoder.contentLoaderInfo.removeEventListener(Event.COMPLETE, onDecodeComplete);
				decoder.unload();
				decoder = null;
				callFun(_loc_2);
				return;
			}// end function
				;
			decoder = new Loader();
			decoder.contentLoaderInfo.addEventListener(Event.COMPLETE, onDecodeComplete);
			decoder.loadBytes(data);
			return;
		}// end function
		
		
		
		private function getPackData($alphaBMD:BitmapData, $pixelsBMD:BitmapData, $desc:XML, $url:String) : void
		{
			var _loc_5:* = this.analyData($desc, $pixelsBMD, $alphaBMD);
			$alphaBMD.dispose();
			$pixelsBMD.dispose();
			this.funListCall($url, _loc_5);
			return;
		}// end function
		
		private function analyData($desc:XML, $pixelsBMD:BitmapData, $alphaBMD:BitmapData) : ItemData
		{
			var _loc_10:XMLList = null;
			var _descType:* = $desc.@type;
			var _descView:* = $desc.@view;
			var _descAction:* = $desc.@action;
			var _itemData:* = new ItemData();
			_itemData.type = _descType;
			_itemData.view = _descView;
			_itemData.action = _descAction;
			_itemData.roleType = $desc.@roleType;
			_itemData.nameX = $desc[_descAction].@nameX;
			_itemData.nameY = $desc[_descAction].@nameY;
			_itemData.speed = $desc[_descAction].@speed;
			_itemData.roleSet = $desc[_descAction].@roleSet;
			var _layerSet:Object = {};
			//            {}.down = param1[_loc_6].down.@layerSet.toString();
			_layerSet.rDown = $desc[_descAction].rDown.@layerSet.toString();
			_layerSet.right = $desc[_descAction].right.@layerSet.toString();
			_layerSet.rUp = $desc[_descAction].rUp.@layerSet.toString();
			_layerSet.up = $desc[_descAction].up.@layerSet.toString();
			_itemData.layerSet = _layerSet;
			var _offset:Object = {};
			//            {}.down = param1[_loc_6].down.@roleSet.toString();
			_offset.rDown = $desc[_descAction].rDown.@roleSet.toString();
			_offset.right = $desc[_descAction].right.@roleSet.toString();
			_offset.rUp = $desc[_descAction].rUp.@roleSet.toString();
			_offset.up = $desc[_descAction].up.@roleSet.toString();
			_itemData.offset = _offset;
			if (_descView == "one")
			{
				_loc_10 = $desc[_descAction].right;
				if (_loc_10.length())
				{
					_itemData.right = this.getItemFrames($desc[_descAction].right.frame, $pixelsBMD, $alphaBMD);
				}
				else
				{
					_itemData.right = this.getItemFrames($desc[_descAction].frame, $pixelsBMD, $alphaBMD);
				}
			}
			else
			{
				_itemData.down = this.getItemFrames($desc[_descAction].down.frame, $pixelsBMD, $alphaBMD);
				_itemData.rDown = this.getItemFrames($desc[_descAction].rDown.frame, $pixelsBMD, $alphaBMD);
				_itemData.right = this.getItemFrames($desc[_descAction].right.frame, $pixelsBMD, $alphaBMD);
				_itemData.rUp = this.getItemFrames($desc[_descAction].rUp.frame, $pixelsBMD, $alphaBMD);
				_itemData.up = this.getItemFrames($desc[_descAction].up.frame, $pixelsBMD, $alphaBMD);
			}
			return _itemData;
		}// end function
		
		
		private function getItemFrames(param1:XMLList, param2:BitmapData, param3:BitmapData) : Array
		{
			var _loc_7:XML = null;
			var _loc_8:Object = null;
			var _loc_9:BitmapData = null;
			var _loc_4:Array = [];
			var _loc_5:* = new Point();
			var _loc_6:* = new Rectangle();
			for each (_loc_7 in param1)
			{
				
				_loc_8 = {};
				_loc_8.id = _loc_7.@id.toString();
				_loc_8.w = int(_loc_7.@w);
				_loc_8.h = int(_loc_7.@h);
				_loc_8.bx = int(_loc_7.@bx);
				_loc_8.by = int(_loc_7.@by);
				_loc_6.x = int(_loc_7.@x);
				_loc_6.y = int(_loc_7.@y);
				_loc_6.width = _loc_8.w;
				_loc_6.height = _loc_8.h;
				if (_loc_6.width == 0 || _loc_6.height == 0)
				{
					_loc_9 = new BitmapData(1, 1, true, 0);
				}
				else
				{
					_loc_9 = new BitmapData(_loc_8.w, _loc_8.h, true, 0);
					_loc_9.copyPixels(param2, _loc_6, _loc_5, null, null, true);
					_loc_9.copyChannel(param3, _loc_6, _loc_5, BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
				}
				_loc_8.bmd = _loc_9;
				
				_loc_4[_loc_4.length] = _loc_8;
			}
			_loc_4.sortOn("id");
			return _loc_4;
		}// end function
		
		/**
		 * 队列调用 
		 * @param param1
		 * @param param2
		 * 
		 */		
		private function funListCall(param1:String, param2:ItemData) : void
		{
			var _loc_4:Function = null;
			var _loc_3:* = this.callList[param1];
			for each (_loc_4 in _loc_3)
			{
				
				_loc_4(param2, param1);
			}
			this.callList[param1] = null;
			delete this.callList[param1];
			return;
		}// end function
	}
}