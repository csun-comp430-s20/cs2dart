import 'package:cs2dart/src/types/type.dart';

import '../value_type.dart';



class FloatingPointType implements Type {
  FloatingPointType(this._value);

  final List _value;

  List get value {
    return _value;
  }

  ValueTypeKind get type{
    return _type;
  }
  static final ValueTypeKind _type = ValueTypeKind.floatingPointType;
}
