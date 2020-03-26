enum AbstractionKind {
  LexicalStructure,
  BasicConcepts,
  Types,
  Expressions,
  Statements,
  Namespaces,
  Class,
  Interface,
}

abstract class Abstraction {

  Abstraction(this._value, this._kind);

  final String _value;
  final AbstractionKind _kind;

  String get value {
    return _value;
  }

  AbstractionKind get kind {
    return _kind;
  }
}
