import 'dart:io';

import '../node.dart';

class NamespaceNode implements Node {
  
  NamespaceNode(
    this._value,
    this._children
  ): super();

  static final NodeType _type = NodeType.namespaceLiteral;
  final String _value;
  final List<Node> _children;

  @override 
  NodeType get type {
    assert(_type == NodeType.namespaceLiteral);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  List<Node> get children {
    return _children;
  }
}