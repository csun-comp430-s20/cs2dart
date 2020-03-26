import 'dart:io';

import '../node.dart';

class StatementNode implements Node {
  
  StatementNode(
    this._value,
    this._children
  ): super();

  static final NodeType _type = NodeType.statementLiteral;
  final String _value;
  final List<Node> _children;

  @override 
  NodeType get type {
    assert(_type == NodeType.statementLiteral);
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