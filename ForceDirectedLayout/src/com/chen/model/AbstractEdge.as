
package com.chen.model {
	
	public class AbstractEdge implements IEdge {
		
		public var from: Node;
		public var to: Node;
		
		public function AbstractEdge(f: Node, t: Node) {
			from = f;
			to = t;
		}
		
		
		public function getFrom(): Node {
			return from;
		}
		
		public function getTo(): Node {
			return to;
		}
		
		
		public function getLength(): int {
			return 20;
		}
	}
}