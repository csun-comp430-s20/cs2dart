import 'package:cs2dart/src/types/type.dart';

class ReferenceType implements Type {
  ReferenceType(this._value);

  final List _value;

  List get value {
    return _value;
  }

  TypeKind get type{
    return _type;
  }
 static final TypeKind _type = TypeKind.referenceType;
}
