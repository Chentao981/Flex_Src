package com.chen.ui
{
	import com.chen.layout.ForceDirectedLayout;
	import com.chen.model.IEdge;
	import com.chen.model.Node;
	
	import flash.display.Graphics;
	import flash.utils.getTimer;
	
	import mx.containers.Canvas;
	
	public class MyVis extends Canvas
	{
		
		private var _nodes:Array;
		private var _edges:Array;
		
		private var myLayout:ForceDirectedLayout;
		
		public function MyVis()
		{
			super();
			myLayout=new ForceDirectedLayout(this);
		}
		
		
		public function get nodes():Array
		{
			return _nodes;
		}
		
		public function set nodes(value:Array):void
		{
			_nodes = value;
		}
		
		public function get edges():Array
		{
			return _edges;
		}
		
		public function set edges(value:Array):void
		{
			_edges = value;
		}
		
		
		public function runLayout():void{
			
			var startTime:Number=getTimer();
			
			myLayout.compute();
			
			var endTime:Number=getTimer();
			
			trace("总计算时间："+(endTime-startTime));
			
			this.invalidateDisplayList();
		}
		
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			var g:Graphics=this.graphics;
			g.clear();
			
			for each( var edge:IEdge in edges ){
				drawLine(edge,g);
			}

			for each(var node:Node in nodes){
				drawNode(node,g);
			}
		}
		
		
		
		protected function drawNode(node:Node,g:Graphics):void{
			
			g.beginFill(0xFF0000);
			g.drawCircle(node.x,node.y,10);
			g.endFill();
		}
		
		
		
		protected function drawLine(edge:IEdge,g:Graphics):void{
			g.lineStyle(1,0x000000);;
			g.moveTo(edge.getFrom().x,edge.getFrom().y);
			g.lineTo(edge.getTo().x,edge.getTo().y);
		}
		
	}
}