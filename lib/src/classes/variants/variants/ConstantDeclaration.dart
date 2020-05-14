import '../ClassBody.dart';
import '../../classAST.dart';

class ConstantDeclaration implements ClassAST{
  ConstantDeclaration(this._value);
  List _value;

  List get value {
    return _value;
  }

  ClassBodyKind get type{
    return _type;
  }
  static final ClassBodyKind _type = ClassBodyKind.constantDeclaration;
}