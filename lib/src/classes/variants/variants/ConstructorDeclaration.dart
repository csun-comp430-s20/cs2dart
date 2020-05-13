
import '../ClassBody.dart';
import '../../classAST.dart';

class ConstructorDeclaration implements ClassAST{
  ConstructorDeclaration(this._value);
  List _value;

  List get value {
    return _value;
  }

  ClassBodyKind get type{
    return _type;
  }
  static final ClassBodyKind _type = ClassBodyKind.constructorDeclaration;
}