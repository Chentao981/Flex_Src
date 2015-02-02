package com.chen.model {
	
	
	public class Node {
		
		public function Node(px:Number,py:Number): void {
		
			this._x=px;
			this._y=py;
		
		}
		
		private var _x: Number = 0;
		private var _y: Number = 0;
		private var _dx: Number = 0;
		private var _dy: Number = 0;
		
		public var repulsion: Number =40;
		
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			if(isNaN(value)) {
				value = value;
			}
			
			_y = value;
		}
		
		public function get dy():Number
		{
			return _dy;
		}
		
		public function set dy(value:Number):void
		{
			if(isNaN(value)) {
				value = value;
			}
			_dy = value;
		}
		
		
		
		public function set x(n: Number): void {
			if(isNaN(n)) {
				n = n;
			}
			
			_x = n;
		}
		public function get x(): Number {
			return _x;
		}
		
		public function set dx(n: Number): void {
			if(isNaN(n)) {
				n = n;
			}
			
			_dx = n;
		}
		public function get dx(): Number {
			return _dx;
		}
	}
}