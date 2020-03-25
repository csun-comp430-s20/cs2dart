enum NodeType {
  typeLiteral,
  expressionLiteral,
  statementLiteral,
  namespaceLiteral,
  classLiteral,
  interfaceLiteral,
}

abstract class Node {

  Node(
    this._type,
    this._value,
    this._children
  );

  final NodeType _type;
  final String _value;
  final List<Node> _children;


  NodeType get type {
    return _type;
  }

  String get value {
    return _value;
  }

  List<Node> get children {
    return _children;
  }
}