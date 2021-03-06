import 'package:cs2dart/src/types/type.dart';

import '../value_type.dart';



class IntegralType implements ValueType {
  IntegralType(this._value);

  final List _value;

  List get value {
    return _value;
  }

  ValueTypeKind get type{
    return _type;
  }
  static final ValueTypeKind _type = ValueTypeKind.integralType;
}
