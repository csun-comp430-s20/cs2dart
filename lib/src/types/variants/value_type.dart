import 'package:cs2dart/src/types/type.dart';

enum ValueTypeKind{
  integralType,
  floatingPointType
}

class ValueType implements Type {
  ValueType(this._value);

  final List _value;

  List get value {
    return _value;
  }

  Object get type{
    return _type;
  }
  static final TypeKind _type = TypeKind.valueType;
}
