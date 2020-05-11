import '../classAST.dart';

class ClassBody implements ClassAST{

  ClassBody(this._value);
  List _value;

  List get value {
    return _value;
  }

  ClassKind get type{
    return _type;
  }
  static final ClassKind _type = ClassKind.classBody;


}