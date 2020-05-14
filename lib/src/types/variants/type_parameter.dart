import 'package:cs2dart/src/types/type.dart';

class TypeParameter implements Type {
  TypeParameter(this._value);

  final List _value;

  List get value {
    return _value;
  }

  TypeKind get type{
    return _type;
  }
 static final TypeKind _type = TypeKind.typeParameter;
}
