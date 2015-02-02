package com.chen.model {

/**
 *  @private
 */
public interface IEdge {

	function getLength(): int;

	function getFrom(): Node;

	function getTo(): Node;
}
}