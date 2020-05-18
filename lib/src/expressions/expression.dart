enum ExpKind {
  primaryExpression
}

abstract class Exp {

  Exp(this._value, this._kind);

  final List _value;
  final ExpKind _kind;
  
} 