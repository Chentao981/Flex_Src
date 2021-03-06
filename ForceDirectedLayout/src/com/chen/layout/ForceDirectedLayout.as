package com.chen.layout
{
	import com.chen.model.IEdge;
	import com.chen.model.Node;
	import com.chen.ui.MyVis;
	
	public class ForceDirectedLayout
	{
		private var _vis:MyVis;
		
		public var damper: Number=0.0;
		public var maxMotion: Number=0;
		public var lastMaxMotion: Number=0;
		public var motionRatio: Number = 0;
		public var rigidity: Number = 0.5;
		
		public var maxMotionA: Number;
		public static var motionLimit: Number = 1.5;
		
		public function ForceDirectedLayout(vis:MyVis)
		{
			_vis=vis;
		}
		
		
		public function resetDamper(): void {
			damper = 1.0;
		}
		
		public function compute():void{
			resetDamper();
			while(!(damper<0.1 && maxMotion<motionLimit)){
				relaxEdges();
				avoidLabels();
				moveNodes();	
				trace("relax:"+(!(damper<0.1 && maxMotion<motionLimit))+" damper:"+damper+" maxMotion:"+maxMotion+" motionLimit:"+motionLimit);
			}
		}
		
		
		private  function relaxEdges(): void {
			for each (var e: IEdge in _vis.edges) {
				var vx: Number = e.getTo().x - e.getFrom().x;
				var vy: Number = e.getTo().y - e.getFrom().y;
				var len: Number = Math.sqrt(vx * vx + vy * vy);
				
				var dx: Number=vx*rigidity;
				if(isNaN(dx)) {
					dx = dx;
				}
				var dy: Number=vy*rigidity;
				if(isNaN(dy)) {
					dy = dy;
				}
				
				dx /=(e.getLength()*100);
				if(isNaN(dx)) {
					dx = dx;
				}
				
				dy /=(e.getLength()*100);
				if(isNaN(dy)) {
					dy = dy;
				}
				
				e.getTo().dx = e.getTo().dx - dx*len;
				e.getTo().dy = e.getTo().dy - dy*len;
				
				e.getFrom().dx = e.getFrom().dx + dx*len;
				e.getFrom().dy = e.getFrom().dy + dy*len;
			}
		}
		
		private  function avoidLabels(): void {
			for each (var n1: Node in _vis.nodes) {
				for each (var n2: Node in _vis.nodes) {
					if(n1 != n2) {
						var dx: Number=0;
						var dy: Number=0;
						var vx: Number = n1.x - n2.x;
						var vy: Number = n1.y - n2.y;
						var len: Number = vx * vx + vy * vy;
						if (len == 0) {
							dx = Math.random();
							dy = Math.random();
						} else if (len < 360000) {
							dx = vx / len;
							dy = vy / len;
						}
						var repSum: Number = n1.repulsion * n2.repulsion/100;
						var factor: Number = repSum*rigidity;
						n1.dx += dx*factor;
						n1.dy += dy*factor;
						n2.dx -= dx*factor;
						n2.dy -= dy*factor;
					}
				}
			}
		}
		
		private function moveNodes(): void {
			lastMaxMotion = maxMotion;
			maxMotionA=0;
			for each (var n: Node in _vis.nodes) {
				var dx: Number = n.dx;
				var dy: Number = n.dy;
				dx*=damper; 
				dy*=damper;
				n.dx = dx/2;
				n.dy = dy/2;
				var distMoved: Number = Math.sqrt(dx*dx+dy*dy);
				var dxy:int=150;
				n.x = n.x + Math.max(-dxy, Math.min(dxy, dx));
				n.y = n.y + Math.max(-dxy, Math.min(dxy, dy));
				maxMotionA=Math.max(distMoved,maxMotionA);
			}
			
			maxMotion=maxMotionA;
			
			if (maxMotion>0) 
			{	
				motionRatio = lastMaxMotion/maxMotion-1;
			}
			else{
				motionRatio = 0;
			}
			damp();
		}
		
		
		public function damp(): void {
			if(motionRatio<=0.001) {
				
				if ((maxMotion<0.2 || (maxMotion>1 && damper<0.9)) && damper > 0.01)
				{ 
					damper -= 0.01;
				}
				else if (maxMotion<0.4 && damper > 0.003) 
				{	
					damper -= 0.003;
				}
				else if(damper>0.0001) 
				{	
					damper -=0.0001;
				}
			}
			if(maxMotion<motionLimit) {
				damper=0;
			}
		}
	}
}