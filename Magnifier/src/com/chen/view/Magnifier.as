package com.chen.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	public class Magnifier extends UIComponent
	{
		private var _zoomTargetCopy:Bitmap;
		private var zoomTargetCopyData:BitmapData;
		
		private var _zoomTarget:UIComponent;
		
		private var _zoom:Number=1;
		public function Magnifier()
		{
			super();
		}
		
		public function get zoom():Number
		{
			return _zoom;
		}
		
		public function set zoom(value:Number):void
		{
			_zoom = value;
		}
		
		public function get zoomTarget():UIComponent
		{
			return _zoomTarget;
		}
		
		public function set zoomTarget(value:UIComponent):void
		{
			if(_zoomTarget){
				_zoomTarget.removeEventListener(MouseEvent.MOUSE_MOVE,zoomTargetOnMouseMove);
			}
			_zoomTarget = value;
			if(_zoomTarget){
				_zoomTarget.addEventListener(MouseEvent.MOUSE_MOVE,zoomTargetOnMouseMove);	
			}
		}
		
		private function zoomTargetOnMouseMove(event:MouseEvent):void
		{
			var moveX:int= _zoomTarget.mouseX;
			var moveY:int= _zoomTarget.mouseY;
			
			if(zoomTargetCopyData){
				zoomTargetCopyData.dispose();
			}
			
			var w:Number=_zoomTarget.width;
			var h:Number=_zoomTarget.height;
			
			var s:Number=w/h;
			
			if(this.width>this.height){
				w=this.width;
				h=this.width/s;
			}else{
				h=this.height;
				w=this.height*s;
			}
			
			
			zoomTargetCopyData=new BitmapData(w,h,true,0x000000);
			var matrix:Matrix=new Matrix();
			matrix.translate(-moveX,-moveY);
			matrix.scale(_zoom,_zoom);
			matrix.translate(0.5*this.width,0.5*this.height);
			var sourceRect:Rectangle = new Rectangle(0,0,width,height);
			zoomTargetCopyData.draw(_zoomTarget,matrix,null,null,sourceRect,true);
			
			zoomTargetCopy.bitmapData=zoomTargetCopyData;
		}
		
		public function get zoomTargetCopy():Bitmap
		{
			if(!_zoomTargetCopy){
				_zoomTargetCopy=new Bitmap();
			}
			return _zoomTargetCopy;
		}
		
		protected override function createChildren():void
		{
			super.createChildren();
			this.addChild(zoomTargetCopy);
		}
		
		
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var g:Graphics=this.graphics;
			g.clear();
			g.beginFill(0x000000);
			g.drawRect(0,0,this.width,this.height);
			g.endFill();
		}
		
		
	}
}