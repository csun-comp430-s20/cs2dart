enum TypeKind {
  referenceType,
  typeParameter,
  valueType,
}

abstract class Type {

  Type(this._value);

  final List _value;

  List get value {
    return _value;
  }
}
