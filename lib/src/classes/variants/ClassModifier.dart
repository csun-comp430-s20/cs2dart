import '../classAST.dart';

class ClassModifier implements ClassAST{

  ClassModifier(this._value);
  List _value;

  List get value {
    return _value;
  }

  ClassKind get type{
    return _type;
  }
  static final ClassKind _type = ClassKind.classModifier;


}