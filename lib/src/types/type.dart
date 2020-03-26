enum TypeKind {
  ReferenceType,
  TypeParameter,
  ValueType,
}

abstract class Type {

  Type(this._value);

  final String _value;

  String get value {
    return _value;
  }
}
